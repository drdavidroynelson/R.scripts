library(dataRetrieval)
#library(dplyr) 
#library(tidyr) 
library(ggplot2)
library(ggExtra)
library(readr)
#library(magick)
#library(stats)
library(ggthemes)
library("ggrepel")   

df <- read.table("Days_DEGs.txt", header = TRUE, sep = "\t")
## variables gene	log2_fold_change	q_value	Day
options(scipen=999)

p<- ggplot(df, aes(x=log2_fold_change, y=NegLogQ, color=Day, label=gene)) + 
  geom_point(stat="identity") +
  #theme(
   # panel.background = element_rect(fill = "powderblue",
    #                                color = "powderblue",
     #                               size = 0.5, linetype = "solid"),
    #panel.grid.major = element_line(size = 0.5, linetype = 'solid', color = "white"),
    #panel.grid.minor = element_line(size = 0.25, linetype = 'solid', color = "white")
  #)

  theme_bw()
  
  
q <- p + geom_text_repel(data=subset(df, abs(log2_fold_change)>2 ), aes(y=NegLogQ, label=gene), size=2) #+ geom_text_repel(aes())

q

ggsave(plot = q, width = 8, height = 8, dpi = 300, filename = "Transcriptome_DEGs6.pdf")
