rm(list = ls())
library(data.table)
setwd("~/Documents/SIBS/SIBS_Research_Project")

gwas_entorhinal_data <- read.table('GWAS_analysis_entorhinal.assoc.linear', header=TRUE)
gwas_hippocampus_data <- read.table('GWAS_analysis_hippocampus.assoc.linear', header=TRUE)
gwas_wholebrain_data <- read.table('GWAS_analysis_wholebrain.assoc.linear', header=TRUE)

sorted_entorhinal_data <- gwas_entorhinal_data[order(gwas_entorhinal_data$P), ]
sorted_hippocampus_data <- gwas_hippocampus_data[order(gwas_hippocampus_data$P), ]
sorted_wholebrain_data <- gwas_wholebrain_data[order(gwas_wholebrain_data$P), ]

filt_entorhinal_data <- sorted_entorhinal_data[sorted_entorhinal_data$TEST == 'ADD', ]
filt_hippocampus_data <- sorted_hippocampus_data[sorted_hippocampus_data$TEST == 'ADD', ]
filt_wholebrain_data <- sorted_wholebrain_data[sorted_wholebrain_data$TEST == 'ADD', ]
