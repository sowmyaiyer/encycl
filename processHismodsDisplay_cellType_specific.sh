#for inputFile in $HOME/nearline/decorate_dnase/dnase_master_V2/splits/*.chr*
rm /home/si14w/nearline/decorate_dnase/dnase_master_V2/splits/multi-tissue.master.v2.*.*.bed.chr*.bed
awk '{ print $0 >> "/home/si14w/nearline/decorate_dnase/dnase_master_V2/splits/multi-tissue.master.v2.distal.H3K27ac.bed."$1".bed"}' /home/si14w/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.distal.H3K27ac.bed
awk '{ print $0 >> "/home/si14w/nearline/decorate_dnase/dnase_master_V2/splits/multi-tissue.master.v2.distal.H3K4me1.bed."$1".bed"}' /home/si14w/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.distal.H3K4me1.bed
awk '{ print $0 >> "/home/si14w/nearline/decorate_dnase/dnase_master_V2/splits/multi-tissue.master.v2.distal.H3K9ac.bed."$1".bed"}' /home/si14w/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.distal.H3K9ac.bed
awk '{ print $0 >> "/home/si14w/nearline/decorate_dnase/dnase_master_V2/splits/multi-tissue.master.v2.distal.H3K4me3.bed."$1".bed"}' /home/si14w/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.distal.H3K4me3.bed

awk '{ print $0 >> "/home/si14w/nearline/decorate_dnase/dnase_master_V2/splits/multi-tissue.master.v2.proximal.H3K27ac.bed."$1".bed"}' /home/si14w/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.proximal.H3K27ac.bed
awk '{ print $0 >> "/home/si14w/nearline/decorate_dnase/dnase_master_V2/splits/multi-tissue.master.v2.proximal.H3K4me1.bed."$1".bed"}' /home/si14w/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.proximal.H3K4me1.bed
awk '{ print $0 >> "/home/si14w/nearline/decorate_dnase/dnase_master_V2/splits/multi-tissue.master.v2.proximal.H3K9ac.bed."$1".bed"}' /home/si14w/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.proximal.H3K9ac.bed
awk '{ print $0 >> "/home/si14w/nearline/decorate_dnase/dnase_master_V2/splits/multi-tissue.master.v2.proximal.H3K4me3.bed."$1".bed"}' /home/si14w/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.proximal.H3K4me3.bed

for hismod in {"H3K27ac","H3K4me1","H3K4me3","H3K9ac"}
do
	for inputFile in $HOME/nearline/decorate_dnase/dnase_master_V2/splits/multi-tissue.master.v2.distal.${hismod}.bed.chr*.bed
	do
		echo """
		if [[ -f $inputFile.out ]]; then
			rm $inputFile.out
		fi
		Rscript processHismodsDisplay_cellType_specific.R $inputFile $inputFile.out """ > bsubFiles/`basename $inputFile`.bsub
	done
done
cat splits/multi-tissue.master.v2.distal.H3K27ac.bed.chr*.bed.out > multi-tissue.master.v2.distal.H3K27ac.cellType_specific.bed
cat splits/multi-tissue.master.v2.distal.H3K4me1.bed.chr*.bed.out > multi-tissue.master.v2.distal.H3K4me1.cellType_specific.bed
cat splits/multi-tissue.master.v2.distal.H3K9ac.bed.chr*.bed.out > multi-tissue.master.v2.distal.H3K9ac.cellType_specific.bed
cat splits/multi-tissue.master.v2.proximal.H3K27ac.bed.chr*.bed.out > multi-tissue.master.v2.proximal.H3K27ac.cellType_specific.bed
cat splits/multi-tissue.master.v2.proximal.H3K4me3.bed.chr*.bed.out > multi-tissue.master.v2.proximal.H3K4me3.cellType_specific.bed
cat splits/multi-tissue.master.v2.proximal.H3K9ac.bed.chr*.bed.out > multi-tissue.master.v2.proximal.H3K9ac.cellType_specific.bed
