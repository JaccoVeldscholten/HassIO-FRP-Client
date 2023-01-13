<img src="https://github.com/JaccoVeldscholten/HassIO-FRP-Client/blob/main/logo.png" width=100 height=100 />

![Supports aarch64 Architecture][aarch64-shield] ![Supports amd64 Architecture][amd64-shield] ![Supports armhf Architecture][armhf-shield] ![Supports armv7 Architecture][armv7-shield] ![Supports i386 Architecture][i386-shield]

## Home Assistant OS FRP Client
[FRP](https://github.com/fatedier/frp) Client for Home Assistant OS can be used to set up a reverse proxy with an FRP server.

FRP can be used to bypass port forwarding for home assistant. Install a remote server (On a server where port forwarding is allowed). And then connect through the client to the server of FRP.

This tool is able to do the configuration of Home Assistant automatically. With options for authentication, encryption and compression.


## Installation

Install this repo under: 
Addons -> Add-on Store -> 3 dots in right -> Repositories -> Add this repo

(Optional) restart supervisor


### Server config (FRPS.ini)
For the server (On remote host) configure 
```ini
[common]
bind_port = 7000

#Optional for dashboard
dashboard_port = 7500
dashboard_user = user
dashboard_pwd = userpass

#Optional for auth (Should match with Client settings)
authentication_method = token
token = sometoken

#Optinal for metrics
enable_prometheus = true

```

Run the program with: frps -c frps.ini

### Client config (FRPC.ini)
After setting up the server go to the configuration tab of the addon and set the correct settings according to the server configuration.
Check the log of the addon after starting to make sure everthing went well.
## License

[MIT](https://choosealicense.com/licenses/mit/)



## Authors

- [@JaccoVeldscholten](https://github.com/JaccoVeldscholten)

Special thanks to: [@steplov](https://github.com/steplov) for the setup script



[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg

