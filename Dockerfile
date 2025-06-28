FROM lscr.io/linuxserver/wireguard:latest

COPY ./changes/postup /defaults/postup
COPY ./changes/server.conf /defaults/server.conf
COPY ./changes/wg_init_run /etc/s6-overlay/s6-rc.d/init-wireguard-confs/run
# COPY ./changes /changes

# Make sure the run script is executable
RUN chmod +x /etc/s6-overlay/s6-rc.d/init-wireguard-confs/run