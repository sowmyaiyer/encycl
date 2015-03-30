{
        for (f=7; f <= NF; f ++)
        {
                split($f,arr,"=")
                if (arr[2] >= 0.95)
                {
                        gsub("_"," ",arr[1])
                        printf("%s\t%d\t%d\t%s\t%.0f\t.\t0\t0\t%s\t%.2f\n",$1,$2,$3,arr[1],((arr[2]-0.95)/(1.00-0.95))*1000,color,arr[2]*100)
                }
        }
}
