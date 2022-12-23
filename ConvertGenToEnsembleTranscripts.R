library("biomaRt")

ensembl<-  useMart("ensembl", dataset="hsapiens_gene_ensembl")

values <- read.table("refseqACCNs.txt", header = FALSE, sep = "\t")

p <- getBM(attributes=c("refseq_mrna", "ensembl_gene_id", "hgnc_symbol"), filters = "refseq_mrna", values = values, mart= ensembl)

write.table(p, file = "converted.txt",  sep = "\t")
