for (hismod in c("H3K27ac","H3K4me1","H3K4me3","H3K9ac"))
{
	for (distance in c("distal","proximal"))
	{
		df <- as.data.frame(read.table(paste("numberofpeaks_above_95th_",hismod,".",distance,".txt",sep=""),sep=" "))
		colnames(df) <- c("cell","percentage")
		pdf(paste(hismod,"_above_95th.",distance,".pdf",sep=""))
		par(xpd=TRUE)
		par(xaxs="i")
		bp_mids <- barplot(df$percentage, ylim=c(0,100), xaxt="n", ylab=paste("Percentage of ",distance," DNase master peaks with ",hismod," > 95th %ile of background",sep=""), cex.lab=0.85, col="lightblue", las=2,space=0)
		text(x=bp_mids+0.50, y=-0.2, df$cell, srt=55, pos=2,cex=0.55)
		dev.off()
	}
}
