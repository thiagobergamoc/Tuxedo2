rule assemble:
    input:
        gtf = REF_GTF,
        bam = "data/mapped_reads/{sample}.bam",
    output:
        out = "data/mapped_reads/{sample}.gtf",
    conda:
        "envs/stringtie.yaml"
    shell:
        "stringtie -p {threads} -G {input.gtf} -o {output.out} –l {input.bam}"
rule merged_file:
    input:
        sp = "data/mapped_reads/{sample}.gtf"
    output:
        mergelist = "data/mapped_reads/mergelist.txt"
    script:
        "echo {input.sp} > {output.mergelist}"
rule merge_stringtie:
    input:
        lst = "data/mapped_reads/mergelist.txt",
        gtf = REF_GTF,
    output:
        merged = "data/mapped_reads/stringtie_merged.gtf"
    conda:
        "envs/stringtie.yaml"
    shell:
        "stringtie --merge -p {threads} -G {input.gtf} "
        "-o {output.merged} {input.lst}"
rule compare:
    input:
        gtf = REF_GTF,    
        merged = "data/mapped_reads/stringtie_merged.gtf",
    output:
        dr = directory("data/mapped_reads/merged")
    conda:
        "envs/gffcompare.yaml"
    shell:
        "gffcompare –r {input.gtf} –G –o {output.dr} {input.merged}"
rule abundance:
    input:
        gtf = "data/mapped_reads/stringtie_merged.gtf",
        bam = "data/mapped_reads/{sample}.bam",
    output:
       quant = "data/mapped_reads/abudance/{sample}.gtf"
    conda:
        "envs/stringtie.yaml"
    log:
        "report/stringtie/{sample}.log"
    shell:
        "stringtie –e –B -p {threads} -G {input.gtf} -o {output.quant} {input.bam}"
