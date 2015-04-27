library(reshape2)
t <- as.data.frame(read.table("tfPeakIntersectionPercentages.sorted_by_cell_and_tf.grouped.alldnase.V2.txt"))
colnames(t) <- c("cell","tf","int","total")

t$fraction <- t$int/t$total

m <- dcast(t, cell ~ tf, value.var="fraction")

m2 <- m[,2:ncol(m)]

rownames(m2) <- m[,"cell"]
m2_sub <- m2

mycols <- c("gray","maroon")
cols_rep <- c()
vec <- c()
spa <- c(1)
text_cell <- c()
tf_pos <- c()
mean_intersections <- apply(m2_sub,2,mean,na.rm=TRUE)
#ord <- order(mean_intersections, decreasing=TRUE)
ord <- 1:ncol(m2_sub)
svg("tf_intersect_master_peaks_V2.svg", width=75, height=5)
#for (colIndex in 1:ncol(m2_sub))
colorAndSpaceIndex <- 1
for (colIndex in ord)
{
	thisTfFractions <- as.numeric(m2_sub[which(!is.na(m2_sub[,colIndex])),colIndex])
	if (sum(thisTfFractions, na.rm=TRUE) > 0)
	{
		thisTfName <- colnames(m2_sub)[colIndex]
		cellsForThisTf <- rownames(m2_sub)[which(!is.na(m2_sub[,colIndex]))]
		vec <- c(vec, thisTfFractions)
		cols_rep <- c(cols_rep, rep(mycols[colorAndSpaceIndex%%2 + 1], times=length(thisTfFractions)))
		if (colorAndSpaceIndex > 1)
		{
			spa <- c(spa,1,rep(0, length(thisTfFractions)-1))
		}
		text_cell <- c(text_cell, paste(thisTfName,cellsForThisTf))
	}
	colorAndSpaceIndex <- colorAndSpaceIndex + 1
}
cat(length(vec),"\n")
cat(length(cols_rep),"\n")
cat(spa,"\n")
par(xaxs="i")
bp_mids <- barplot(vec, col=cols_rep, ylim=c(0,1), space=spa, ylab="Fraction of TF peaks overlapping at least 1 DNase master peak", cex.lab=0.7)
abline(h=seq(0.1,1,0.1), lty="dashed", col="gray")
axis(1, at=bp_mids, text_cell, tick=FALSE, las=2, cex=0.5, cex.axis=0.5)
dev.off()
