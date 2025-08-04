# WireGuard with Port Forwarding to Clients

This project is based on [linuxserver/wireguard](https://github.com/linuxserver/docker-wireguard) and adds custom functionality to forward specific ports from the WireGuard host directly to connected WireGuard clients.

## What is added

- **Dynamic Port Rule Generation**  
  Accepts a `PORTS` environment variable like `80/tcp,443/tcp,3000/udp`, and generates matching `PostUp` and `PostDown` rules dynamically at runtime.

- **Custom Port Forwarding Support**  
  Automatically sets up `iptables` rules to forward specified TCP/UDP ports to a chosen WireGuard peer (`interface.2`).
## Usage

Use this as a Docker image in your `docker-compose.yml` or manually via `docker build`:

```yaml
---
services:
  wireguard:
    build: .
    container_name: wireguard
    cap_add:
      - NET_ADMIN
      - SYS_MODULE #optional
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
      - SERVERURL=wireguard.domain.com #optional
      - SERVERPORT=51820 #optional
      - PEERS=1 #optional
      - PEERDNS=auto #optional
      - INTERNAL_SUBNET=10.13.13.0 #optional
      - ALLOWEDIPS=0.0.0.0/0 #optional
      - PERSISTENTKEEPALIVE_PEERS= #optional
      - LOG_CONFS=true #optional
      - PORTS=80/tcp,443/tcp,25565/udp #optional, ports you want to forward
    volumes:
      - /path/to/wireguard/config:/config
      - /lib/modules:/lib/modules #optional
    ports:
      - 51820:51820/udp
      # also remember to expose the ports here
      - 80:80/tcp
      - 443:443/tcp
      - 25565:25565/udp
    sysctls:
      - net.ipv4.conf.all.src_valid_mark=1
    restart: unless-stopped
```





## License

This project is licensed under the [GNU General Public License v3.0](./LICENSE).

It is a derivative of [linuxserver/wireguard](https://github.com/linuxserver/docker-wireguard), which is also licensed under GPLv3.
