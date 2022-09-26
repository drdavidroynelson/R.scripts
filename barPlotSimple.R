library(dataRetrieval)
library(dplyr) # for `rename` & `select`
library(tidyr) # for `gather`
library(ggplot2)
library(ggExtra)

# Get the data by giving site numbers and parameter codes
# 00060 = stream flow, 00530 = total suspended solids, 00631 = concentration of inorganic nitrogen
df <- read.table("dcGO_enrichment_Ternary-brown9tritip_ToPlot-slim.txt", header = TRUE, sep = "\t")

options(scipen=999)
#pdf(file = 'ExMult3.pdf', paper="a4")

#df$Round <- factor(df$Round, levels = c('Original', 'First_round', 'Second_round'))
#Ro <- df$Round

GO_class <- factor("GO_class")

#df$right <- cumsum(df$Domains) + 2*c(0:(nrow(df)-1))
#df$left <- df$right - df$Domains


# Setup plot without facets
p <- #ggplot(df, aes(ymin = 0)) + 
 # geom_rect(data=subset(df, NegLogFDR_P > 9 | Domains > 29), aes(xmin = left, xmax = right, ymax = NegLogFDR_P, colour = Z.score, fill = Z.score)) + geom_text(data=subset(df, NegLogFDR_P > 9 | Domains > 29), aes(x = (right+left)/2, y = NegLogFDR_P * 1.2, label = GO.term, size=4)) + 
  
  ggplot(data = df, aes(x = reorder(GO.term, +Domains, sum), y = Domains, fill=Z.score)) +
  geom_bar(stat="identity", position=position_dodge())+
  #geom_rect(aes(xmin = left, xmax = right, ymax = value, colour = group, fill = group)) +
  theme_minimal() 
 #facet_grid(rows = vars(Ro),
        #cols = NULL) +
#theme(axis.title.x=element_blank(),
 #     axis.text.x=element_blank(),
  #    axis.ticks.x=element_blank(),
   #   text = element_text( colour="black", size=4))
# Now, we can look at the plot and see how it looks before we facet
# Obviously, the scales are off because we are plotting flow with concentrations
#ggplot.3plus + theme(axis.text.x=element_text(colour="red"))



q <- p + coord_flip() + labs(title = "Enrichment in Brown-specific PFAMs", x = "GO term", y = "PFAM domains", fill = "Z score") #+ scale_y_log10(oob = scales::squish_infinite)

r <- q + facet_grid(rows = GO_class)
#ggMarginal(q, groupColour = TRUE, groupFill = TRUE)


#p + facet_grid(.~Type)

ggsave(plot = r, width = 8, height = 8, dpi = 300, filename = "dcGO_out_Brown_tip-simple2.pdf")

#dev.off()

