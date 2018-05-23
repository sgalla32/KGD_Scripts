#If you are converting a vcf from Tassel5 or STACKS, remember to convert the vcf to an ra.tab file using vcf2ra_ro_ao.py 
rm(list = ls())
genofile <- "resequencing.full_dataset.vcf.ra.tab"
gform <- "Tassel"
source("GBS-Chip-Gmatrix.R")
Gfull <- calcG()
GHWdgm.05 <- calcG(which(HWdis > -0.05),"HWdgm.05", npc = 4)
str(GHWdgm.05)
writeG(Gfull, "8Apr2018_Superscaffolds", outtype = 3)

#These next steps are if you want to upload the file into GRM tensor_flow
G5 <- GHWdgm.05$G5
writeG(G5,"gmax", outtype=2, ,seqID)
G1 <- GHWdgm.05$G
writeG(G1,"gmaxG1",outtype=2, ,seqID)
