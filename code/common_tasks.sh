# Create a list of promoters and enhancers found with ChromHMM
cat '../../data/E050_18_core_K27ac_state_anno.bed' | awk '/.*(E|e)nhancer.*/' > '../../data/ChromHMM_enhancers.bed'
cat '../../data/E050_18_core_K27ac_state_anno.bed' | awk '/.*(Active TSS|Poised TSS|Bivalent TSS).*/' > '../../data/ChromHMM_promoters.bed'

# Create BigWig files
bamcompare \
	--bamfile1 '../data/CD34_CUX1_KD_ATAC_bam/ATAC_CD34_CTRL_rep1_q30_srt_nodup_noMITO.bam' \
	--bamfile2 '../data/CD34_CUX1_KD_ATAC_bam/ATAC_CD34_CTRL_rep2_q30_srt_nodup_noMITO.bam' \
	--binSize 50 \
	--scaleFactorsMethod None \
	--normalizeUsing RPKM \
	--operation mean \
	--blackListFileName '../data/CD34_CUX1_KD_ATAC_bam/hg19-blacklist.v2.bed' \
	--pseudocount 11 \
	--smoothLength 150 \
	--extendReads  \
	--centerReads \
	--outFileFormat bigwig \
	--outFileName '../data/bigwig/BAMCompare_CD34_CTRL_q30_srt_nodup_noMITO.bw'

bamcompare \
	--bamfile1 '../data/CD34_CUX1_KD_ATAC_bam/ATAC_CD34_KD_rep1_q30_srt_nodup_noMITO.bam' \
	--bamfile2 '../data/CD34_CUX1_KD_ATAC_bam/ATAC_CD34_KD_rep2_q30_srt_nodup_noMITO.bam' \
	--binSize 50 \
	--scaleFactorsMethod None \
	--normalizeUsing RPKM \
	--operation mean \
	--blackListFileName '../data/CD34_CUX1_KD_ATAC_bam/hg19-blacklist.v2.bed' \
	--pseudocount 11 \
	--smoothLength 150 \
	--extendReads \
	--centerReads \
	--outFileFormat bigwig \
	--outFileName '../data/bigwig/BAMCompare_CD34_KD_q30_srt_nodup_noMITO.bw'
