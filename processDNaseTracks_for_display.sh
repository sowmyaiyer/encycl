awk '{ if (NR > 1) { gsub("_", " ", $4); print $3"\t"$4} } ' Sowmya_cell_types_all.tsv | sort | uniq | sed 's/ $//g' > code_cellnames.txt

Rscript processDNaseTrackForDisplay.R multi-tissue.master.v2.distal.bed dnase.distal.bed "94,207,74"
$HOME/bedToBigBed -tab -type=bed9+2 -as=/home/iyers/public_html/encode_elements/display/dnase.track.as dnase.distal.bed $HOME/hg19.genome /home/iyers/public_html/encode_elements/sandbox/dnase_track_distal.bb

Rscript processDNaseTrackForDisplay.R multi-tissue.master.v2.proximal.bed dnase.proximal.bed "51,138,87"
# Manually changed score column for chrX    153190340       153190490 in dnase.proximal.bed - it was "inf" in source and therefore NA in dnase.proximal.bed
$HOME/bedToBigBed -tab -type=bed9+2 -as=/home/iyers/public_html/encode_elements/display/dnase.track.as dnase.proximal.bed $HOME/hg19.genome /home/iyers/public_html/encode_elements/sandbox/dnase_track_proximal.bb
