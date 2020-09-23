FROM lsiobase/alpine:3.12

ARG BUILDDATE

LABEL \
	app.deemix.image.created="${BUILDDATE}" \
	app.deemix.image.url="https://gitlab.com/Bockiii/deemix-docker" \
    app.deemix.image.title="Docker image for Deemix" \
	app.deemix.image.description="Docker image for Deemix and the pyweb frontend" \
    maintainer="Bocki"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
    gcc \
    g++ \
    libffi-dev \
    python3-dev \
    git \
    curl \
    make && \
 echo "**** install packages ****" && \
 apk add --no-cache \
    py3-pip \
    python3 && \
 echo "**** setup directories ****" && \
 mkdir /deem && \
 chown abc:abc /deem && \
 rm -R /config && \
 ln -sf /deem/.config/deemix /config && \
 ln -sf /downloads /deem/deemix\ Music && \
 echo "**** clean up ****" && \
 rm -rf \
	/root/.cache \
	/tmp/*

COPY root/ /

EXPOSE 6595
VOLUME /downloads /config