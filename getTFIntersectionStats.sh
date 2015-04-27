echo "cell tf int total" > tfPeakIntersectionPercentages_alldnase.V2.txt
for tfPeak in $HOME/nearline/decorate_dnase/allchipseq_peaks/*regionPeak
do
	cellLine=`Rscript $HOME/nearline/decorate_dnase/getCellLineFromFileName.R ${tfPeak}`
	tfName=`Rscript $HOME/nearline/decorate_dnase/getTFFromFileName.R ${tfPeak}`
	echo $cellLine $tfName
	numIntersect_alldnase=`bedtools intersect -a ${tfPeak} -b multi-tissue.master.v2.hg19.bed -u | wc -l`
	totalPeaks=`wc -l ${tfPeak} | cut -d" " -f1`
	echo ${cellLine}	${tfName}	${numIntersect_alldnase}	${totalPeaks} >> tfPeakIntersectionPercentages_alldnase.V2.txt
done
sed 's/ /\t/g' tfPeakIntersectionPercentages_alldnase.V2.txt | sort -k1,1 -k2,2 | bedtools groupby -i stdin -g 1,2 -c 3,4 -o sum,sum > tfPeakIntersectionPercentages.sorted_by_cell_and_tf.grouped.alldnase.V2.txt
