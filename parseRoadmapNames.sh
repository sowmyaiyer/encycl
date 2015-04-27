# Used Automator to get list of uniformly processed files from http://www.broadinstitute.org/~anshul/projects/roadmap/peaks/36bpReadLensFiltered/narrowPeak/
# This file is roadmap_processed_files
# Manually changed this file to alter cell names beginning with iPS to make it parseable (split by ".") These cell types had "." in them - replaced with "_"
awk -F"." '{ print $2"\t"$3"\thttp://www.broadinstitute.org/~anshul/projects/roadmap/signal/36bpReadLensFiltered/foldChange/"$0}'  roadmap_processed_files > roadmap_processed_files_exp
sort -k1,1 roadmap_processed_files_exp > roadmap_processed_files_exp.sorted
sort -k3,3 Sowmya_cell_types_in_master_list.tsv > Sowmya_cell_types_in_master_list.tsv.sorted
join Sowmya_cell_types_in_master_list.tsv.sorted roadmap_processed_files_exp.sorted  -1 3 -2 1 | awk -F" " '{ print $2"\t"$3"\t"$1"\t"$4"\t"$7"\t"$8}' > Sowmya_cell_types_in_master_list.roadmap.tsv
awk '{ print $1"\t"$2}' Sowmya_cell_types_in_master_list.roadmap.tsv | sort | uniq | sort -k1,1 > master_list_codes_roadmap.txt
grep ChromatinAccessibility roadmap_processed_files_exp.sorted | awk '{start=index($NF,"DS"); sub1=substr($NF,start);stop=index(sub1,".")-1;print(substr(sub1,1,stop))"\t"$1}' | sed 's/ /\t/g' | sort -k1,1 > roadmap_cell_types_withDS.txt
join master_list_codes_roadmap.txt roadmap_cell_types_withDS.txt -1 1 -2 1 -a 1 | sed 's/ /\t/g' | awk '{ print $0"\tROADMAP\tChromatinAccessibility" }' > master_list_codes_merged_with_DS.txt
# Found 4 unmatched DS numbers, filled out the cell type manually
#DS15123 fAdrenal
#DS15643 fHeart
#DS17068 fKidney
#DS20988 fKidney

while read celltype_full; do
       ds=`echo $celltype_full | awk '{ print $1"\t"$2"\t"$3"\t"$4}'`
       celltype=`echo $celltype_full | awk '{ print $3}'`
       for hismod in {"H3K27ac","H3K4me1","H3K4me3","H3K9ac"}
       do
	       	if [ $(grep -c "$celltype.*$hismod" roadmap_processed_files_exp.sorted) -ne 0 ]
		then
	                echo -e "${ds}"' \t '${hismod}' \t '`grep "$celltype.*$hismod" roadmap_processed_files_exp.sorted | awk -F"\t" '{ print $NF}'`
		fi
       done
done <master_list_codes_merged_with_DS.txt > roadmap_hismods.txt
cat master_list_codes_merged_with_DS.txt roadmap_hismods.txt | sort -k3,3 > roadmap_codes.txt
