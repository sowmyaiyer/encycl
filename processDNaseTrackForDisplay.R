normalizeto1000Scale <- function(x, max, min)
{
        x <- as.numeric(x)
        return (round((((x-min)/(max-min)) * 1000)))
}
getCleanCellLineNames <- function(x)
{
        cellLines <- unlist(strsplit(x, split=","))
        cellLineCleanNames <- as.character(sapply(cellLines, FUN=getCleanCellName))
        return (paste(unique(cellLineCleanNames), collapse=","))
}
getCleanCellName <- function(cellLine)
{
        return (cellLineMapping[cellLine,1])
}

#chr1   13000   13150   fMuscle_trunk-DS20242   7.42482 fIntestine_Sm-DS17092;fKidney_renal_cortex-DS20445;fMuscle_trunk-DS20242;fStomach-DS18389
#chr1   13240   13390   fMuscle_leg-DS20797     4.79596 fMuscle_leg-DS20797
#chr1   13900   14050   fLung_L-DS18170 11.6808 fLung-DS12817;fLung_L-DS18170;fLung_R-DS16790

inputFile <- commandArgs(TRUE)[1]
outputFile <- commandArgs(TRUE)[2]
color <- commandArgs(TRUE)[3]


cellLineMapping <- as.data.frame(read.table("code_cellnames.txt", row.names=1, sep="\t"))
df <- as.data.frame(read.table(inputFile,sep="\t"))
max_sig <- max(as.numeric(df[,5]))
min_sig <- min(as.numeric(df[,5]))
normalized_score_signal <- sapply(df[,5], FUN=normalizeto1000Scale, max=max_sig, min=min_sig)

cell_types <- strsplit(as.character(df[,6]), split=";")
unique_cell_types_clean <- sapply(cell_types, FUN=getCleanCellLineNames)
print(unique_cell_types_clean)
#total_peaks_merged <- as.numeric(lapply(cell_types,FUN=length))
number_unique_cell_types_merged <- as.numeric(lapply(strsplit(unique_cell_types_clean, split=","),FUN=length))

dnase_signal_track <- data.frame(df[,1],df[,2],df[,3],paste("re",gsub(df[,1],pattern="chr",replacement=""),".",floor((df[,2]+df[,3])/2),sep=""),normalized_score_signal, ".", df[,2],df[,3], color, unique_cell_types_clean,number_unique_cell_types_merged)

write.table(x=dnase_signal_track, file=outputFile, sep="\t", col.names=FALSE, row.names=FALSE, quote=FALSE)
