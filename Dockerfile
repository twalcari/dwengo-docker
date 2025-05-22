FROM quay.io/jupyter/tensorflow-notebook:cuda-latest


LABEL maintainer="Dwengo <info@dwengo.org>"

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install dependencies for webpdf export
RUN pip install --no-cache-dir \
    'nbconvert[webpdf]' && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

USER root
RUN /opt/conda/bin/playwright install-deps chromium-headless-shell 

USER jovyan
RUN /opt/conda/bin/playwright install chromium
