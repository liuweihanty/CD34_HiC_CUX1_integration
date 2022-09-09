# CD34_HiC_CUX1_integration 

This repo contains codes for integrated analysis of CUX1 Cut and Run and ATAC seq analysis in CD34+ human HSPC

## Data source  <br />
1.CD34+ ATAC seq with and without CUX1 KO: McNerny lab <br />
2.CD34+ CUX1 Cut and Run: McNerney lab <br />
3.CD34+CD38- HSPC Hi-C interaction points called by HiCCUPs: [Zhang et al 2020](https://www.sciencedirect.com/science/article/pii/S1097276520302604) <br />
    [GEO data repo](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM2861708)
## analysis Methods <br />
1.Overlap CUX1 bound promotors from CD34 Cut and Run with all the loops called by HiCCUPs from Zhang et al 2020. This will give us all the "cis-regulatory elements" of CUX1 bound promotors. Compare ATAC seq signal before and after CUX1 KD to see if CUX1 signiifcantly affect the chromatin accesibility at these cis regulatory elements
![Screenshot 2022-09-09 at 15 20 45](https://user-images.githubusercontent.com/43444815/189436564-e245fe7f-4a81-4936-89f8-550faf348db4.png)
