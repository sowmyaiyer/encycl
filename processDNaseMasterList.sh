# Three data files given by Bob Thurman
# multi-tissue.master.v2.hg19.bed = master peaks
# multi-tissue.master.v2.ntypes.simple.names.hg19.txt = cell types comprised in each DNase peak cluster
# multi-tissue.master.ntypes.simple.hg19.txt is NOT USED. This just has the number of DNase datasets merged to form the cluster

# Step 1: Paste master peak coords and cell types into one file
paste $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.hg19.bed $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.ntypes.simple.names.hg19.txt > $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.bed

# Separate master peaks into proximal and distal
bedtools intersect -a $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.bed -b $HOME/nearline/decorate_dnase/gencode.v19.TSS_plusminus_2K.sorted.bed -u > $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.proximal.bed
bedtools intersect -a $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.bed -b $HOME/nearline/decorate_dnase/gencode.v19.TSS_plusminus_2K.sorted.bed -v > $HOME/nearline/decorate_dnase/dnase_master_V2/multi-tissue.master.v2.distal.bed

# Preprocessing step before forming random background to calculated histone mod enrichment percentiles
./combine_Dnase_peaks_for_exclusion.sh
