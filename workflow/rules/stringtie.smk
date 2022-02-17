rule assemble:
    input:
        gtf = REF_GTF,
        bam = "sorted_reads/{sample}.bam",
    output:
        out = "data/genome/sample/{sample}.gtf",
    conda:
        "envs/stringtie.yaml"
    shell:
        "stringtie -p {threads} -G {input.gtf} -o {output.out} –l {input.bam}"
rule merged_file:
    input:
        sp = "data/samples/",
    output:
        mergelist = "data/genome/mergelist.txt",
    script:
         "ls {input.sp} > {output.mergelist}"
rule merge:
    input:
        lst = "data/genome/mergelist.txt",
        gtf = REF_GTF
    output:
        merged = "data/genome/stringtie_merged.gtf"
    conda:
        "envs/stringtie.yaml"
    shell:
        "stringtie --merge -p {threads} -G {input.gtf} "
        "-o {output.merged} {input.lst}"
rule compare:
    input:
        gtf = REF_GTF,    
        merged = "data/genome/stringtie_merged.gtf",
    output:
        dr = directory("data/genome/merged")
    conda:
        "envs/gffcompare.yaml"
    shell:
        "gffcompare –r {input.gtf} –G –o {output.dr} {input.merged}"
rule abundance:
    input:
        gtf = "data/genome/stringtie_merged.gtf",
        bam = "sorted_reads/{sample}.bam",
    output:
       quant = "abudance/{sample}.gtf"
    conda:
        "envs/stringtie.yaml"
    log:
        "report/stringtie/{sample}.log"
    shell:
        "stringtie –e –B -p {threads} -G {input.gtf} -o {output.quant} {input.bam}"
