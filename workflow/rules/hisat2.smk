rule index:
    input:
        fasta = REF_FASTA,
        gft = REF_GTF,
    output:
        splicing = "data/genome/genome.ss",
        exon = "data/genome/genome.exon",
        index = directory("data/genome_index"),
    conda:
        "envs/hisat2.yaml"
    shell:
        "hisat2_extract_splice_sites.py {input.gft} > {output.splicing} &&"
        "hisat2_extract_exons.py {input.gft} > {output.exon} &&"
        "hisat2-build -p {threads} --exon {output.exon} "
        "--ss {output.splicing} {input.fasta} {output.index}"
rule align:
    input:
        f = "data/samples/trimm/{sample}_1.trim.fq",
        r = "data/samples/trimm/{sample}_2.trim.fq",
        index = "data/genome_index",
    output:
        sam = "mapped_reads/{sample}.sam"
    conda:
        "envs/hisat2.yaml"
    log:
        "report/hisat2/{sample}.log"
    shell:
        "hisat2 -p {threads} --dta -x {input.index} "
        "-1 {input.f} -2 {input.r} -S {output.sam}"
