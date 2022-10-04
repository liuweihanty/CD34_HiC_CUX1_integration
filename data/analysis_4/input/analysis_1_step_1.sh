# Analysis 1
# Step 1

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

cat found_enhancers.csv | tr ',' '\t' > found_enhancers_with_dup.bed
sed -ne 's/.*/chr&/p' found_enhancers_with_dup.bed > found_enhancers_with_chr.bed
cat found_enhancers_with_chr.bed | sort -r | uniq > found_enhancers.bed
rm found_enhancers.csv
rm found_enhancers_with_chr.bed
rm found_enhancers_with_dup.bed
