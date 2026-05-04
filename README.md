# Germline Variant Calling Pipeline

**Production-ready pipeline for germline variant detection from WGS/WES data.**

## Features

- FASTQC - Quality control of raw reads
- BWA-MEM - Read alignment to reference genome
- bcftools - Variant calling (mpileup + call)
- MultiQC - Aggregated HTML report
- Conda - 100% reproducible environment
- GitHub Actions - CI/CD automated testing

## Quick Start

```bash
# Clone repository
git clone https://github.com/YOUR_USERNAME/germline-variant-pipeline.git
cd germline-variant-pipeline

# Create conda environment
conda env create -f environment.yml
conda activate pipeline

# Run pipeline with test data
nextflow run main.nf -profile conda \
  --reads 'test/data/sample_*.fastq.gz' \
  --reference 'test/data/reference.fa' \
  --outdir test_results# germline-variant-pipeline
Production-ready nextflow pipeline for germline variant calling from WGS data
Input Requirements
Input	Format	Pattern
Reads	FASTQ.gz (paired)	*_{1,2}.fastq.gz
Reference	FASTA	*.fa or *.fastaOutput Structure
text
results/
├── aligned/              # BAM files + alignment stats
│   ├── sample.bam
│   ├── sample.bam.bai
│   └── sample.flagstat.txt
├── variants/             # VCF files
│   ├── sample.vcf.gz
│   ├── sample.vcf.gz.csi
│   └── sample.stats.txt
└── multiqc/              # HTML report
    ├── multiqc_report.html
    └── multiqc_data/Pipeline Steps
FASTQC - Quality control on raw reads

BWA-MEM - Align reads to reference genome

SAMtools - Sort and index BAM files

bcftools - Variant calling and compression

MultiQC - Aggregate all QC reportsRunning with Real Data
bash
nextflow run main.nf -profile conda \
  --reads 'data/NA12878_R{1,2}.fastq.gz' \
  --reference 'data/hg38.fa' \
  --outdir results
Filtering Variants
bash
python bin/filter_vcf.py results/variants/sample.vcf.gz filtered.vcf.gz --min-dp 10 --min-gq 20Requirements
Nextflow (>=23.10.0)

Conda (Miniconda or Anaconda)

8+ CPU cores recommended

16+ GB RAM recommended

Troubleshooting
Issue	Solution
conda: command not found	Install Miniconda first
nextflow: command not found	sudo mv nextflow /usr/local/bin/
Out of memory	Reduce cpus in nextflow.config
Author
Kelton

GitHub: @kelton

License
MIT

```bash

