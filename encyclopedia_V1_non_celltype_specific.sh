########## DNase operations  ##########
# Process data
./processDNaseMasterList.sh
# Display for UCSC browser
./processDNaseTracks_for_display.sh
# Display for WashU browser
./processDNaseTracks_for_display_washu.sh

# Compress for washu hammock track
bgzip dnase.distal.washu.bed
tabix dnase.distal.washu.bed.gz

bgzip dnase.proximal.washu.bed
tabix dnase.proximal.washu.bed.gz

########## END DNase operations  ##########

########## Hismod operations  ##########
# Process data
./processHismods.sh
# Display for UCSC browser
./processHismodTracks_for_display.sh
# Display for WashU browser
./processHismodTracks_for_display_washu.sh

# Compress for washu hammock track
for hismod in {"H3K27ac","H3K4me1","H3K9ac","H3K4me3"}
do
        echo $hismod
        bgzip distal.${hismod}.washu.formatted.bed
        tabix distal.${hismod}.washu.formatted.bed.gz
        bgzip proximal.${hismod}.washu.formatted.bed
        tabix proximal.${hismod}.washu.formatted.bed.gz
done

########## END hismod operations ##########

########## TF operations ##########
# Process data
./processTFPeaks.sh
# Display for UCSC browser
./processTFTracks_for_display.sh
# Display for WashU browser
./processTFTracks_for_display_washu.sh

# Compress for washu hammock track
bgzip tf_washu_distal.display.bed
tabix tf_washu_distal.display.bed.gz

bgzip tf_washu_proximal.display.bed
tabix tf_washu_proximal.display.bed.gz

######### END TF operations ############
