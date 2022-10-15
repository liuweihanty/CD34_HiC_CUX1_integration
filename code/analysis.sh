#!bin/bash
# Before running this file, ensure you run `common_tasks.sh`.
# That file runs tasks that only need to be done once for all further analysis.

# ----- Inputs -----
CRPromotors=$1 # File with all the CUX1 bound promotors called by C&R
loops1=$2      # First set of loops
loops2=$3      # Second set of loops
zhangCSV=$4    # CSV conversion of the Zhang (2020) Excel spreadsheet

# ----- Overlap CUX1 bound promotors from CD34 C&R w/ the loops from Zhang et al. -----
bedtools intersect -a $loops1 -b $CRPromotors > 'BED_intersect_1.bed'
bedtools intersect -a $loops2 -b $CRPromotors > 'BED_intersect_2.bed'

# ----- Find the cis-regulatory elements (CREs) that correspond to the loops that have CUX1 bound promotors -----
# Convert BED files into CSVs
cat 'BED_intersect_1.bed' | tr '\t' ',' > 'BED_intersect_1_old.csv'
cat 'BED_intersect_2.bed' | tr '\t' ',' > 'BED_intersect_2_old.csv'
# Remove the first three characters of the files, which are `chr`, to make future comparisons easier
cut -c 4- 'BED_intersect_1_old.csv' > 'BED_intersect_1.csv'
cut -c 4- 'BED_intersect_2_old.csv' > 'BED_intersect_2.csv'
# Run the python script that will find, for each promoter region, the corresponding CRE
python3 '../find_CREs.py' $zhangCSV
# Convert CSV file into BED file
cat 'found_CREs.csv' | tr ',' '\t' > 'found_CREs_with_dup.bed'
# Add the `chr` characters back to the beginning of every line
sed -ne 's/.*/chr&/p' 'found_CREs_with_dup.bed' > 'found_CREs_with_chr.bed'
# Remove duplicate lines
cat 'found_CREs_with_chr.bed' | sort -r | uniq > 'found_CREs.bed'
# Delete temporary files
rm 'BED_intersect_1_old.csv' 'BED_intersect_2_old.csv' 'BED_intersect_1.csv' 'BED_intersect_2.csv' 'found_CREs.csv' 'found_CREs_with_chr.bed' 'found_CREs_with_dup.bed'

# ----- Find loops that do not contain an enhancer sequence we identified -----
# Keep only loops that do not contain any of the enhancers in the list of found enhancers
bedtools intersect -v -a $loops1 -b 'found_CREs.bed' > 'CREs_neg_1.bed'
bedtools intersect -v -a $loops2 -b 'found_CREs.bed' > 'CREs_neg_2.bed'
# Combine the two BED files
cat 'CREs_neg_1.bed' 'CREs_neg_2.bed' > 'loops_without_CREs_with_duplicates.bed'
# Remove any duplicate lines
awk '!a[$0]++' 'loops_without_CREs_with_duplicates.bed' > 'loops_without_CREs.bed'
# Delete temporary files
rm 'neg_1.bed' 'neg_2.bed' 'loops_without_CREs_with_duplicates.bed'

# ----- Use chromHMM to identify the precise enhancer sequences and not just the CREs they are in -----
# Intersection of ChromHMM and CREs
bedtools intersect -a '../../data/E050_18_core_K27ac_state_anno.bed' -b 'found_CREs.bed' > 'chromHMM_inter_CREs_temp.bed'
# Filter only enhancers
cat 'chromHMM_inter_CREs_temp.bed' | awk '/.*(E|e)nhancer.*/' > 'found_enhancers.bed'
# Filter only promoters
# FIXME: this doesn't work as it gets promoters from CREs while we want the corresponging promoters, which we can
# get from the Zhang (2020) Excel file
#cat 'chromHMM_inter_CREs_temp.bed' | awk '/.*(Active|Poised|Bivalent)( TSS).*/' > 'found_promoters.bed'
# Delete temporary files
rm 'chromHMM_inter_CREs_temp.bed'

# ----- Find loops that do not contain an enhancer sequence we identified using chromHMM -----
# Keep only loops that do not contain any of the enhancers in the list of found enhancers
bedtools intersect -v -a $loops1 -b 'found_enhancers.bed' > 'loops_without_enhancers_1.bed'
bedtools intersect -v -a $loops2 -b 'found_enhancers.bed' > 'loops_without_enhancers_2.bed'
# Combine the two BED files
cat 'loops_without_enhancers_1.bed' 'loops_without_enhancers_2.bed' > 'loops_without_enhancers_with_duplicates.bed'
# Remove any duplicate lines
awk '!a[$0]++' 'loops_without_enhancers_with_duplicates.bed' > 'loops_without_enhancers.bed'
# Delete temporary files
rm 'loops_without_enhancers_1.bed' 'loops_without_enhancers_2.bed' 'loops_without_enhancers_with_duplicates.bed'

# Regions of ChromHMM that do not contain enhancers
# Only on the loops without enhancers
#bedtools intersect -v -a  '../../data/E050_18_core_K27ac_state_anno.bed' -b 'found_CREs.bed' > 'chromHMM_inter_enhancers_no_interact.bed'

# ----- Compute interaction matrices -----
# Matrix for CREs
../compute_matrix.sh 'found_CREs.bed' 'matrix_CREs'
# Matrix for loops without CREs
../compute_matrix.sh 'loops_without_CREs.bed' 'matrix_loops_without_CREs'
# Matrix for enhancers
../compute_matrix.sh 'found_enhancers.bed' 'matrix_enhancers'
# Matrix for loops without enhancers
../compute_matrix.sh 'loops_without_enhancers.bed' 'matrix_loops_without_enhancers'

# ----- Heatmap of interacting enhancers -----
plotHeatmap \
	-m 'matrix_CREs.gz' \
	--missingDataColor 1 \
	--colorMap Blues \
	--whatToShow 'plot, heatmap and colorbar' \
	--dpi 200 \
	-out 'Heatmap_CREs.png'
