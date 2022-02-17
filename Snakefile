import glob

REF_FASTA = "/data/genome/chr21.fa",
REF_GTF = "/data/genome/chr21.gtf",
SAMPLE = "chr21",

configfile: "config/config.yaml"

include: "workflow/rules/trimmomatic.smk",
include: "workflow/rules/hisat2.smk",
include: "workflow/rules/samtools.smk",
include: "workflow/rules/stringtie.smk",

rule all:
    input: 
        "data/mapped_reads/stringtie_merged.gtf"




