max=`awk -f getMaxScore.awk multi-tissue.master.v2.distal_intersect_allchipseq_peaks.tf_collapsed.bed`
min=`awk -f getMinScore.awk multi-tissue.master.v2.distal_intersect_allchipseq_peaks.tf_collapsed.bed`
awk -vmin=$min -vmax=$max '{
                split($4,tfs,",")
                name=""
                if (length(tfs) > 5)
                {
                        name="multiple"
                } else {
                        name=$4
                }
                printf("%s\t%d\t%d\t%s\t%.0f\t%s\n",$1,$2,$3,name,(($5-min)/(max-min))*1000, $6) }
                ' multi-tissue.master.v2.distal_intersect_allchipseq_peaks.tf_collapsed.bed > multi-tissue.master.v2.distal_intersect_allchipseq_peaks.tf_collapsed.normalized.bed
$HOME/bedToBigBed -tab -type=bed5+1 -as=$HOME/public_html/encode_elements/display/tf.track.2.as multi-tissue.master.v2.distal_intersect_allchipseq_peaks.tf_collapsed.normalized.bed ~/hg19.genome $HOME/public_html/encode_elements/sandbox/tf.distal.bb

max=`awk -f getMaxScore.awk multi-tissue.master.v2.proximal_intersect_allchipseq_peaks.tf_collapsed.bed`
min=`awk -f getMinScore.awk multi-tissue.master.v2.proximal_intersect_allchipseq_peaks.tf_collapsed.bed`
awk -vmin=$min -vmax=$max '{
                split($4,tfs,",")
                name=""
                if (length(tfs) > 5)
                {
                        name="multiple"
                } else {
                        name=$4
                }
                printf("%s\t%d\t%d\t%s\t%.0f\t%s\n",$1,$2,$3,name,(($5-min)/(max-min))*1000, $6) }
                ' multi-tissue.master.v2.proximal_intersect_allchipseq_peaks.tf_collapsed.bed > multi-tissue.master.v2.proximal_intersect_allchipseq_peaks.tf_collapsed.normalized.bed

$HOME/bedToBigBed -tab -type=bed5+1 -as=$HOME/public_html/encode_elements/display/tf.track.2.as multi-tissue.master.v2.proximal_intersect_allchipseq_peaks.tf_collapsed.normalized.bed ~/hg19.genome $HOME/public_html/encode_elements/sandbox/tf.proximal.bb
