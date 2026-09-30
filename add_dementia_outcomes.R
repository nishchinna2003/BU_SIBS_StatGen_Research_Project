library(data.table)
library(dplyr)
setwd('/Users/nishanthchinnadurai/Documents/SIBS/SIBS_Research_Project')

pheno_data <- read.table('phenotype_with_pcs.txt', header=TRUE)
pheno_data$MCI <- ifelse(pheno_data$DX_bl == 3 | pheno_data$DX_bl == 4, 2, 1)
pheno_data$dementia <- ifelse(pheno_data$DX_bl == 5, 2, 1)

write.csv(pheno_data, "phenotype_with_pcs_corrected.csv", row.names=FALSE)
