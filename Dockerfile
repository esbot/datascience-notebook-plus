FROM jupyter/datascience-notebook:dc9744740e12
USER root
RUN set -ex && \
    apt-get update -qq && \
    apt-get install -y --no-install-recommends software-properties-common postgresql-client && \
    add-apt-repository ppa:git-core/ppa && \
    apt-get update -qq && \
    apt-get install -y git-lfs && \
    apt-get install -y redis-server && \
    apt-get install -y tesseract-ocr libtesseract-dev && \
    rm -rf /var/lib/apt/lists/*
USER $NB_USER

RUN set -ex && \
    echo 'echo "machine github.com login x-oauth-basic password $GITHUB_TOKEN" > ~/.netrc' >> ~/.bashrc && \
    echo "chmod 400 ~/.netrc" >> ~/.bashrc
