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
	--outFileNameMatrix '../../data/analysis_2_results/outMatrix_CD34_q30_srt_interact.tab' \
	-o '../../data/analysis_2_results/outMatrix_CD34_q30_srt_interact.gz'

computeMatrix reference-point \
	--referencePoint center \
	--regionsFileName '../../data/analysis_2_results/BED_Intersect_chromHMM_CD34_and_found_enhancers_no_interact.bed' \
	--scoreFileName '../../data/BAMCompare_CD34_CTRL_q30_srt_nodup_noMITO.bw' '../../data/BAMCompare_CD34_KD_q30_srt_nodup_noMITO.bw' \
	--beforeRegionStartLength 1000 \
	--afterRegionStartLength 1000 \
	--binSize 50 \
	--outFileNameMatrix '../../data/analysis_2_results/outMatrix_CD34_q30_srt_no_interact.tab' \
	-o '../../data/analysis_2_results/outMatrix_CD34_q30_srt_no_interact.gz'
