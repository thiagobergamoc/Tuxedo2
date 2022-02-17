rule sam2bam:
    input:
        sam = "data/mapped_reads/{sample}.sam"
    output:
        bam = "data/mapped_reads/{sample}.bam"
    conda:
        "envs/samtools.yaml"
    log:
        "report/samtools/{sample}.log"
    shell:
        "samtools view -u {input.sam} | samtools sort -o {output.bam}"