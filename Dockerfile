FROM lsiobase/ubuntu:focal as builder

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash && \
	apt-get -y --no-install-recommends install >/dev/null \
		nodejs \
		build-essential \
		git && \
	npm install --global yarn

RUN git clone https://gitlab.com/RemixDev/deemix-gui.git --recursive

WORKDIR /deemix-gui

RUN yarn config set network-timeout 1000000 -g && \
	yarn install-all && \
	yarn build-server && \
	yarn build-webui && \
	yarn cache clean && \
	find . -name 'node_modules' -type d -prune -exec rm -rf '{}' \;

FROM lsiobase/ubuntu:focal

ARG BUILDDATE
ENV BUILDDATEENV=${BUILDDATE}

LABEL \
	app.deemix.image.created="${BUILDDATE}" \
	app.deemix.image.url="https://gitlab.com/Bockiii/deemix-docker" \
	app.deemix.image.title="Docker image for Deemix" \
	app.deemix.image.description="Docker image for Deemix" \
	maintainer="Bocki"

COPY --from=builder /deemix-gui /deemix-gui

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash && \
	apt-get -y --no-install-recommends install >/dev/null \
		nodejs \
		jq \
		iputils-ping \
		curl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	npm install --global yarn

RUN rm -R /config && \
	mkdir /deemix-gui/server/music && \
	mkdir -p /deem/.config/deemix && \
	ln -sf /deemix-gui/server/music /downloads && \
	ln -sf /deem/.config/deemix /config

WORKDIR /deemix-gui

RUN yarn config set network-timeout 1000000 -g && \
	yarn install --prod && \
	yarn --cwd server install --prod && \
	yarn cache clean


WORKDIR /deemix-gui

COPY root/ /

EXPOSE 6595
ENTRYPOINT [ "/init" ]
