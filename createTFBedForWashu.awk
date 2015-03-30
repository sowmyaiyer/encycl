#chr1   793425  793575  CTCF    AG09319.BE2_C.Dnd41.GM12873.HCM.HCPEpiC.HMF.HRPEpiC.K562.Osteobl
#chr1   793680  793830  CTCF    BE2_C.HCM
#chr1   801065  801215  MEF2A,MEF2C,POU2F2      GM12878,GM12878,GM12878.GM12891
#chr1   801240  801390  MEF2A,MEF2C,POU2F2      GM12878,GM12878,GM12878.GM12891
{
	len_tfs=split($4,tfs,",")
	len_celltypes=split($5,celltypes,",")
	if (len_tfs > 5)
		name="multiple"
	else
		name=$4
	printf("%s\t%d\t%d\tid:%s,name:\"%s\",desc:\"%s Transcription Factor(s)\",details:{",$1,$2,$3,NR,name,len_tfs)
	for (i = 1; i <= len_tfs-1; i ++)
	{
		gsub("\.",",",celltypes[i])
		printf("\"%s\":\"%s\",",tfs[i],celltypes[i])
	}
	gsub("\.",",",celltypes[len_tfs])
	printf("\"%s\":\"%s\"}\n",tfs[len_tfs],celltypes[len_tfs])
}
