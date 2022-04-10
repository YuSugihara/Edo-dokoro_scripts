
# Get genotype table for chloroplast
# Output file 'genotype_table_CP.txt' is in '61_genotype_tables'.

bcftools view -m 2 \
              -M 2 \
              -i 'F_MISSING=0' \
              vcf_pp_CPMT_kita_waka_mzawa_edo_yuga_utsu_mie_quinq.vcf.gz | \
bcftools query -f '%CHROM %POS %REF %ALT [%GT ]\n' | \
grep -v '0/1' | \
grep 'CP' > genotype_table_CP.txt


# Get genotype table for mitochondria
# Output file 'genotype_table_MT.txt' is in '61_genotype_tables'.

bcftools view -m 2 \
              -M 2 \
              -i 'F_MISSING=0' \
              vcf_pp_CPMT_kita_waka_mzawa_edo_yuga_utsu_mie_quinq.vcf.gz | \
bcftools query -f '%CHROM %POS %REF %ALT [%GT ]\n' | \
grep -v '0/1' | \
grep 'MT' > genotype_table_MT.txt



# Convert genotype table to FASTA format
# The python script 'get_CPMT_fasta.py' and output files are in '62_fasta_files'

get_CPMT_fasta.py genotype_table_CP.txt > SNPs_CP.fasta
get_CPMT_fasta.py genotype_table_MT.txt > SNPs_MT.fasta



# Reconstruct organellar trees
# Output files are in '63_trees/CP' and '63_trees/MT'
# Run IQ-TREE for chloroplast markers

iqtree -s SNPs_CP.fasta \
       -m MFP \
       -st DNA \
       -bb 1000

# Run IQ-TREE for mitochondria markers

iqtree -s SNPs_MT.fasta \
       -m MFP \
       -st DNA \
       -bb 1000
