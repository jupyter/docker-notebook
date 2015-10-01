FROM ipython/notebook

ONBUILD COPY apt-dependencies.txt requirements.txt /
ONBUILD RUN if [ -s /apt-dependencies.txt ]; then \
              apt-get update -qq \
              && cat /apt-dependencies.txt | egrep -v '^#' | tr '\n' ' ' | \
                   DEBIAN_FRONTEND=noninteractive xargs apt-get install -yq --no-install-recommends \
              && rm -rf /var/lib/apt/lists/* ;\
            fi \
         && pip2 install --no-cache-dir -r /requirements.txt \
         && pip3 install --no-cache-dir -r /requirements.txt
