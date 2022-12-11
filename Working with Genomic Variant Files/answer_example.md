# Answers to questions from "Genomic Variant Files"

Q1: How many positions are found in this region in the VCF file?

```{bash}
tabix CEU.exon.2010_03.genotypes.vcf.gz 1:1105411-44137860 -h | bcftools query -f '%POS\n' | wc -l
```
A: 69
Q2: How many samples are included in the VCF file?
```{bash}
bcftools query -l CEU.exon.2010_03.genotypes.vcf.gz | wc -l
```
A:90 Samples

Q3: How many positions are there total in the VCF file?
```{bash}
bcftools query -f '%CHROM %POS %REF %ALT\n' CEU.exon.2010_03.genotypes.vcf.gz | wc -l
```
A:3489 positions
Q4: How many positions are there with AC=1?
```{bash}
bcftools filter -i AC=1 CEU.exon.2010_03.genotypes.vcf.gz | bcftools query -f '%INFO\n' | wc -l
```
A: 1075

Q5: What is the ratio of transitions to transversions (ts/tv) in this file?
A:3.46735

Q6: What is the median number of variants per sample in this data set?
A:28