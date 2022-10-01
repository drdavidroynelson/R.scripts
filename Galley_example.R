library(GGally)
library(ggplot2)
library(ggExtra)
library(readr)
library(magick)
library(stats)

df <- read.table("Top_hits_by_div.txt", header = TRUE, sep = "\t")
df <- df[,-2]

ggpairs(df[,])+ theme_bw()


p <- ggpairs(df, aes(color = Division))+ theme_bw()
# Change color manually.
# Loop through each plot changing relevant scales
for(i in 1:p$nrow) {
  for(j in 1:p$ncol){
    p[i,j] <- p[i,j] + 
      scale_fill_manual(values=c("#00AFBB", "#E7B800", "#FC4E07")) +
      scale_color_manual(values=c("#00AFBB", "#E7B800", "#FC4E07"))  
  }
}
p

ggsave(plot = p, width = 16, height = 16, dpi = 300, filename = "test3.pdf")
