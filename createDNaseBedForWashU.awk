{
	len=split($10,arr,",")
	printf("%s\t%d\t%d\tid:%s,name:\"%s\",desc:\"%s cell type(s) with DNase hypersensitivity\",details:{",$1,$2,$3,NR,$4,$11)
	for (i = 1; i <= len-1; i ++)
	{
		printf("\"%s\":\"\",",arr[i])
	}
	printf("\"%s\":\"\"}\n",arr[len])
}
