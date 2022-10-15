# Parameters:
# 1. regionsFileName
# 2. output file name

# Calculate the matrix
# FIXME: check parameters
computeMatrix reference-point \
	--referencePoint center \
	--regionsFileName $1 \
	--scoreFileName '../../data/bigwig/BAMCompare_CD34_CTRL_q30_srt_nodup_noMITO.bw' '../../data/bigwig/BAMCompare_CD34_KD_q30_srt_nodup_noMITO.bw' \
	--beforeRegionStartLength 1000 \
	--afterRegionStartLength 1000 \
	--binSize 50 \
	--outFileNameMatrix $2'.tab' \
	-o $2'.gz'

# Delete the first two lines of the output matrix, which are not part of the matrix and cause issues with other systems
sed '1,2d' $2'.tab' > $2'_copy.tab'
rm $2'.tab'

# Delete the `genes|...` part on the third line (now first line as we deleted two) which is also not part of the matrix
sed 's/^genes\:[0-9]*\t//' $2'_copy.tab' > $2'.tab'
rm $2'_copy.tab'
