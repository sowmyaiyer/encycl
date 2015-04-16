for hismod in {"H3K4me3","H3K9ac","H3K27ac","H3K4me1"}
do
        awk -vcolor=38,92,178 -f processHismod_for_display_celltype_specific.awk multi-tissue.master.v2.proximal.${hismod}.cellType_specific.bed > multi-tissue.master.v2.proximal.${hismod}.percentiles.for_display.normalized.cellType_specific.bed
        $HOME/bedToBigBed -tab  -type=bed9+2 -as=/home/iyers/public_html/encode_elements/sandbox/${hismod}_withDetails.as multi-tissue.master.v2.proximal.${hismod}.percentiles.for_display.normalized.cellType_specific.bed $HOME/hg19.genome /home/iyers/public_html/encode_elements/sandbox/proximal.${hismod}.cellType_specific.bb
        awk -vcolor=232,149,16 -f processHismod_for_display_celltype_specific.awk multi-tissue.master.v2.distal.${hismod}.cellType_specific.bed > multi-tissue.master.v2.distal.${hismod}.percentiles.for_display.normalized.cellType_specific.bed
        $HOME/bedToBigBed -tab  -type=bed9+2 -as=/home/iyers/public_html/encode_elements/sandbox/${hismod}_withDetails.as multi-tissue.master.v2.distal.${hismod}.percentiles.for_display.normalized.cellType_specific.bed $HOME/hg19.genome /home/iyers/public_html/encode_elements/sandbox/distal.${hismod}.cellType_specific.bb
done
