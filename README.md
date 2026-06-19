# Lucky for OPNsense

OPNsense package for [Lucky](https://github.com/gdy666/lucky), providing:

- OPNsense menu entry under **Services > Lucky**
- ACL and configd action registration
- rc.d service control through `/usr/local/etc/rc.d/os-lucky`
- WebGUI status, link, start/stop/restart, config directory and port settings
- Bundled upstream FreeBSD amd64 Lucky binary

## Build on OPNsense

```sh
cd "OPNsense/lucky for OPNsense"
ABI=native ./build.sh
```

## Install

```sh
pkg add -f dist/os-lucky.pkg
```

Refresh the OPNsense WebGUI and open **Services > Lucky**. Lucky listens on port `16601` by default.
