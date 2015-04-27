#ls *H3K27ac.randomBg.distal.txt | awk '{ print $NF}' | cut -d"." -f1 | sort | uniq > ../cellTypesWithH3K27ac.txt
#ls *H3K9ac.randomBg.distal.txt | awk '{ print $NF}' | cut -d"." -f1 | sort | uniq > ../cellTypesWithH3K9ac.txt
#ls *H3K4me1.randomBg.distal.txt | awk '{ print $NF}' | cut -d"." -f1 | sort | uniq > ../cellTypesWithH3K4me1.txt
#ls *H3K4me3.randomBg.distal.txt | awk '{ print $NF}' | cut -d"." -f1 | sort | uniq > ../cellTypesWithH3K4me3.txt
#ls *randomBg.distal.txt | awk '{ print $NF}' | cut -d"." -f1 | sort | uniq > ../cellTypesWithAtleastOneHismod.txt

cells <- scan("/home/si14w/nearline/decorate_dnase/dnase_master_V2/cellTypesWithAtleastOneHismod.txt", what="character")
hismods <- c("H3K27ac","H3K4me1","H3K4me3","H3K9ac")
cellTypes_hismods <- list()
cellTypes_hismods[["H3K27ac"]] <- scan("/home/si14w/nearline/decorate_dnase/dnase_master_V2/cellTypesWithH3K27ac.txt", what="character")
cellTypes_hismods[["H3K4me1"]] <- scan("/home/si14w/nearline/decorate_dnase/dnase_master_V2/cellTypesWithH3K4me1.txt", what="character")
cellTypes_hismods[["H3K4me3"]] <- scan("/home/si14w/nearline/decorate_dnase/dnase_master_V2/cellTypesWithH3K4me3.txt", what="character")
cellTypes_hismods[["H3K9ac"]] <- scan("/home/si14w/nearline/decorate_dnase/dnase_master_V2/cellTypesWithH3K9ac.txt", what="character")

pdf(paste("mean_hismods_matched_random_V2.pdf",sep=""))
for (cell in cells)
{
	cat(cell,"\n")
	par(mfrow=c(4,2))
	par(mar=c(1,4.1,1,2.1))
	for (hismod in hismods)
	{
		if (cell %in% cellTypes_hismods[[as.character(hismod)]])
		{
			for (distance in c("distal","proximal"))
			{
        			dist_dnase <- as.numeric(scan(paste("/home/si14w/nearline/decorate_dnase/dnase_master_V2/allhismodsignals/",cell,".",hismod,".dnase_peaks.",distance,".txt",sep="")))
        			dist_random <- as.numeric(scan(paste("/home/si14w/nearline/decorate_dnase/dnase_master_V2/allhismodsignals/",cell,".",hismod,".randomBg.",distance,".txt",sep="")))
				
				q <- quantile(dist_random, probs=seq(0,1,0.01))
				xmax <- max(c(dist_dnase,dist_random))
				dnase_hist_dist <- hist(dist_dnase, breaks=seq(0,500000,1), plot=FALSE)
				print(summary(dnase_hist_dist))
				random_hist_dist <- hist(dist_random,  breaks=seq(0,500000,1), plot=FALSE)
				ymax <- max(c(dnase_hist_dist$counts, random_hist_dist$counts))
				sum_last_bin_dist_dnase <- sum(dnase_hist_dist$counts[12:length(dnase_hist_dist$counts)])
				sum_last_bin_dist_random <- sum(random_hist_dist$counts[12:length(random_hist_dist$counts)])
				break_last_bin_dist <- ">= 11"
				counts_dist_dnase <- c(dnase_hist_dist$counts[1:11],sum_last_bin_dist_dnase)
				counts_dist_random <- c(random_hist_dist$counts[1:11],sum_last_bin_dist_random)
				breaks_dist <- c(dnase_hist_dist$breaks[1:11],break_last_bin_dist)
				if (distance == "distal")
					mycols <- c("darkgreen","lightgreen")
				else
					mycols <- c("darkblue","lightblue")
				bp_coords <- barplot(rbind(counts_dist_dnase,counts_dist_random), col=mycols, beside=TRUE, axes=FALSE, main=paste(cell,hismod,distance), cex.main=0.7,space=c(0.3,1), border=NA, cex.lab=0.75, ylim=c(0,ymax),xaxt="n", cex.main=0.65)
				mids <- colMeans(bp_coords)
				axis(1, at=mids, breaks_dist, cex.axis=0.60, las=1, tck=FALSE, lwd=0, line=-1, las=2, cex=0.6)
        			axis(2, cex=0.60, cex.axis=0.75, las=1, col="black", col.axis="black")
				q_95 <- q[["95%"]]
				whole <- floor(q_95)
				decimal <- round((q_95 - whole), digits=2) 
				if (decimal == 0)
				{
					decimal <-  0.01 # pseudo number added for percentile values that are whole numbers
				}
				break1 <- mids[whole+1]
				break2 <- mids[whole+2] 
				parts <- seq(break1, break2,(break2-break1)/100)
				abline_location <- parts[decimal*100]
				
				abline(v=abline_location, lty="dashed")
				legend("top", c(paste("dnase n =",length(dist_random)), paste("random n =",length(dist_dnase)),paste("95th %ile of bg =",round(q[["95%"]], digits=2))), pch=15, col=c(mycols,"white","white","white", "white"), bty="n", cex=0.60)
				
			}
		} else {
				# plot dummy plot
				plot(1:5,1:5,col="white" ,pch=".",axes=FALSE,main="",xlab="",ylab="")
				plot(1:5,1:5,col="white" ,pch=".",axes=FALSE,main="",xlab="",ylab="")
		}
	}
}
dev.off()
