# Histone mod peaks usually flank DNase peaks. To calculate enrichment therefore, extend master peaks by 500 bases on either side to cover flanking hismod peaks

awk '{ printf("%s\t%d\t%d\tline_%d\n",$1,($2+$3)/2,($2+$3)/2,NR)}' $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.distal.bed | bedtools slop -b 500 -i stdin -g $HOME/TR/hg19.genome > $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.distal.1000.bed
awk '{ printf("%s\t%d\t%d\tline_%d\n",$1,($2+$3)/2,($2+$3)/2,NR)}' $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.proximal.bed | bedtools slop -b 500 -i stdin -g $HOME/TR/hg19.genome > $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.proximal.1000.bed

# Generate matching background. 
bedtools shuffle -i $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.distal.1000.bed -g $HOME/TR/hg19.genome -excl $HOME/nearline/decorate_dnase/dnase_master_V2/distal_excludable.bed > $HOME/nearline/decorate_dnase/dnase_master_V2/randombg.1000.distal.bed
bedtools shuffle -i $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.proximal.1000.bed -g $HOME/TR/hg19.genome -excl $HOME/nearline/decorate_dnase/dnase_master_V2/proximal_excludable.bed -incl  $HOME/nearline/decorate_dnase/gencode.v19.TSS_plusminus_2K.sorted.bed > $HOME/nearline/decorate_dnase/dnase_master_V2/randombg.1000.proximal.bed

# Calculate signal in foregroud and background for all histone mods
for signal_file in $HOME/nearline/decorate_dnase/dnase_master_V2/allhismodsignals/*bw
do
	bwFileName=`basename $signal_file`
	nm=`echo $bwFileName | cut -d"." -f1-2`
	echo """
	bigWigAverageOverBed $signal_file $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.distal.1000.bed $HOME/nearline/RECYCLE_BIN/$nm.distal.dnase.out -bedOut=$HOME/nearline/RECYCLE_BIN/$nm.distal.dnase.bed 
	awk '{ print \$NF}' $HOME/nearline/RECYCLE_BIN/$nm.distal.dnase.bed > $HOME/nearline/decorate_dnase/dnase_master_V2/$nm.dnase_peaks.distal.txt
	bigWigAverageOverBed $signal_file $HOME/nearline/decorate_dnase/dnase_master_V2/randombg.1000.distal.bed $HOME/nearline/RECYCLE_BIN/$nm.distal.random.out -bedOut=$HOME/nearline/RECYCLE_BIN/$nm.distal.random.bed 
	awk '{ print \$NF}' $HOME/nearline/RECYCLE_BIN/$nm.distal.random.bed > $HOME/nearline/decorate_dnase/dnase_master_V2/$nm.randomBg.distal.txt
	bigWigAverageOverBed $signal_file $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.proximal.1000.bed $HOME/nearline/RECYCLE_BIN/$nm.proximal.dnase.out -bedOut=$HOME/nearline/RECYCLE_BIN/$nm.proximal.dnase.bed
	awk '{ print \$NF}' $HOME/nearline/RECYCLE_BIN/$nm.proximal.dnase.bed > $HOME/nearline/decorate_dnase/dnase_master_V2/$nm.dnase_peaks.proximal.txt
	bigWigAverageOverBed $signal_file $HOME/nearline/decorate_dnase/dnase_master_V2/randombg.1000.proximal.bed $HOME/nearline/RECYCLE_BIN/$nm.proximal.random.out -bedOut=$HOME/nearline/RECYCLE_BIN/$nm.proximal.random.bed
	awk '{ print \$NF}' $HOME/nearline/RECYCLE_BIN/$nm.proximal.random.bed > $HOME/nearline/decorate_dnase/dnase_master_V2/$nm.randomBg.proximal.txt
	""" > bsubFiles/$bwFileName.bsub
done

# Code to calculate percentile over background for all histone mods
Rscript processHismods.R

# paste hismod percentiles across all celltypes with DNase master peaks to get one giant bed file for each hismod where enrichment in each cell type is a name value pair <celltype>=<percentilea

for hismod in {"H3K27ac","H3K4me1","H3K4me3","H3K9ac"}
do
        for distance in {"distal","proximal"}
        do
                paste  $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.${distance}.bed  $HOME/nearline/decorate_dnase/dnase_master_V2/*.${hismod}.${distance}.percentiles.txt >  $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.${distance}.${hismod}.bed
        done
done
