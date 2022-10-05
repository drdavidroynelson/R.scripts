
library(dataRetrieval)
library(dplyr) # for `rename` & `select`
library(tidyr) # for `gather`
library(ggplot2)
library(ggExtra)
library(scico)
library(ggpubr)
library(ggridges)

theme_set(
  theme_pubr() +
    theme(legend.position = "right")
)

# Get the data by giving site numbers and parameter codes
# 00060 = stream flow, 00530 = total suspended solids, 00631 = concentration of inorganic nitrogen
df <- read.table("All_BLEACH_Rounds.txt", header = TRUE, sep = "\t")

options(scipen=999)
#pdf(file = 'ExMult3.pdf', paper="a4")


p <- ggplot(data=df, aes(x=Type, y=Ratio)) + ylab("Contaminants/total") +
  geom_boxplot(outlier.shape = NA) + geom_jitter(aes(color = Type), size=.2) +
  #geom_text(aes(label=Type), vjust=-0.3, size=3.5)+
  theme_light()+ theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +scico::scale_fill_scico(palette = "lisbon") +
  theme(strip.background = element_blank())


q <- p + facet_grid(rows=vars(Round), cols=vars(Reference)) 

ggsave(plot = q,  height=5, width=5,dpi = 300, filename = "All_BLEACH_contam_grid_b.pdf")
