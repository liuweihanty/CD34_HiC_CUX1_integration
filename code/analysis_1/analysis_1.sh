# Analysis 1

# Bedtools Intersect

echo "Running analysis on the first HiC loops file..."

bedtools intersect \
	-a "../../data/Zhang_2020_HSPC_HiC_loops_1.bed" \
	-b "../../data/CUX1_IDR005_peaks_promotors.bed" \
	> "BED_intersect_HiC_CUX1_1.bed"

echo "Running analysis on the second HiC loops file..."

bedtools intersect \
	-a "../../data/Zhang_2020_HSPC_HiC_loops_2.bed" \
	-b "../../data/CUX1_IDR005_peaks_promotors.bed" \
	> "BED_intersect_HiC_CUX1_2.bed"

# Find corresponding enhancers

echo "Finding corresponding enhancers in the Zhang (2020) HiC loops file..."

cat BED_intersect_HiC_CUX1_1.bed | tr '\t' ',' > BED_intersect_HiC_CUX1_1_old.csv
cat BED_intersect_HiC_CUX1_2.bed | tr '\t' ',' > BED_intersect_HiC_CUX1_2_old.csv
cut -c 4- BED_intersect_HiC_CUX1_1_old.csv > BED_intersect_HiC_CUX1_1.csv
cut -c 4- BED_intersect_HiC_CUX1_2_old.csv > BED_intersect_HiC_CUX1_2.csv
rm BED_intersect_HiC_CUX1_1_old.csv
rm BED_intersect_HiC_CUX1_2_old.csv

python3 find_enhancers.py

#rm identified_enhancers_1.bed
#rm identified_enhancers_2.bed
#touch identified_enhancers_1.bed
#touch identified_enhancers_2.bed

#cat BED_intersect_HiC_CUX1_1.csv | while read line 
#do
#	grep "^$line.*$" ../../data/Zhang_2020_HSPC_HiC_HiCCUP_loops.csv >> identified_enhancers_1.bed
#done

#cat BED_intersect_HiC_CUX1_2.csv | while read line 
#do
#	grep "^.*$line$" ../../data/Zhang_2020_HSPC_HiC_HiCCUP_loops.csv >> identified_enhancers_2.bed
#done
