rule trimmomatic:
    input:
        "data/samples/{sample}_1.fastq.gz"
        "data/samples/{sample}_2.fastq.gz"
    output:
        "data/samples/trimm/{sample}_1.trim.fq"
        "data/samples/trimm/{sample}_2.trim.fq"
		"data/samples/trimm/{sample}_1un.trim.fq"
		"data/samples/trimm/{sample}_2un.trim.fq"
    conda:
        "envs/trimmomatic.yaml"
    log:
        "report/trimmomatic/{sample}.log"
    shell:
        "trimmomatic PE {input[0]} {input[1]} {output[0]} {output[1]} {output[2]} {output[3]} {params.trimmomatic}"
