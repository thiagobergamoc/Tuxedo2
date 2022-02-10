rule trimmomatic:
    input:
        "data/samples/{sample}_1.fq" 
        "data/samples/{sample}_2.fq" 
    output:
        "data/samples/trimm/{sample}_1.trim.fq" 
        "data/samples/trimm/{sample}_2.trim.fq" 
		"data/samples/trimm/{sample}_un1.trim.fq" 
        "data/samples/trimm/{sample}_un2.trim.fq" 
    conda:
        "envs/trimmomatic.yaml"
    log:
        "report/trimmomatic/{sample}.log"
    params:
        trimmomatic = config["trimmomatic"]
    shell:
        "trimmomatic PE -threads {threads} "
        "-basein {input[0]} {input[1]} "
        "-baseout {output[0]} {output[1]} {output[2]} {output[3]} "
        "{params.trimmomatic}"
