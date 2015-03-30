bedtools intersect -a multi-tissue.master.v2.proximal.bed -b allchipseq_peaks.sorted.combined_cell_and_tfname.bed -wa -wb | sort --buffer-size=50G -k1,1 -k2,2n -k11,11  | bedtools groupby -i stdin  -g 1,2,3,11 -c 10 -o distinct | sed 's/,/\./g' > multi-tissue.master.v2.proximal_intersect_allchipseq_peaks.tf_collapsed.washu.bed
bedtools intersect -a multi-tissue.master.v2.distal.bed -b allchipseq_peaks.sorted.combined_cell_and_tfname.bed -wa -wb | sort --buffer-size=50G -k1,1 -k2,2n -k11,11  | bedtools groupby -i stdin  -g 1,2,3,11 -c 10 -o distinct | sed 's/,/\./g' > multi-tissue.master.v2.distal_intersect_allchipseq_peaks.tf_collapsed.washu.bed
# output of above:
#chr1	793425	793575	CTCF	AG09319.BE2_C.Dnd41.GM12873.HCM.HCPEpiC.HMF.HRPEpiC.K562.Osteobl
#chr1	793680	793830	CTCF	BE2_C.HCM
#chr1	801065	801215	MEF2A,MEF2C,POU2F2	GM12878,GM12878,GM12878.GM12891
#chr1	801240	801390	MEF2A,MEF2C,POU2F2	GM12878,GM12878,GM12878.GM12891
bedtools groupby -i multi-tissue.master.v2.distal_intersect_allchipseq_peaks.tf_collapsed.washu.bed -g 1,2,3 -c 4,5 -o collapse,collapse | awk -f createTFBedForWashu.awk  > tf_washu_distal.display.bed
bedtools groupby -i multi-tissue.master.v2.proximal_intersect_allchipseq_peaks.tf_collapsed.washu.bed -g 1,2,3 -c 4,5 -o collapse,collapse  | awk -f createTFBedForWashu.awk > tf_washu_proximal.display.bed
