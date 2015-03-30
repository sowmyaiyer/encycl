bedtools groupby -i multi-tissue.master.v2.proximal.H3K9ac.percentiles.for_display.normalized.bed -c 4,10 -o collapse,collapse > proximal.H3K9ac.washu.bed
bedtools groupby -i multi-tissue.master.v2.proximal.H3K4me3.percentiles.for_display.normalized.bed -c 4,10 -o collapse,collapse > proximal.H3K4me3.washu.bed
bedtools groupby -i multi-tissue.master.v2.proximal.H3K27ac.percentiles.for_display.normalized.bed -c 4,10 -o collapse,collapse > proximal.H3K27ac.washu.bed
bedtools groupby -i multi-tissue.master.v2.distal.H3K9ac.percentiles.for_display.normalized.bed -c 4,10 -o collapse,collapse > distal.H3K9ac.washu.bed
bedtools groupby -i multi-tissue.master.v2.distal.H3K4me1.percentiles.for_display.normalized.bed -c 4,10 -o collapse,collapse > distal.H3K4me1.washu.bed
bedtools groupby -i multi-tissue.master.v2.distal.H3K27ac.percentiles.for_display.normalized.bed -c 4,10 -o collapse,collapse > distal.H3K27ac.washu.bed

awk -F"\t" -vtrackname="Distal H3K27ac" -f createHismodBedForWashU.awk distal.H3K27ac.washu.bed > distal.H3K27ac.washu.formatted.bed 
awk -F"\t" -vtrackname="Distal H3K9ac" -f createHismodBedForWashU.awk distal.H3K9ac.washu.bed > distal.H3K9ac.washu.formatted.bed 
awk -F"\t" -vtrackname="Distal H3K4me1" -f createHismodBedForWashU.awk distal.H3K4me1.washu.bed > distal.H3K4me1.washu.formatted.bed 
awk -F"\t" -vtrackname="Proximal H3K27ac" -f createHismodBedForWashU.awk proximal.H3K27ac.washu.bed > proximal.H3K27ac.washu.formatted.bed 
awk -F"\t" -vtrackname="Proximal H3K4me3" -f createHismodBedForWashU.awk proximal.H3K4me3.washu.bed > proximal.H3K4me3.washu.formatted.bed 
awk -F"\t" -vtrackname="Proximal H3K9ac" -f createHismodBedForWashU.awk proximal.H3K9ac.washu.bed > proximal.H3K9ac.washu.formatted.bed 
