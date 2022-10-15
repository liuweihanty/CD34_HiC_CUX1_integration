# Analysis 1

## Cux1 vs Cux1 & SMACA4

To run the analysis on Cux1 sites, the first parameter must be
```{shell}
"../data/CUX1_IDR005_peaks_promotors.bed"
```

To run the analysis on Cux1 & SMACA4 sites, the first parameter must be
```{shell}
"../../data/CUX1_SMARCA4_olp_IDR_005_first3col_promotor.bed"
```

## Short loops vs Short and long loops

To run the analysis on short loops, the second, third, and fourth parameters must be
```{shell}
"../data/Zhang_2020_HSPC_HiC_loops_1.bed"
"../data/Zhang_2020_HSPC_HiC_loops_1.bed"
"../../data/Zhang_2020_HSPC_HiC_HiCCUP_loops.csv"
```

To run the analysis on short and long loops, the second, third, and fourth parameters must be
```{shell}
"../data/Zhang_2020_HSPC_long_and_HiC_loops_1.bed"
"../data/Zhang_2020_HSPC_long_and_HiC_loops_1.bed"
"../../data/Zhang_2020_long_short_loops.csv"
```


## All commands

Run the commands within the correct directories for each analysis (e.g., `cux1_short_loops`) to ensure files remain organized. These are all
the analyses we can do using the above parameters.

```{shell}
../analysis.sh "../../data/CUX1_IDR005_peaks_promotors.bed" "../../data/Zhang_2020_HSPC_HiC_loops_1.bed" "../../data/Zhang_2020_HSPC_HiC_loops_1.bed" "../../data/Zhang_2020_HSPC_HiC_HiCCUP_loops.csv"
```

```{shell}
../analysis.sh "../../data/CUX1_IDR005_peaks_promotors.bed" "../../data/Zhang_2020_HSPC_long_and_HiC_loops_1.bed" "../../data/Zhang_2020_HSPC_long_and_HiC_loops_1.bed" "../../data/Zhang_2020_long_short_loops.csv"
```

```{shell}
../analysis.sh "../../data/CUX1_SMARCA4_olp_IDR_005_first3col_promotor.bed" "../../data/Zhang_2020_HSPC_HiC_loops_1.bed" "../../data/Zhang_2020_HSPC_HiC_loops_1.bed" "../../data/Zhang_2020_HSPC_HiC_HiCCUP_loops.csv"
```

```{shell}
../analysis.sh "../../data/CUX1_SMARCA4_olp_IDR_005_first3col_promotor.bed" "../../data/Zhang_2020_HSPC_long_and_HiC_loops_1.bed" "../../data/Zhang_2020_HSPC_long_and_HiC_loops_1.bed" "../../data/Zhang_2020_long_short_loops.csv"
```
