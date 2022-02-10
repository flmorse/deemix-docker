FROM lsiobase/ubuntu:focal

ARG BUILDDATE
ENV BUILDDATEENV=${BUILDDATE}

LABEL \
    app.deemix.image.created="${BUILDDATE}" \
    app.deemix.image.url="https://gitlab.com/Bockiii/deemix-docker" \
    app.deemix.image.title="Docker image for Deemix" \
    app.deemix.image.description="Docker image for Deemix" \
    maintainer="Bocki"

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash && \
    apt-get -y --no-install-recommends install >/dev/null \
        nodejs \
        jq \
        iputils-ping \
        unzip \
        curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /downloads

RUN curl -L -o deemix.zip http://gitlab.com/Bockiii/deemix-src/-/jobs/artifacts/master/download?job=dl_src && \
    unzip deemix

COPY root/ /

EXPOSE 6595
ENTRYPOINT [ "/init" ]
