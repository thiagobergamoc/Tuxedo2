rule assemble:
    input:
        REF_GTF,
        "sorted_reads/{sample}.bam"
    output:
        "data/genome/sample/{sample}.gtf"
    conda:
        "envs/stringtie.yaml"
    shell:
        "stringtie -p {threads} -G {input[0]} -o {output} –l {input[1]}"
rule merged_file:
    input:
        "data/samples/"
    output:
        "data/genome/mergelist.txt"
    script:
        "scripts/mergelist.py"
rule merge:
    input:
        REF_GTF ,
        "data/genome/mergelist.txt"
    output:
        "data/genome/stringtie_merged.gtf"
    conda:
        "envs/stringtie.yaml"
    shell:
        "stringtie --merge -p {threads} -G {input[0]} -o {output} {input[1]}"
rule compare:
    input:
        REF_GTF,    
        "data/genome/stringtie_merged.gtf"
    output:
        "data/genome/merged"
    conda:
        "envs/gffcompare.yaml"
    shell:
        "gffcompare –r {input[0]} –G –o {output} {input[1]}"
rule abundance:
    input:
        "data/genome/stringtie_merged.gtf"
        "sorted_reads/{sample}.bam"
    output:
        "abudance/{sample}.gtf"
    conda:
        "envs/stringtie.yaml"
    log:
        "report/stringtie/{sample}.log"
    shell:
        "stringtie –e –B -p {threads} -G {input[0]} -o {output} {input[1]}"
