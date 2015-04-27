hismod <- commandArgs(TRUE)[1]
numbers <- c("top_1500000","top_1000000","top_500000")
{
	cellTypes <- scan(paste("/home/si14w/nearline/decorate_dnase/dnase_master_V2/cellTypesWith",hismod,".txt",sep=""), what="character")
	percentile_cutoff <- 0.95
	for (cell in cellTypes)
	{
		for (distance in c("distal","proximal"))
		{
			for (number in numbers)
			{
				cat(hismod,cell,distance,"\n")
				dnase <- as.numeric(scan(paste("/home/si14w/nearline/decorate_dnase/dnase_master_V2/",cell,".",hismod,".dnase_peaks.",distance,".",number,".txt",sep=""), quiet=TRUE))
				bg <- as.numeric(scan(paste("/home/si14w/nearline/decorate_dnase/dnase_master_V2/",cell,".",hismod,".randomBg.",distance,".",number,".txt",sep=""), quiet=TRUE))
				q <- quantile(bg, prob=seq(0,1,0.05))
				cutoff <- as.numeric(q["95%"])
				fraction_above_cutoff <- length(which(dnase >= cutoff))/length(dnase)
				write(paste(cell, fraction_above_cutoff*100,collapse="\t"),file=paste("numberofpeaks_above_95th_",hismod,".",distance,".",number,".txt",sep=""),append=TRUE)
			}
		}
	}
}
