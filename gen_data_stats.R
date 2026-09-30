library(data.table)
library(dplyr)
setwd('/Users/nishanthchinnadurai/Documents/SIBS/SIBS_Research_Project')

# Plink command to obtain below data: plink --bfile data/WGS_Omni25_BIN_wo_ConsentsIssues --freq --missing --hardy --out gen_data_stats

frq_data <- fread("gen_data_stats.frq")
hwe_data <- fread("gen_data_stats.hwe")
ind_miss_data <- fread("gen_data_stats.imiss")
var_miss_data <- fread("gen_data_stats.lmiss")

frq_data_2 <- fread("WGS2.frq")
hwe_data_2 <- fread("WGS2.hwe")
ind_miss_data_2 <- fread("WGS2.imiss")
var_miss_data_2 <- fread("WGS2.lmiss")

maf_filt_data <- frq_data[MAF > 0.05]
ind_miss_filt_data <- ind_miss_data[F_MISS < 0.05]
var_miss_filt_data <- var_miss_data[F_MISS < 0.05]
hwe_filt_data <- hwe_data[P > 0.000001]
chr_filt_data <- frq_data[CHR >= 1 & CHR <= 22]

cat('Total Number of Variants:', nrow(frq_data))
cat('Total Number of People:', nrow(ind_miss_data))
# Total Number of Variants: 2379855
# Total Number of People: 812

cat('Number of Variants w/ MAF > 5%:', nrow(maf_filt_data))
cat('Percent of Variants w/ MAF > 5%:', nrow(maf_filt_data)/nrow(frq_data))
# Number of Variants w/ MAF > 5%: 1293205
# Percent of Variants w/ MAF > 5%: 0.5433966

cat('Number of People w/ Missingness < 5%:', nrow(ind_miss_filt_data))
cat('Percent of People w/ Missingness < 5%:', nrow(ind_miss_filt_data)/nrow(ind_miss_data))
# Number of People w/ MAF > 5%: 812
# Percent of People w/ MAF > 5%: 1

cat('Number of Variants w/ Missingness < 5%:', nrow(var_miss_filt_data))
cat('Percent of Variants w/ Missingness < 5%:', nrow(var_miss_filt_data)/nrow(var_miss_data))
# Number of Variants w/ MAF > 5%: 2358996
# Percent of Variants w/ MAF > 5%: 0.9912352

cat('Number of Variants w/ HWE p > 1e-6:', nrow(hwe_filt_data))
cat('Percent of Variants w/ HWE p > 1e-6:', nrow(hwe_filt_data)/nrow(hwe_data))
# Number of Variants w/ HWE p < 1e-6: 2371849
# Percent of Variants w/ HWE p < 1e-6: 0.9966359

cat('Number of Variants on Chromosomes 1-22:', nrow(chr_filt_data))
cat('Percent of Variants on Chromosomes 1-22:', nrow(chr_filt_data)/nrow(frq_data))
# Number of Variants on Chromosomes 1-22: 2314174
# Percent of Variants on Chromosomes 1-22: 0.9724013

# fully_filt_data <- inner_join(maf_filt_data, var_miss_filt_data, by = "SNP") %>%
#   inner_join(hwe_filt_data, by = "SNP") %>%
#   inner_join(chr_filt_data, by = "SNP")
# cat('Number of Included Variants:', nrow(fully_filt_data))
# cat('Percent of Included Variants:', nrow(fully_filt_data)/nrow(frq_data))

phen_data <- read.table("ADNI_pheno_2023July28.txt", header = TRUE, sep=' ')
cat('Number of People:', nrow(phen_data))
filt_phen_data <- phen_data[phen_data$Hippocampus_bl != 'N' | phen_data$WholeBrain_bl != 'N' | phen_data$Entorhinal_bl != 'N', ]
cat('Number of People w/ At Least 1 Brain Measure:', nrow(filt_phen_data))
filt_phen_data$WholeBrain_bl <- as.numeric(filt_phen_data$WholeBrain_bl)
filt_phen_data$Hippocampus_bl <- as.numeric(filt_phen_data$Hippocampus_bl)
filt_phen_data$Entorhinal_bl <- as.numeric(filt_phen_data$Entorhinal_bl)
filt_phen_data$ICV_bl <- as.numeric(filt_phen_data$ICV_bl)
sum(is.na(filt_phen_data$ICV_bl))
hist(filt_phen_data$Hippocampus_bl)
hist(filt_phen_data$Entorhinal_bl)
hist(filt_phen_data$WholeBrain_bl)
filt_phen_data <- filt_phen_data[filt_phen_data$WholeBrain_bl != max(filt_phen_data$WholeBrain_bl, na.rm = TRUE), ]
cat('Number of People w/ At Least 1 Brain Measure & Excluding Outliers:', nrow(filt_phen_data))

