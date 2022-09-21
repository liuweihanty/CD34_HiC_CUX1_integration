# Analysis 1
# Only keep unfound enhancers

grep -v -x -f '../../data/analysis_1_results/analysis_1_step_1/found_enhancers.bed' 'Zhang_2020_HSPC_HiC_loops_1.bed' > 'neg_1.bed'

grep -v -x -f '../../data/analysis_1_results/analysis_1_step_1/found_enhancers.bed' 'Zhang_2020_HSPC_HiC_loops_2.bed' > 'neg_2.bed'

cat 'neg_1.bed' 'neg_2.bed' > 'negative_loops_with_duplicates.bed'
rm 'neg_1.bed'
rm 'neg_2.bed'

awk '!a[$0]++' 'negative_loops_with_duplicates.bed' > 'negative_loops.bed'
rm 'negative_loops_with_duplicates.bed'
