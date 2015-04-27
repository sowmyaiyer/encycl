hismods <- c("H3K27ac","H3K4me1","H3K4me3","H3K9ac")
for (hismod in hismods)
{
	pdf(paste(hismod,"_intersect_master_peaks.celltype_specific_extend2K.pdf",sep=""))
	par(xaxs="i")
#	par(xpd=TRUE)
	{
		cat(hismod,"\n")
		#df <- as.data.frame(read.table(paste("/home/si14w/nearline/decorate_dnase/dnase_master_V2/",hismod,"PeakIntersectionPercentages.txt.alldnase.V2.celltype_specific.txt",sep=""),sep="\t",header=FALSE))
		df <- as.data.frame(read.table(paste("/home/si14w/nearline/decorate_dnase/dnase_master_V2/",hismod,"PeakIntersectionPercentages.txt.alldnase.V2.celltype_specific_extend2K.txt",sep=""),sep="\t",header=FALSE))
		colnames(df) <- c("cell","int","total")
		df$fraction <- df$int/df$total
		ord <- order(as.numeric(df$fraction),decreasing=TRUE)
		bp_mids <- barplot(df$fraction, ylim=c(0,1), xaxt="n", ylab=paste("Fraction of extended ",hismod," peaks that overlap at least 1 DNase master peak",sep=""), cex.lab=0.85,space=rep(0,times=nrow(df)), main=hismod,cex.main=0.65)
		abline(h=seq(0.1,0.9,0.1), lty="dashed")
		par(xpd=TRUE)
		text(x=bp_mids+1.2, y=-0.005, df$cell, srt=45, pos=2,cex=0.55)
	}
	dev.off()
	
}
