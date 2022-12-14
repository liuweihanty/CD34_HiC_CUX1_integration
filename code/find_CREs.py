import pandas as pd
import sys

# Read in loops
#loops_file = "../../data/Zhang_2020_long_short_loops.csv" # Short and long loops
#loops_file = "../../data/Zhang_2020_HSPC_HiC_HiCCUP_loops.csv" # Short loops
loops_file = sys.argv[1]
loops = pd.read_csv(loops_file, header=[0])
loops['in_intersect_1'] = False
loops['in_intersect_2'] = False


# First file
inters = pd.read_csv('BED_intersect_1.csv', header=None)
for idx, loop in loops.iterrows():
    found_CREs = inters[(inters[0] == loop['chr1']) & (inters[1] >= loop['x1']) & (inters[2] <= loop['y1'])]
    if (found_CREs.shape[0] > 0):
        loops.at[idx, 'in_intersect_1'] = True


# Second file
inters = pd.read_csv('BED_intersect_2.csv', header=None)
for idx, loop in loops.iterrows():
    found_CREs = inters[(inters[0] == loop['chr2']) & (inters[1] >= loop['x2']) & (inters[2] <= loop['y2'])]
    if (found_CREs.shape[0] > 0):
        loops.at[idx, 'in_intersect_2'] = True

loops.to_csv('found_loops_with_CREs.csv', index=False)

in_inter = loops[loops['in_intersect_1'] == True]
CREs_1 = in_inter[['chr1', 'x1', 'y1']]
CREs_1.columns = ['chr', 'x', 'y']

in_inter = loops[loops['in_intersect_2'] == True]
CREs_2 = in_inter[['chr2', 'x2', 'y2']]
CREs_2.columns = ['chr', 'x', 'y']

CREs = CREs_1.append(CREs_2)
CREs.to_csv('found_CREs.csv', index = False, header = False)
