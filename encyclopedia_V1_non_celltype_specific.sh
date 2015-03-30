# Operations on data
./processNewMasterList.sh
./processHismods.sh
./processTFPeaks.sh
# END Operations on data

# Display for UCSC browser
./processDNaseTracks_for_display.sh
./processHismodTracks_for_display.sh
./processTFTracks_for_display.sh
# END Display for UCSC browser

# Display for WashU browser
./processDNaseTracks_for_display_washu.sh
./processHismodTracks_for_display_washu.sh
./processTFTracks_for_display_washu.sh
# END Display for WashU browser

# Compress files for WashU hammock track display
for hismod in {"H3K27ac","H3K4me1","H3K9ac"}
do
        echo $hismod
        bgzip distal.${hismod}.washu.formatted.bed
        tabix distal.${hismod}.washu.formatted.bed.gz
done
for hismod in {"H3K4me3","H3K9ac","H3K27ac"}
do
        echo $hismod
        bgzip proximal.${hismod}.washu.formatted.bed
        tabix proximal.${hismod}.washu.formatted.bed.gz
done

bgzip tf_washu_distal.display.bed
tabix tf_washu_distal.display.bed.gz

bgzip tf_washu_proximal.display.bed
tabix tf_washu_proximal.display.bed.gz

# END Compress files for WashU hammock track display
