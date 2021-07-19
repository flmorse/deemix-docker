# deemix-docker

Deemix in a Docker container.

## How to run this

Run the container either via commandline or via docker-compose (see the provided example file).
Check the parameter explanation below to see which ones are mandatory.

### Example for Docker:
```
$ docker run -d --name Deemix \
				-v /your/storage/path/:/downloads \
				-v /your/config/location:/config \
				-e PUID=1000 \
				-e PGID=1000 \
				-e UMASK_SET=022 \
				-p 6595:6595 \
				registry.gitlab.com/bockiii/deemix-docker
```

### Example for Docker Compose:
```
version: '3.3'
services:
	deemix:
		image: registry.gitlab.com/bockiii/deemix-docker
		container_name: Deemix
		volumes:
			- /your/storage/path/:/downloads
			- /your/config/location:/config
		environment:
			- PUID=1000
			- PGID=1000
			- UMASK_SET=022
		ports:
			- 6595:6595
```

### Updating Deemix

Pull the latest container for the latest Deemix version

### Explanation:

| Parameter | Function |
| :----: | --- |
| `-v /your/storage/path/:/downloads` | Path for your music downloads |
| `-v /your/config/location:/config` | Path to your local configuration |
| `-e PUID=1000` | OPTIONAL: User ID of the user you want the container to run as in order to fix folder permission issues |
| `-e PGID=1000` | OPTIONAL: Group ID, see PUID |
| `-e UMASK_SET=022` | OPTIONAL: Setting UMASK for file permissions Default is 022 |
| `-p 6595:6595` | Port opened for the web interface |
| `-e INTPORT=3333` | EXTRA OPTIONAL: This changes the internal port of deemix. DON'T CHANGE THIS IF YOU DONT KNOW WHY YOU WOULD DO IT |
| `registry.gitlab.com/bockiii/deemix-docker` | This container |

To access the web interface, go to http://YOURSERVERIP:6595 

## Tags

`latest`                : Latest state of the main branch.

Tag includes `amd64`, `arm32v7` and `arm64v8` architectures.

## Changelog

See CHANGELOG.md

## Disclaimer and Links

I am in no way affiliated with the Deemix project (or any other Deezloader-like project for that matter).

Gitlab link for this container: https://gitlab.com/Bockiii/deemix-docker

Issue Tracker for this Docker: https://gitlab.com/Bockiii/deemix-docker/-/issues

Feel free to open an issue that is Docker related, and not related to Deemix development. Go to the Deemix repository for that.
