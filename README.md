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
				-e DEEMIX_SINGLE_USER=true \
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
			- DEEMIX_SINGLE_USER=true
		ports:
			- 6595:6595
```

### Updating Deemix

Pull the latest container for the latest Deemix version

### Parameters:

| Parameter | Function |
| :----: | --- |
| `-v /your/storage/path/:/downloads` | Path for your music downloads |
| `-v /your/config/location:/config` | Path to your local configuration |
| `-e PUID=1000` | OPTIONAL: User ID of the user you want the container to run as in order to fix folder permission issues |
| `-e PGID=1000` | OPTIONAL: Group ID, see PUID |
| `-e UMASK_SET=022` | OPTIONAL: Setting UMASK for file permissions Default is 022 |
| `-e DEEMIX_SINGLE_USER=true` | OPTIONAL: Similar to the ARL functionality in previous iterations. See below for details |
| `-p 6595:6595` | Port opened for the web interface |
| `-e INTPORT=3333` | EXTRA OPTIONAL: This changes the internal port of deemix. DON'T CHANGE THIS IF YOU DONT KNOW WHY YOU WOULD DO IT |
| `registry.gitlab.com/bockiii/deemix-docker` | This container |

To access the web interface, go to http://YOURSERVERIP:6595 

### DEEMIX_SINGLE_USER:

Setting this environment variable to true will enable a serverwide login. In this mode, only one user needs to log in and every session will use the same login. You do not need to provide an ARL to the container, deemix will store the login information in the config folder.

I also added a functionality that will enable Single_User mode when any ARL is configured at all. This will help legacy installations that still use old configuration parameters. As long as the ARL is set to anything, the mode is enabled. The provided ARL will NOT be processed, so you will need to login once using the web interface.

## Tags

`latest`                : Latest state of the main branch.

Tag includes `amd64`, `arm32v7` and `arm64v8` architectures.

## Changelog

See CHANGELOG.md

## Disclaimer and Links

I am in no way affiliated with the Deemix project (or any other Deezloader-like project for that matter).

Gitlab link for this container: https://gitlab.com/Bockiii/deemix-docker

Issue Tracker for this Docker: https://gitlab.com/Bockiii/deemix-docker/-/issues

You can donate/buy me a coffe on Ko-Fi: https://ko-fi.com/bocki

Feel free to open an issue that is Docker related, and not related to Deemix development. Go to the Deemix repository for that.
