# Before running this file, ensure you run `common_tasks.sh`. That file runs tasks that only need to be done once for all further analysis.

sites=$1
loops1=$2
loops2=$3


# Overlap CUX1 bound promotors from CD34 C&R w/ short & long loops from Zhang et al.
bedtools intersect -a $loops1 -b $sites > 'BED_intersect_1.bed'
bedtools intersect -a $loops2 -b $sites > 'BED_intersect_2.bed'

# Find corresponding enhancers
cat BED_intersect_1.bed | tr '\t' ',' > BED_intersect_1_old.csv
cat BED_intersect_2.bed | tr '\t' ',' > BED_intersect_2_old.csv
cut -c 4- BED_intersect_1_old.csv > BED_intersect_1.csv
cut -c 4- BED_intersect_2_old.csv > BED_intersect_2.csv
rm BED_intersect_1_old.csv BED_intersect_2_old.csv
python3 '../find_enhancers.py'
cat found_enhancers.csv | tr ',' '\t' > found_enhancers_with_dup.bed
sed -ne 's/.*/chr&/p' found_enhancers_with_dup.bed > found_enhancers_with_chr.bed
cat found_enhancers_with_chr.bed | sort -r | uniq > found_enhancers.bed
rm found_enhancers.csv found_enhancers_with_chr.bed found_enhancers_with_dup.bed

# Find loops without enhancers
grep -v -x -f 'found_enhancers.bed' $loops1 > 'neg_1.bed'
grep -v -x -f 'found_enhancers.bed' $loops2 > 'neg_2.bed'
cat 'neg_1.bed' 'neg_2.bed' > 'negative_loops_with_duplicates.bed'
awk '!a[$0]++' 'negative_loops_with_duplicates.bed' > 'loops_no_enhancers.bed'
rm 'neg_1.bed' 'neg_2.bed' 'negative_loops_with_duplicates.bed'


# Matrix for interacting enhancers
../compute_matrix.sh 'found_enhancers.bed' 'matrix_interacting_enhancers'

# Matrix for loops without interacting enhancers
../compute_matrix.sh 'loops_no_enhancers.bed' 'matrix_neg_enhancers'

# Heatmap of interacting enhancers
plotHeatmap \
	-m 'matrix_interacting_enhancers.gz' \
	--missingDataColor 1 \
	--colorMap Blues \
	--whatToShow 'plot, heatmap and colorbar' \
	--dpi 200 \
	-out 'Heatmap_CD34_q30_srt.png'



# Intersection of ChromHMM and enhancers
bedtools intersect -a '../../data/E050_18_core_K27ac_state_anno.bed' -b 'found_enhancers.bed' > 'chromHMM_inter_enhancers_temp.bed'
# Filter only enhancers
cat 'chromHMM_inter_enhancers_temp.bed' | awk '/.*(E|e)nhancer.*/' > 'chromHMM_inter_enhancers.bed'
# Create a file of the promoters
cat 'chromHMM_inter_enhancers_temp.bed' | awk '/.*(Active TSS|Poised TSS|Bivalent TSS).*/' > 'BED_Intersect_chromHMM_CD34_and_found_promoters.bed'
rm 'chromHMM_inter_enhancers_temp.bed'

# Regions of ChromHMM that are not enhancers
bedtools intersect -v -a '../../data/E050_18_core_K27ac_state_anno.bed' -b 'found_enhancers.bed' > 'chromHMM_inter_enhancers_no_interact.bed'


../compute_matrix.sh 'chromHMM_inter_enhancers_no_interact.bed' 'matrix_chromHMM_inter_enhancers_no_interact'

../compute_matrix.sh 'chromHMM_inter_enhancers.bed' 'matrix_chromHMM_inter_enhancers'
