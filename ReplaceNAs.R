library(readr)
library(magick)
library(showtext)


df <- read.table("5x5L_PFAM_matrix.txt", header = TRUE, sep = "\t", check.names=FALSE)

df[is.na(df)] <- 0



write.table(df, file="5x5L_PFAMs0s_noXs.txt", append = FALSE, sep = "\t", dec = ".",
            row.names = TRUE, col.names = TRUE)
