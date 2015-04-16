for hismod in {"H3K4me3","H3K9ac","H3K27ac","H3K4me1"}
do
        awk -vcolor=38,92,178 -f processHismod_for_display.awk multi-tissue.master.v2.proximal.${hismod}.bed > multi-tissue.master.v2.proximal.${hismod}.percentiles.for_display.normalized.bed
        $HOME/bedToBigBed -tab  -type=bed9+2 -as=/home/iyers/public_html/encode_elements/sandbox/${hismod}_withDetails.as multi-tissue.master.v2.proximal.${hismod}.percentiles.for_display.normalized.bed $HOME/hg19.genome /home/iyers/public_html/encode_elements/sandbox/proximal.${hismod}.bb
	 awk -vcolor=232,149,16 -f processHismod_for_display.awk multi-tissue.master.v2.distal.${hismod}.bed > multi-tissue.master.v2.distal.${hismod}.percentiles.for_display.normalized.bed
        $HOME/bedToBigBed -tab  -type=bed9+2 -as=/home/iyers/public_html/encode_elements/sandbox/${hismod}_withDetails.as multi-tissue.master.v2.distal.${hismod}.percentiles.for_display.normalized.bed $HOME/hg19.genome /home/iyers/public_html/encode_elements/sandbox/distal.${hismod}.bb
done
