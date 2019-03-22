FROM jupyter/datascience-notebook:41e066e5caa8
USER root
RUN set -ex && \
    apt-get update -qq && \
    apt-get install -y --no-install-recommends software-properties-common postgresql-client && \
    add-apt-repository ppa:git-core/ppa && \
    apt-get update -qq && \
    apt-get install -y git-lfs && \
    rm -rf /var/lib/apt/lists/*

USER $NB_USER

RUN set -ex && \
    echo 'echo "machine github.com login x-oauth-basic password $GITHUB_TOKEN" > ~/.netrc' >> ~/.bashrc && \
    echo "chmod 400 ~/.netrc" >> ~/.bashrc && \
    jupyter labextension install @jupyterlab/celltags @jupyterlab/toc @lckr/jupyterlab_variableinspector
