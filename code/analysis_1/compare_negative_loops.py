import pandas as pd

# Read in HiC loops from Weihan & Alexandre
weihan_loops = pd.read_csv('../../data/found_loops_with_enhancers.csv', header=[0])
weihan_loops = weihan_loops.drop(['chr2', 'x2', 'y2', 'color', 'in_intersect_1', 'in_intersect_2'], axis=1)
weihan_loops.chr1 = 'chr' + weihan_loops.chr1

alex_loops = pd.read_csv('../../data/analysis_1_results/analysis_1_step_1/negative_loops.bed', sep='\t', header=None)
alex_loops.columns = ['chr1', 'x1', 'y1']

#unshared_loops = pd.concat([weihan_loops, alex_loops]).drop_duplicates(keep=False)

unshared_loops = weihan_loops.merge(alex_loops.drop_duplicates(), on=['chr1','x1', 'y1'], how='outer', indicator=True)
unshared_left = unshared_loops[unshared_loops['_merge'] == 'left_only']
unshared_right = unshared_loops[unshared_loops['_merge'] == 'right_only']

unshared_left = unshared_left.append(unshared_right)

print(unshared_left.head())
print(alex_loops.head())
print(weihan_loops.head())

unshared_left.to_csv('mismatched_neg_loops.csv', index = False, header = False)