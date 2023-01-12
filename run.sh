#!/usr/bin/with-contenv bashio

WAIT_PIDS=()

declare serverip
declare serverport
declare authtoken
declare encryption
declare compression

SERVER_IP=$(bashio::config 'serverip')
SERVER_PORT=$(bashio::config 'serverport')
AUTH_TOKEN=$(bashio::config 'token')
HA_PORT=$(bashio::config 'haport')
ENCRYPTION=$(bashio::config 'encryption')
COMPRESSION=$(bashio::config 'compression')

echo  "********* FRP SERVER CONFIG ********"
echo  "Using Server: ${SERVER_IP}"
echo  "Using Port:   ${SERVER_PORT}"
echo  "Using Token:  ${AUTH_TOKEN}"
echo  "******* HOME ASSISTANT CONFIG ******"
echo  "Using HA Port: ${HA_PORT}"
echo  "Using Encryption: ${ENCRYPTION}"
echo  "Using Compression: ${COMPRESSION}"
echo "*************************************"

# Check if /usr/src/frpc.ini exist. If not create with template

if [ ! -f /usr/src/frpc.ini ]; then
    echo "Creating frpc.ini"
    echo "[common]" > /usr/src/frpc.ini
    echo "server_addr = ${SERVER_IP}" >> /usr/src/frpc.ini
    echo "server_port = ${SERVER_PORT}" >> /usr/src/frpc.ini
    echo "authentication_method = token" >> /usr/src/frpc.ini
    echo "token = ${AUTH_TOKEN}" >> /usr/src/frpc.ini

    echo "Adding HA Exposure......."
    echo "" >> /usr/src/frpc.ini
    echo "[hass]" >> /usr/src/frpc.ini
    echo "type = tcp" >> /usr/src/frpc.ini

    # If encryption or/and compression is enabled. add them 
    if [ "${ENCRYPTION}" = "true" ]; then
        echo "use_encryption = true" >> /usr/src/frpc.ini
    fi
    if [ "${COMPRESSION}" = "true" ]; then
        echo "use_compression = true" >> /usr/src/frpc.ini
    fi

    echo "local_ip = 127.0.0.1 " >> /usr/src/frpc.ini
    echo "local_port = ${HA_PORT}" >> /usr/src/frpc.ini
    echo "remote_port = ${HA_PORT}" >> /usr/src/frpc.ini

    echo "Creating frpc.ini done \n"
fi


# Start FRPC with command: ./frpc -c frpc.ini
echo "Starting FRP client..."

#exec ls /usr/src
#exec cat /usr/src/frpc.ini
exec ./usr/src/frpc -c /usr/src/frpc.ini

trap "stop_frpc" SIGTERM SIGHUP

# Wait and hold Add-on running
wait "${WAIT_PIDS[@]}"