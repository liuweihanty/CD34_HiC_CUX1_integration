# Create a list of promoters and enhancers found with ChromHMM
cat '../../data/E050_18_core_K27ac_state_anno.bed' | awk '/.*(E|e)nhancer.*/' > '../../data/analysis_2_results/ChromhMM_enhancers.bed'
cat '../../data/E050_18_core_K27ac_state_anno.bed' | awk '/.*(Active TSS|Poised TSS).*/' > '../../data/analysis_2_results/ChromhMM_promoters.bed'

computeMatrix reference-point \
	--referencePoint center \
	--regionsFileName '../../data/analysis_2_results/ChromhMM_promoters.bed' \
	--scoreFileName '../../data/BAMCompare_CD34_CTRL_q30_srt_nodup_noMITO.bw' \
	--beforeRegionStartLength 1000 \
	--afterRegionStartLength 1000 \
	--binSize 50 \
	--outFileNameMatrix '../../data/analysis_2_results/ChromHMM_promoters_reads_original.tab' \
	-o '../../data/analysis_2_results/ChromHMM_promoters_reads.gz'

# Delete the first two lines of the output matrix, which are not part of the matrix and cause issues with other systems
sed '1,2d' '../../data/analysis_2_results/ChromHMM_promoters_reads_original.tab' > '../../data/analysis_2_results/ChromHMM_promoters_reads_no_first_two_lines.tab'
rm '../../data/analysis_2_results/ChromHMM_promoters_reads_original.tab'

# Delete the `genes|...` part on the third line (now first line as we deleted two) which is also not part of the matrix
sed 's/^genes\:[0-9]*\t//' '../../data/analysis_2_results/ChromHMM_promoters_reads_no_first_two_lines.tab' > '../../data/analysis_2_results/ChromHMM_promoters_reads.tab'
rm '../../data/analysis_2_results/ChromHMM_promoters_reads_no_first_two_lines.tab'


computeMatrix reference-point \
	--referencePoint center \
	--regionsFileName '../../data/analysis_2_results/ChromhMM_enhancers.bed' \
	--scoreFileName '../../data/BAMCompare_CD34_CTRL_q30_srt_nodup_noMITO.bw' \
	--beforeRegionStartLength 1000 \
	--afterRegionStartLength 1000 \
	--binSize 50 \
	--outFileNameMatrix '../../data/analysis_2_results/ChromHMM_enhancers_reads_original.tab' \
	-o '../../data/analysis_2_results/ChromHMM_enhancers_reads.gz'

# Delete the first two lines of the output matrix, which are not part of the matrix and cause issues with other systems
sed '1,2d' '../../data/analysis_2_results/ChromHMM_enhancers_reads_original.tab' > '../../data/analysis_2_results/ChromHMM_enhancers_reads_no_first_two_lines.tab'
rm '../../data/analysis_2_results/ChromHMM_enhancers_reads_original.tab'

# Delete the `genes|...` part on the third line (now first line as we deleted two) which is also not part of the matrix
sed 's/^genes\:[0-9]*\t//' '../../data/analysis_2_results/ChromHMM_enhancers_reads_no_first_two_lines.tab' > '../../data/analysis_2_results/ChromHMM_enhancers_reads.tab'
rm '../../data/analysis_2_results/ChromHMM_enhancers_reads_no_first_two_lines.tab'

