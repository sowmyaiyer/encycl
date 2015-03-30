BEGIN {max=-1}
{
        if ($5 > max) max=$5
}
END {printf("%s",max)}
