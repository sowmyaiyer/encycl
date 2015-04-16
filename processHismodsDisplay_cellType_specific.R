getFullCellTypeName <- function(row)
{
	dnase_cell_types <- unlist(strsplit(row[6], split=";"))
	dnase_cell_types_full <- as.character(code_cellnames[match(dnase_cell_types, rownames(code_cellnames)),1])
	hismod_cell_types_and_values <- sapply(row[7:length(row)],FUN=strsplit,split="=")
	hismod_cell_types <- as.character(lapply(hismod_cell_types_and_values,"[[",1))
	cell_types_specific <- which(!is.na(dnase_cell_types_full[match(hismod_cell_types,dnase_cell_types_full)]))
	if (length(cell_types_specific) > 0)
	{
		hismod_values <- as.numeric(lapply(hismod_cell_types_and_values,"[[",2))	
		hismod_values_95 <- which(hismod_values[cell_types_specific] >= 0.95)
		str <- data.frame(rep(row[1],length(hismod_values_95)),rep(row[2],length(hismod_values_95)),rep(row[3],length(hismod_values_95)),hismod_cell_types[cell_types_specific][hismod_values_95],hismod_values[cell_types_specific][hismod_values_95])
		write.table(str, file=output,append=TRUE, quote=FALSE,row.names=FALSE, col.names=FALSE, sep="\t")
#		cat(paste(hismod_cell_types[cell_types_specific][hismod_values_95],"=",hismod_values[cell_types_specific][hismod_values_95]),"\n")	
	} 
}
input <- commandArgs(TRUE)[1]
output <- commandArgs(TRUE)[2]
code_cellnames <- as.data.frame(read.table("code_cellnames.for_hismod_processing.txt",sep="\t", row.names=1))
data <- as.data.frame(read.table(input, sep="\t"))
x <- apply(data,1,FUN=getFullCellTypeName)
