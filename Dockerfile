FROM lsiobase/ubuntu:focal

ARG BUILDDATE
ENV BUILDDATEENV=${BUILDDATE}

LABEL \
	app.deemix.image.created="${BUILDDATE}" \
	app.deemix.image.url="https://gitlab.com/Bockiii/deemix-docker" \
    app.deemix.image.title="Docker image for Deemix" \
	app.deemix.image.description="Docker image for Deemix" \
    maintainer="Bocki"

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash && \
    chmod +x /root/.nvm/nvm.sh && \
    /root/.nvm/nvm.sh install 16.2.0

RUN apt-get update && \
    apt-get install -y git

RUN git clone https://gitlab.com/RemixDev/deemix-gui.git --recursive && \
    rm -R /config && \
    mkdir /deemix-gui/server/music && \
    mkdir -p /deem/.config/deemix && \
    ln -sf /deemix-gui/server/music /downloads && \
    ln -sf /deem/.config/deemix /config

WORKDIR /deemix-gui/server

RUN yarn install

COPY root/ /

EXPOSE 6595
ENTRYPOINT [ "/init" ]