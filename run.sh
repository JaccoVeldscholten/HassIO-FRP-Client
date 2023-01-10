#!/usr/bin/with-contenv bashio

declare serverip
declare serverport


SERVER_IP=$(bashio::config 'serverip')
SERVER_PORT=$(bashio::config 'serverport')

echo  "Server: ${SERVER_IP}"
echo  "Port:   ${SERVER_PORT}"


# Check if /usr/src/frpc.ini exist. If not create with template

if [ ! -f /usr/src/frpc.ini ]; then
    echo "Creating frpc.ini"
    echo "[common]" > /usr/src/frpc.ini
    echo "server_addr = ${SERVER_IP}" >> /usr/src/frpc.ini
    echo "server_port = ${SERVER_PORT}" >> /usr/src/frpc.ini

    echo "Adding HA"
    echo "[hass]" >> /usr/src/frpc.ini
    echo "type = tcp" >> /usr/src/frpc.ini
    echo "local_ip = 127.0.0.1 " >> /usr/src/frpc.ini
    echo "local_port = 8123" >> /usr/src/frpc.ini
    echo "remote_port = 8123" >> /usr/src/frpc.ini

    echo "Creating frpc.ini done"
fi


# Start FRPC with command: ./frpc -c frpc.ini
echo "Starting FRP client..."

exec ls /usr/src
exec cat /usr/src/frpc.ini
exec ./usr/src/frpc -c frpc.ini

