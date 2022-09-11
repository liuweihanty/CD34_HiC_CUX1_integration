import pandas as pd

# Read in HiC loops
loops = pd.read_csv('../../data/Zhang_2020_HSPC_HiC_HiCCUP_loops.csv', header=[0])
loops['in_intersect_1'] = False
loops['in_intersect_2'] = False


# First file
inters = pd.read_csv('BED_intersect_HiC_CUX1_1.csv', header=None)
for idx, loop in loops.iterrows():
    #print(loop['chr1'])
    #print(inters)
    found_enhancers = inters[(inters[0] == loop['chr1']) & (inters[1] >= loop['x1']) & (inters[2] <= loop['y1'])]
    if (found_enhancers.shape[0] > 0):
        loops.at[idx, 'in_intersect_1'] = True


# Second file
inters = pd.read_csv('BED_intersect_HiC_CUX1_2.csv', header=None)
for idx, loop in loops.iterrows():
    found_enhancers = inters[(inters[0] == loop['chr2']) & (inters[1] >= loop['x2']) & (inters[2] <= loop['y2'])]
    if (found_enhancers.shape[0] > 0):
        loops.at[idx, 'in_intersect_2'] = True

loops.to_csv('found_enhancers.csv', index=False)
