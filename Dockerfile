FROM lsiobase/alpine:3.15

RUN apk add --no-cache curl jq
ARG TARGETARCH
ARG STATIC_URL
ARG BUILDDATE
ENV BUILDDATEENV=${BUILDDATE}

LABEL \
    app.deemix.image.created="${BUILDDATE}" \
    app.deemix.image.url="https://gitlab.com/Bockiii/deemix-docker" \
    app.deemix.image.title="Docker image for Deemix" \
    app.deemix.image.description="Docker image for Deemix" \
    maintainer="Bocki"

RUN curl -L $STATIC_URL/deemix-server-linux-$TARGETARCH -o deemix-server

COPY root/ /

EXPOSE 6595
ENTRYPOINT [ "/init" ]
