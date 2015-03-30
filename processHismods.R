cellLines <- scan("/home/si14w/nearline/decorate_dnase/dnase_master_V2/allhismodsignals/cellTypesWithAtleastOneHismod.txt", what="character")
hismods <- c("H3K27ac","H3K4me1","H3K4me3","H3K9ac")
cellTypes_hismods <- list()
cellTypes_hismods[["H3K27ac"]] <- scan("/home/si14w/nearline/decorate_dnase/dnase_master_V2/allhismodsignals/cellTypesWithH3K27ac.txt", what="character")
cellTypes_hismods[["H3K4me1"]] <- scan("/home/si14w/nearline/decorate_dnase/dnase_master_V2/allhismodsignals/cellTypesWithH3K4me1.txt", what="character")
cellTypes_hismods[["H3K4me3"]] <- scan("/home/si14w/nearline/decorate_dnase/dnase_master_V2/allhismodsignals/cellTypesWithH3K4me3.txt", what="character")
cellTypes_hismods[["H3K9ac"]] <- scan("/home/si14w/nearline/decorate_dnase/dnase_master_V2/allhismodsignals/cellTypesWithH3K9ac.txt", what="character")
for (cell in cellLines)
{
	for (hismod in hismods)
        {
		if (cell %in% cellTypes_hismods[[as.character(hismod)]])
		{
			cat(cell, hismod,"\n")
			for (distance in c("distal","proximal"))
			{
				dnase <- as.numeric(scan(paste("/home/si14w/nearline/decorate_dnase/dnase_master_V2/allhismodsignals/",cell,".",hismod,".dnase_peaks.",distance,".txt",sep="")))
				bg <- as.numeric(scan(paste("/home/si14w/nearline/decorate_dnase/dnase_master_V2/allhismodsignals/",cell,".",hismod,".randomBg.",distance,".txt",sep="")))
				dnase_percentiles <- ecdf(bg)(dnase)
				write(paste(cell,dnase_percentiles,sep="="), file=paste("/home/si14w/nearline/decorate_dnase/dnase_master_V2/allhismodsignals/",cell,".",hismod,".",distance,".percentiles.txt",sep=""), sep="\n")	
			}
		}
	}
}
