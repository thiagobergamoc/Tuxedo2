rule index:
    input:
        "data/genome/genome.fa"
        "data/genome/genome.gtf"
    output:
        "data/genome/genome.ss"
        "data/genome/genome.exon"
        "data/genome_index/"
    conda:
        "envs/hisat2.yaml"
    shell:
        "hisat2_extract_splice_sites.py {input[1]} > {output[0]}"
        "hisat2_extract_exons.py {input[1]} > {output[1]}"
        "hisat2-build -p {threads} --exon {output[1]} --ss {output[0]} {input[0]} {output[1]}"
rule align:
    input:
        "data/samples/trimm/{sample}_1.trim.fq"
		"data/samples/trimm/{sample}_2.trim.fq"
        "data/genome_index"
    output:
        "mapped_reads/{sample}.sam"
    conda:
        "envs/hisat2.yaml"
    log:
        "report/hisat2/{sample}.log"
    shell:
        "hisat2 -p {threads} --dta -x {input[2]} -1 {input[0]} -2 {input[1]} -S {output}"
