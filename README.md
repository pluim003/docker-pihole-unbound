# Pi-Hole + Unbound in one Container

## Description

This Docker deployment runs both Pi-Hole and Unbound in a single container.

The base image for the container is the [official Pi-Hole container](https://hub.docker.com/r/pihole/pihole), with an extra build step added to install the Unbound resolver directly into to the container not using [instructions provided directly by the Pi-Hole team](https://docs.pi-hole.net/guides/unbound/) but by installing the latest available version of Unbound. It seems that using a package manager you will get an Unbound-version which is over 1 year old and might contain security-issues which have been solved in more recent versions.

Note: October 6th 2024. Adding more recent version of unbound through apt doesn't work anymore on newer releases. The latest docker-image with tag 2024.07.0 contains the latest pihole-container 2024.07.0 with Unbouond v1.17.1. I'm currently trying to install a more recent version from unbound in a different way, but so far, can't get this container running the way I want. The nightly releases contain this method. You can get it working with logging in manually in the container and starting unbound. The nightly builds are also based on the latest pihole-container 2024.07.0 as a lot of things won't work anymore when using the nightly.

## Usage

First create a `.env` file to substitute variables for your deployment.

### Pi-hole environment variables

> Vars and descriptions replicated from the [official pihole container](https://github.com/pi-hole/docker-pi-hole/#environment-variables):

### Recommended variables

| Variable | Default | Value | Description |
| -------- | ------- | ----- | ---------- |
| `TZ` | UTC | `<Timezone>` | Set your [timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) to make sure logs rotate at local midnight instead of at UTC midnight.
| `WEBPASSWORD` | random | `<Admin password>` | http://pi.hole/admin password. Run `docker logs pihole \| grep random` to find your random pass.
| `FTLCONF_LOCAL_IPV4` | unset | `<Host's IP>` | Set to your server's LAN IP, used by web block modes and lighttpd bind address.

### Optional variables

| Variable | Default | Value | Description |
| -------- | ------- | ----- | ---------- |
| `DNSSEC` | 	false  |	`<"true"\|"false">` | Enable DNSSEC support
| `REV_SERVER` | `false` | `<"true"\|"false">` | Enable DNS conditional forwarding for device name resolution |
| `REV_SERVER_DOMAIN` | unset | Network Domain | If conditional forwarding is enabled, set the domain of the local network router |
| `REV_SERVER_TARGET` | unset | Router's IP | If conditional forwarding is enabled, set the IP of the local network router |
| `REV_SERVER_CIDR` | unset | Reverse DNS | If conditional forwarding is enabled, set the reverse DNS zone (e.g. `192.168.0.0/24`) |
| `WEBTHEME` | `default-light` | `<"default-dark"\|"default-darker"\|"default-light"\|"default-auto"\|"lcars">`| User interface theme to use.

### Advanced variables

| Variable | Default | Value | Description |
| -------- | ------- | ----- | ---------- |
| `WEB_PORT` | unset | `<PORT>`| **This will break the 'webpage blocked' functionality of Pi-hole** however it may help advanced setups like those running synology or `--net=host` docker argument.  This guide explains how to restore webpage blocked functionality using a linux router DNAT rule: [Alternative Synology installation method](https://discourse.pi-hole.net/t/alternative-synology-installation-method/5454?u=diginc)

Example `.env` file in the same directory as your `docker-compose.yaml` file:

```
TZ=Europe/Amsterdam
WEBPASSWORD=QWERTY123456asdfASDF
WEB_PORT=8100
FTLCONF_LOCAL_IPV4=192.168.1.35
REV_SERVER=true
REV_SERVER_DOMAIN=local
REV_SERVER_TARGET=192.168.1.1
REV_SERVER_CIDR=192.168.0.0/16
HOSTNAME=pihole
DOMAIN_NAME=pihole.local
WEBTHEME=default-light
DNSSEC=true
```

### Using Portainer stacks? 

When using Portainer to deploy the stack might fail if you have a mapping to /etc/resolv.conf in your docker-compose.yaml-file. Removing the mapping will succeed, but you will end up with the default resolv.conf.

### Running the stack

```bash
docker-compose up -d
```

> If using Portainer, just paste the `docker-compose.yaml` contents into the stack config and add your *environment variables* directly in the UI.
