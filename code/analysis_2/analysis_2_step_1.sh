# Analysis 2
# Step 1

# From the cis regulatory regions called from analysis 1, further intersect these regions with chromHMM
# track on CD34 from Epigenetic Roadmap to obtain exact coordinates of enhancers. 
bedtools intersect \
	-a '../../data/E050_18_core_K27ac_state_anno.bed' \
	-b '../../data/analysis_1_results/analysis_1_step_1/found_enhancers.bed' \
	> '../../data/analysis_2_results/BED_Intersect_chromHMM_CD34_and_found_enhancers.bed'

bedtools intersect \
	-v \
	-a '../../data/E050_18_core_K27ac_state_anno.bed' \
	-b '../../data/analysis_1_results/analysis_1_step_1/found_enhancers.bed' \
	> '../../data/analysis_2_results/BED_Intersect_chromHMM_CD34_and_found_enhancers_no_interact.bed'

# Combine the enhancer names


# Supplement this list of enhancers to the CnR called CUX1 bound enhancers.



# Then compare ATAC seq signal before & after CUX1 KD to see if CUX1 is significanly affect the chromatin
# accesibilties at enhancers specifically.


