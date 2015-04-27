hismods <- c("H3K27ac","H3K4me1","H3K4me3","H3K9ac")
for (hismod in hismods)
{
	cellTypes <- scan(paste("cellTypesWith",hismod,".txt",sep=""), what="character")
	m <- list()
	m[["distal"]] <- matrix(0, nrow=3219499,ncol=length(cellTypes))
	m[["proximal"]] <- matrix(0, nrow=702930,ncol=length(cellTypes))
	
	colnames(m[["distal"]]) <- cellTypes
	colnames(m[["proximal"]]) <- cellTypes
	for (cell in cellTypes)
	{
		for (distance in c("distal","proximal"))
		{
			m[[distance]][,cell] <- as.numeric(scan(paste("/home/si14w/nearline/decorate_dnase/dnase_master_V2/allhismodsignals/",cell,".",hismod,".dnase_peaks.",distance,".txt",sep=""), what="numeric"))
		}
	}
	pdf(paste("globalCorrelation_",hismod,".distal.pdf",sep=""))
        par(xpd=TRUE)
	heatmap(cor(m[["distal"]]), cexRow=0.6, cexCol=0.6, margins=c(12,12), symm=TRUE)
	dev.off()
	pdf(paste("globalCorrelation_",hismod,".proximal.pdf",sep=""))
        par(xpd=TRUE)
        heatmap(cor(m[["proximal"]]), cexRow=0.6, cexCol=0.6, margins=c(12,12), symm=TRUE)
        dev.off()
	
}
