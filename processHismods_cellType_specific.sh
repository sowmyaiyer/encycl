for celltype in `cut -f1 cellTypesWithAtleastOneHismod.txt`
do
        echo $celltype
        ds_celltypes=`awk -v celltype=$celltype '{ if ($2 == celltype) printf($1"\t")}' code_cellnames.for_hismod_processing.txt`
        search=`echo $ds_celltypes | sed 's/ / -e /g'`
        echo """
        grep -e $search $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.bed > $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.${celltype}.bed
        grep -e $search $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.distal.bed > $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.distal.${celltype}.bed
        grep -e $search $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.proximal.bed > $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.proximal.${celltype}.bed
        awk '{ printf(\"%s\\t%d\\t%d\\tline_%d\\n\",\$1,(\$2+\$3)/2,(\$2+\$3)/2,NR)}' $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.distal.${celltype}.bed | bedtools slop -b 500 -i stdin -g $HOME/TR/hg19.genome > $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.distal.1000.${celltype}.bed
        awk '{ printf(\"%s\\t%d\\t%d\\tline_%d\\n\",\$1,(\$2+\$3)/2,(\$2+\$3)/2,NR)}' $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.proximal.${celltype}.bed | bedtools slop -b 500 -i stdin -g $HOME/TR/hg19.genome > $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.proximal.1000.${celltype}.bed

        bedtools shuffle -i $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.distal.1000.${celltype}.bed -g $HOME/TR/hg19.genome -excl $HOME/nearline/decorate_dnase/dnase_master_V2/distal_excludable.bed > $HOME/nearline/decorate_dnase/dnase_master_V2/randombg.1000.distal.${celltype}.bed
        bedtools shuffle -i $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.proximal.1000.${celltype}.bed -g $HOME/TR/hg19.genome -excl $HOME/nearline/decorate_dnase/dnase_master_V2/proximal_excludable.bed -incl  $HOME/nearline/decorate_dnase/gencode.v19.TSS_plusminus_2K.sorted.bed > $HOME/nearline/decorate_dnase/dnase_master_V2/randombg.1000.proximal.${celltype}.bed
        """ > bsubFiles/celltype_specific_bg.${celltype}.bsub
done

for signal_file in $HOME/nearline/decorate_dnase/dnase_master_V2/allhismodsignals/*bw
do
	bwFileName=`basename $signal_file`
	nm=`echo $bwFileName | cut -d"." -f1-2`
	celltype=`echo $bwFileName | cut -d"." -f1`
	echo """
	bigWigAverageOverBed $signal_file $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.distal.1000.${celltype}.bed $HOME/nearline/RECYCLE_BIN/$nm.distal.dnase.${celltype}.out -bedOut=$HOME/nearline/RECYCLE_BIN/$nm.distal.dnase.${celltype}.bed 
	awk '{ print \$NF}' $HOME/nearline/RECYCLE_BIN/$nm.distal.dnase.${celltype}.bed > $HOME/nearline/decorate_dnase/dnase_master_V2/allhismodsignals/$nm.dnase_peaks.distal.${celltype}.txt
	bigWigAverageOverBed $signal_file $HOME/nearline/decorate_dnase/dnase_master_V2/randombg.1000.distal.${celltype}.bed $HOME/nearline/RECYCLE_BIN/$nm.distal.random.${celltype}.out -bedOut=$HOME/nearline/RECYCLE_BIN/$nm.distal.random.${celltype}.bed 
	awk '{ print \$NF}' $HOME/nearline/RECYCLE_BIN/$nm.distal.random.${celltype}.bed > $HOME/nearline/decorate_dnase/dnase_master_V2/allhismodsignals/$nm.randomBg.distal.${celltype}.txt
	bigWigAverageOverBed $signal_file $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.proximal.1000.${celltype}.bed $HOME/nearline/RECYCLE_BIN/$nm.proximal.dnase.${celltype}.out -bedOut=$HOME/nearline/RECYCLE_BIN/$nm.proximal.dnase.${celltype}.bed
	awk '{ print \$NF}' $HOME/nearline/RECYCLE_BIN/$nm.proximal.dnase.${celltype}.bed > $HOME/nearline/decorate_dnase/dnase_master_V2/allhismodsignals/$nm.dnase_peaks.proximal.${celltype}.txt
	bigWigAverageOverBed $signal_file $HOME/nearline/decorate_dnase/dnase_master_V2/randombg.1000.proximal.${celltype}.bed $HOME/nearline/RECYCLE_BIN/$nm.proximal.random.${celltype}.out -bedOut=$HOME/nearline/RECYCLE_BIN/$nm.proximal.random.${celltype}.bed
	awk '{ print \$NF}' $HOME/nearline/RECYCLE_BIN/$nm.proximal.random.${celltype}.bed > $HOME/nearline/decorate_dnase/dnase_master_V2/allhismodsignals/$nm.randomBg.proximal.${celltype}.txt
	""" > bsubFiles/celltype_specific_hismod.$bwFileName.bsub
done
