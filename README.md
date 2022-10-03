# CD34_HiC_CUX1_integration 

This repo contains codes for integrated analysis of CUX1 Cut and Run and ATAC seq analysis in CD34+ human HSPC.

## Data source

1. CD34+ ATAC seq with and without CUX1 KO: McNerny lab
2. CD34+ CUX1 Cut and Run: McNerney lab
3. CD34+CD38- HSPC Hi-C interaction points called by HiCCUPs: [Zhang et al 2020](https://www.sciencedirect.com/science/article/pii/S1097276520302604), [GEO data repo](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM2861708)


## Analysis Methods

### Analysis 1

Overlap CUX1 bound promotors from CD34 Cut and Run with all the loops called by `HiCCUPs` from Zhang et al 2020. This will give us all the "cis-regulatory elements" of CUX1 bound promotors.(CRE here is the loops that are in contact with CUX1 bound promotors) Compare ATAC seq signal before and after CUX1 KD to see if CUX1 significantly affect the chromatin accesibility at these cis regulatory elements. Below, if the yellow genomic site contains CUX1 bound promotors, the red site will be its interaction partner. 

![Screenshot 2022-09-09 at 15 20 45](https://user-images.githubusercontent.com/43444815/189436564-e245fe7f-4a81-4936-89f8-550faf348db4.png)

After obtaining the coordinates of these CRE that are in contact with CUX1 bound promotors, we run the steps below using deeptools to generate a heatmap which compares the CUX1 binding intensity(normalized ATAC seq reads) before and after CUX1 KD in these CREs interacting with CUX1 bound promotors: 

Create averaged normalized read bigwig file(RPKM) from CD34 ATAC seq bam files for WT and CUX1 KD conditions
```
bamcompare --bamfile1 <rep1.bam> --bamfile2 <rep2.bam> \
--binSize 50 \
--scaleFactorsMethod None \
--normalizeUsing RPKM \
--operation mean \
--blackListFileName <path to hg19.blacklist.v2.bed> \
--pseudocount 11 \
--smoothLength 150 \
--extendReads Paired-end \
--centerReads \
--outFileFormat bigwig \
--outFileName <path to output.bw)

```

Compute the score intermediate file for plotting for the CRE in WT and CUX1 KD conditions
```
computeMatrix reference-point \
--referencePoint center \
--regionsFileName <path to enhancer.bed> \
--scoreFileName <path to WT.bw> <path to KD.bw) \
--beforeRegionStartLength 1000 \
--afterRegionStartLength 1000 \
--saveMatrix \
--binSize 50 \
--outFileNameMatrix \
-o outMatrix.gz # to be used with plotHeatmap and plotProfile
```
Repeat this analysis for CUX1+SMARCA4 co-bound sites as well

### Analysis 2

From the cis regulatory regions called from analysis 1, further intersect these regions with `chromHMM` track on CD34 from Epigenetic Roadmap to obtain exact coordinates of enhancers. Supplement this list of enhancers to the CnR called CUX1 bound enhancers. Then compare ATAC seq signal before & after CUX1 KD to see if CUX1 is significanly affect the chromatin accesibilties at enhancers specifically

Repeat this analysis for CUX1+SMARCA4 co-bound sites as well

###Analysis 3:
Include the long-range interacting loops called by Zhang 2020, and repeat the analysis 1 and 2 above
