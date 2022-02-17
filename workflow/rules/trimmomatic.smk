rule trimmomatic:
    input:
        f = "data/samples/{sample}_1.fq",
        r = "data/samples/{sample}_2.fq",
    output:
        outF = "data/samples/trimm/{sample}_1.trim.fq",
        outR = "data/samples/trimm/{sample}_2.trim.fq",
        unF = "data/samples/trimm/{sample}_un1.trim.fq", 
        unR = "data/samples/trimm/{sample}_un2.trim.fq",
    conda:
        "envs/trimmomatic.yaml"
    log:
        "report/trimmomatic/{sample}.log"
    params:
        trimmomatic = config["trimmomatic"]
    shell:
        "trimmomatic PE -threads {threads} "
        "-basein {input.f} {input.r} "
        "-baseout {output.outF} {output.outR} {output.unF} {output.unR} "
        "{params.trimmomatic}"
