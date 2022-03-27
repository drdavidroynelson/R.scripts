library(readr)
library(magick)
library(stats)
library(outliertree)

df <- read.table("Macros_full_meta_grepped_SpChrsRemvd.txt", header = TRUE, sep = "\t")

df.data = df[, grep("PF", colnames(df))]
otree <- outlier.tree(df.data, max_depth = 1, save_outliers=T, outliers_print=1000, pct_outliers=.1,
nthreads=8)

out1 <- extract.training.outliers(otree)
dt2 = t(data.table::as.data.table(out1))
write.table(dt2, file = "otree_fullPF_extTR_2.txt")


pred <- predict(otree, outliers_print=1000,
df.data,
return_outliers=TRUE)

print(pred)


dt = t(data.table::as.data.table(pred))

write.table(dt, file = "otree_fullPF_no_cross2.txt")


#print(df.data, outliers_print = 15L, min_decimals = 2L, only_these_rows = NULL, ...)

##########to add outliers to boxplot
#boxplot(df.data,
#       ylab = "hwy",
#      main = "Boxplot of highway miles per gallon"
#)
#mtext(paste("Outliers: ", paste(out, collapse = ", ")))

#dev.off()

#htShiny(ht_list)  ##can run an interactive graph, need good gpu

##from clicking: Pox_VLTF3, UMPH.1, PSII_Pbs31, DA1.like, N6.adenineMlase
