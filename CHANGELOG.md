# Changelog

## 2020-09-10
- added support for deezloader ui by environment variable "DEEZUI"

## 2020-09-08
- Switched the installer to the new server-requirements

## 2020-09-05
- Fixed the ARL updater

## 2020-07-24
- Updated code to pull from codeberg instead of notabug

## 2020-06-12
- Added UMASK_SET environment variable (I misunderstood how it worked.. now it should work)

## 2020-06-11
- First entry in the changelog. This is for the container only, not for deemix or any of it's components.
- Switched port to 6595 from 9666 (due to pyweb update). THIS SHOULD BE FIX NOW. I have hard-coded the port into the run parameter, so even if deemix itself will switch the port, you should always just have to map to 6595
- Switched the base from a pre-build alpine-python3 build (that was pretty old) to the current alpine base with my own python installation.