rm $HOME/nearline/decorate_dnase/processChipseqPeaks/allchipseq_peaks.bed
for peakFile in $HOME/nearline/decorate_dnase/allchipseq_peaks/*regionPeak
do
	peakFileName=`basename $peakFile`
	peakFile_noext=`basename $peakFile | awk -F".bam" '{ print $1}'`
	metadataEntry=`grep $peakFile_noext ENCODE.hg19.TFBS.QC.metadata.jun2012.tsv`
	cellLineClean=`echo -e "{$metadataEntry}" | awk -F"\t" '{ print $6 }'`
	tfClean=`echo -e "${metadataEntry}" | awk -F"\t" '{ print $7 }'`
	echo $metadataEntry $cellLineClean $tfClean
	awk -vcellLine=${cellLineClean} -vtfname=${tfClean} '{ print($1"\t"$2"\t"$3"\t"cellLine"\t"tfname"\t"$7)}' $peakFile >> $HOME/nearline/decorate_dnase/processChipseqPeaks/allchipseq_peaks.bed
done

awk '{ print $0"\t"$5"("$4")" }' $HOME/nearline/decorate_dnase/processChipseqPeaks/allchipseq_peaks.sorted.bed > $HOME/nearline/decorate_dnase/processChipseqPeaks/allchipseq_peaks.sorted.combined_cell_and_tfname.bed
bedtools intersect -a /home/si14w/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.distal.bed -b /home/si14w/nearline/decorate_dnase/processChipseqPeaks/allchipseq_peaks.sorted.combined_cell_and_tfname.bed -wa -wb | bedtools groupby -i stdin -g 1,2,3 -c 11,12,13 -o distinct,max,distinct > /home/si14w/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.distal_intersect_allchipseq_peaks.tf_collapsed.bed
bedtools intersect -a /home/si14w/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.distal.bed -b /home/si14w/nearline/decorate_dnase/processChipseqPeaks/allchipseq_peaks.sorted.combined_cell_and_tfname.bed -wa -wb | bedtools groupby -i stdin -g 1,2,3,11 -c 10 -o distinct > /home/si14w/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.distal_intersect_allchipseq_peaks.tf_collapsed.washu.bed
bedtools intersect -a /home/si14w/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.proximal.bed -b /home/si14w/nearline/decorate_dnase/processChipseqPeaks/allchipseq_peaks.sorted.combined_cell_and_tfname.bed -wa -wb | bedtools groupby -i stdin -g 1,2,3 -c 11,12,13 -o distinct,max,distinct > /home/si14w/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.proximal_intersect_allchipseq_peaks.tf_collapsed.bed
bedtools intersect -a /home/si14w/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.proximal.bed -b /home/si14w/nearline/decorate_dnase/processChipseqPeaks/allchipseq_peaks.sorted.combined_cell_and_tfname.bed -wa -wb | bedtools groupby -i stdin -g 1,2,3,11 -c 10 -o distinct > /home/si14w/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.proximal_intersect_allchipseq_peaks.tf_collapsed.washu.bed
