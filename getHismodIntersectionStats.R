hismods <- c("H3K27ac","H3K4me1","H3K4me3","H3K9ac")
for (hismod in hismods)
{
	cat(hismod,"\n")
	#df <- as.data.frame(read.table(paste("/home/si14w/nearline/decorate_dnase/dnase_master_V2/",hismod,"PeakIntersectionPercentages.txt.sorted_by_cell.alldnase.V2.txt",sep=""),sep="\t",header=TRUE))
	df <- as.data.frame(read.table(paste("/home/si14w/nearline/decorate_dnase/dnase_master_V2/",hismod,"PeakIntersectionPercentages.txt.alldnase.V2_extend2K.txt",sep=""),sep="\t",header=FALSE))
	colnames(df) <- c("cell","int","total")
	df$fraction <- df$int/df$total
	ord <- order(as.numeric(df$fraction),decreasing=TRUE)
	pdf(paste(hismod,"_intersect_master_peaks.alldnase_extend2K.pdf",sep=""))
	par(xaxs="i")
	bp_mids <- barplot(df$fraction, ylim=c(0,1), xaxt="n", ylab=paste("Fraction of extended ",hismod," peaks that overlap at least 1 DNase master peak",sep=""), cex.lab=0.85,space=rep(0,times=nrow(df)))
	abline(h=seq(0.1,0.9,0.1), lty="dashed")
	par(xpd=TRUE)
	text(x=bp_mids+0.7, y=-0.005, df$cell, srt=45, pos=2,cex=0.55)
	dev.off()
}
