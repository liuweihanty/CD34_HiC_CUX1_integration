# Analysis 1
# Step 2

# --extendReads Paired-end
# --outFileNameMatrix \
# --saveMatrix \
computeMatrix reference-point \
	--referencePoint center \
	--regionsFileName '../../data/analysis_2_results/BED_Intersect_chromHMM_CD34_and_found_enhancers.bed' \
	--scoreFileName '../../data/BAMCompare_CD34_CTRL_q30_srt_nodup_noMITO.bw' '../../data/BAMCompare_CD34_KD_q30_srt_nodup_noMITO.bw' \
	--beforeRegionStartLength 1000 \
	--afterRegionStartLength 1000 \
	--binSize 50 \
	--outFileNameMatrix '../../data/analysis_2_results/outMatrix_CD34_q30_srt_interact_original.tab' \
	-o '../../data/analysis_2_results/outMatrix_CD34_q30_srt_interact_original.gz'

# Delete the first two lines of the output matrix, which are not part of the matrix and cause issues with other systems
sed '1,2d' '../../data/analysis_2_results/outMatrix_CD34_q30_srt_interact_original.tab' > '../../data/analysis_2_results/outMatrix_CD34_q30_srt_interact_no_first_two_lines.tab'
rm '../../data/analysis_2_results/outMatrix_CD34_q30_srt_interact_original.tab'

# Delete the `genes|...` part on the third line (now first line as we deleted two) which is also not part of the matrix
sed 's/^genes\:[0-9]*\t//' '../../data/analysis_2_results/outMatrix_CD34_q30_srt_interact_no_first_two_lines.tab' > '../../data/analysis_2_results/outMatrix_CD34_q30_srt_interact.tab'
rm '../../data/analysis_2_results/outMatrix_CD34_q30_srt_interact_no_first_two_lines.tab'



computeMatrix reference-point \
	--referencePoint center \
	--regionsFileName '../../data/analysis_2_results/BED_Intersect_chromHMM_CD34_and_found_promoters.bed' \
	--scoreFileName '../../data/BAMCompare_CD34_CTRL_q30_srt_nodup_noMITO.bw' '../../data/BAMCompare_CD34_KD_q30_srt_nodup_noMITO.bw' \
	--beforeRegionStartLength 1000 \
	--afterRegionStartLength 1000 \
	--binSize 50 \
	--outFileNameMatrix '../../data/analysis_2_results/outMatrix_CD34_q30_srt_promoters_original.tab' \
	-o '../../data/analysis_2_results/outMatrix_CD34_q30_srt_promoters_original.gz'

# Delete the first two lines of the output matrix, which are not part of the matrix and cause issues with other systems
sed '1,2d' '../../data/analysis_2_results/outMatrix_CD34_q30_srt_promoters_original.tab' > '../../data/analysis_2_results/outMatrix_CD34_q30_srt_promoters_no_first_two_lines.tab'
rm '../../data/analysis_2_results/outMatrix_CD34_q30_srt_promoters_original.tab'

# Delete the `genes|...` part on the third line (now first line as we deleted two) which is also not part of the matrix
sed 's/^genes\:[0-9]*\t//' '../../data/analysis_2_results/outMatrix_CD34_q30_srt_promoters_no_first_two_lines.tab' > '../../data/analysis_2_results/outMatrix_CD34_q30_srt_promoters.tab'
rm '../../data/analysis_2_results/outMatrix_CD34_q30_srt_promoters_no_first_two_lines.tab'



#computeMatrix reference-point \
#	--referencePoint center \
#	--regionsFileName '../../data/analysis_2_results/BED_Intersect_chromHMM_CD34_and_found_enhancers_no_interact.bed' \
#	--scoreFileName '../../data/BAMCompare_CD34_CTRL_q30_srt_nodup_noMITO.bw' '../../data/BAMCompare_CD34_KD_q30_srt_nodup_noMITO.bw' \
#	--beforeRegionStartLength 1000 \
#	--afterRegionStartLength 1000 \
#	--binSize 50 \
#	--outFileNameMatrix '../../data/analysis_2_results/outMatrix_CD34_q30_srt_no_interact.tab' \
#	-o '../../data/analysis_2_results/outMatrix_CD34_q30_srt_no_interact.gz'
