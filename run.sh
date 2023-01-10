#!/command/with-contenv bashio

declare ip
declare port

# Get config
CONFIG_PATH=/config/frpc.ini


# Start FRPC with command: ./frpc -c frpc.ini
echo "Starting FRP client..."

# Display from config 
echo $(bashio::config "ip | join(\",\")" "")

exec ls /usr/src
exec ./usr/src/frpc -c frpc.ini

