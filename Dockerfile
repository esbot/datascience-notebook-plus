FROM jupyter/datascience-notebook:41e066e5caa8
USER root
RUN set -ex && \
    apt-get update -qq && \
    apt-get install -y --no-install-recommends software-properties-common postgresql-client && \
    add-apt-repository ppa:git-core/ppa && \
    apt-get update -qq && \
    apt-get install -y git-lfs && \
    apt-get install -y tesseract-ocr libtesseract-dev && \
    rm -rf /var/lib/apt/lists/*
USER $NB_USER

RUN set -ex && \
    pip install --quiet --no-cache-dir "dask_labextension" && \
    jupyter labextension install dask-labextension

RUN set -ex && \
    pip install --quiet --no-cache-dir "jupyter-server-proxy" && \
    jupyter labextension install jupyterlab-server-proxy

RUN set -ex && \
    echo 'echo "machine github.com login x-oauth-basic password $GITHUB_TOKEN" > ~/.netrc' >> ~/.bashrc && \
    echo "chmod 400 ~/.netrc" >> ~/.bashrc && \
    jupyter labextension install @jupyterlab/celltags @jupyterlab/toc @lckr/jupyterlab_variableinspector
