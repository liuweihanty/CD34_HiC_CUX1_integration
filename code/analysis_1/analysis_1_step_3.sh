# Analysis 1
# Step 2

# --extendReads Paired-end
# --outFileNameMatrix \
# --saveMatrix \
computeMatrix reference-point \
	--referencePoint center \
	--regionsFileName '../../data/analysis_1_results/analysis_1_step_1/found_enhancers.bed' \
	--scoreFileName 'BAMCompare_CD34_CTRL_q30_srt_nodup_noMITO.bw' 'BAMCompare_CD34_KD_q30_srt_nodup_noMITO.bw' \
	--beforeRegionStartLength 1000 \
	--afterRegionStartLength 1000 \
	--binSize 50 \
	--outFileNameMatrix 'outMatrix_CD34_q30_srt.tab' \
	-o 'outMatrix_CD34_q30_srt.gz'
