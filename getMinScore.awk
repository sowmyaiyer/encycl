BEGIN {min=100000000}
{
        if ($5 < min) min=$5
}
END {printf("%s",min)}
