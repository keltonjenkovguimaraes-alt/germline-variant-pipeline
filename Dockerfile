FROM continuumio/miniconda3:latest

COPY environment.yml /tmp/environment.yml
RUN conda env create -f /tmp/environment.yml

SHELL ["conda", "run", "-n", "pipeline", "/bin/bash", "-c"]

COPY . /app
WORKDIR /app

ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "pipeline", "nextflow"]
CMD ["run", "main.nf"]
