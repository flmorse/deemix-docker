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
		yarn \
	git && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

#RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
#ENV NVM_DIR=/root/.nvm
#ENV NODE_VERSION=16.2.0
#RUN . $HOME/.nvm/nvm.sh && nvm install $NODE_VERSION && nvm alias default $NODE_VERSION && nvm use default

RUN git clone https://gitlab.com/RemixDev/deemix-gui.git --recursive && \
	rm -R /config && \
	mkdir /deemix-gui/server/music && \
	mkdir -p /deem/.config/deemix && \
	ln -sf /deemix-gui/server/music /downloads && \
	ln -sf /deem/.config/deemix /config

WORKDIR /deemix-gui/server

RUN npm install

COPY root/ /

EXPOSE 6595
ENTRYPOINT [ "/init" ]