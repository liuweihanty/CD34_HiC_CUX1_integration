# Analysis 1
# Step 2

# --extendReads Paired-end
computeMatrix reference-point \
	--referencePoint center \
	--regionsFileName '../../data/analysis_1_results/analysis_1_step_1/found_enhancers.bed' \
	--scoreFileName 'BAMCompare_CD34_CTRL_q30_srt_nodup_noMITO.bw' 'BAMCompare_CD34_KD_q30_srt_nodup_noMITO.bw' \
	--beforeRegionStartLength 1000 \
	--afterRegionStartLength 1000 \
	--saveMatrix \
	--binSize 50 \
	--outFileNameMatrix \
	-o 'outMatrix_CD34_q30_srt.gz' # to be used with plotHeatmap and plotProfile

plotHeatmap \
	-m 'outMatrix_CD34_q30_srt.gz' \
	--missingDataColor 1 \
	--colorMap Blues \
	--whatToShow 'plot, heatmap and colorbar' \
	--dpi 200 \
	-out 'Heatmap_CD34_q30_srt.png'
