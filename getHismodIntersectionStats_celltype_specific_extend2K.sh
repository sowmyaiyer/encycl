for hismod in {"H3K27ac","H3K4me1","H3K4me3","H3K9ac"}
do
		rm ${hismod}PeakIntersectionPercentages.V2.alldnase.celltype_specific_narrowPeak_extend2K.txt
		echo """
		for hismodPeakFile in allhismodpeaks/*${hismod}*eak
		do
			bname=\`basename \${hismodPeakFile}\`
			celltype=\`echo \$bname | cut -d\".\" -f1\`
			echo \$celltype
			numIntersect=\`awk '{ if ((\$3-\$2) < 2000) { printf(\"%s\\t%d\\t%d\\n\",\$1,((\$2+\$3)/2)-1000,((\$2+\$3)/2)+1000)} else {printf(\"%s\\t%d\\t%d\\n\",\$1,\$2,\$3)} }' \${hismodPeakFile} | bedtools slop -i stdin -g $HOME/TR/hg19.genome -b 0 | bedClip stdin $HOME/TR/hg19.genome stdout |  bedtools intersect -a stdin -b multi-tissue.master.v2.\${celltype}.bed -u | wc -l\`
			totalPeaks=\`wc -l \${hismodPeakFile} | cut -d\" \" -f1\`
			echo \${celltype} \${numIntersect} \${totalPeaks} >> ${hismod}PeakIntersectionPercentages.V2.alldnase.celltype_specific_narrowPeak_extend2K.txt
		done
		""" > bsubFiles/getHismod_celltype_specific_${hismod}.extend2K.bsub
#	sed 's/ /\t/g' ${hismod}PeakIntersectionPercentages.V2.alldnase.celltype_specific.txt | sort -k1,1 > ${hismod}PeakIntersectionPercentages.txt.alldnase.V2.celltype_specific.txt
done
