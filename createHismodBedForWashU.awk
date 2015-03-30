{
	gsub("_"," ",$4)
	len=split($4,celltypes,",")
	len_percentiles=split($5,percentiles,",")
	printf("%s\t%d\t%d\tid:%s,name:\" \",desc:\"%s cell type(s) with enrichment greater than 95th percentile of background\",details:{",$1,$2,$3,NR,len)
	for (i = 1; i <= len-1; i ++)
	{
		printf("\"%s\":\"%s\",",celltypes[i],percentiles[i])
	}
	printf("\"%s\":\"%s\"}\n",celltypes[len],percentiles[len])
}
