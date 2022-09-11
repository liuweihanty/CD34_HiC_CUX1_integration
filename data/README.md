# Files

We built the `Zhang_2020_HSPC_HiC_loops_1.bed` and `Zhang_2020_HSPC_HiC_loops_2.bed` files from the `Zhang_2020_HSPC_HiC_loops.xlsx` file. They correspond to the first or second set of three columns in the `HiCCUP_loops` tab (respectively, `chr1`, `x1`, `y1` and `chr2`, `x2`, `y2`). These were saved as CSV files and converted to a BED file (we also had to add `chr` to the beguinning of every line to ensure there were no naming conflicts).


# Notes

## Converting from a CSV to a BED file

```
cat file1.csv | tr ',' '\t' > file2_tabs.bed
cat file2_tabs.csv | tr '\r\n' '\n' > file2_newlines.bed
rm file2_tabs.bed
grep '\S' file2_newlines.bed
```
