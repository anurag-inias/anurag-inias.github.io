# Ubuntu Setup

## Fix suspend

First disable NVIDIA systemd services:

```
sudo systemctl stop nvidia-suspend.service
sudo systemctl stop nvidia-hibernate.service
sudo systemctl stop nvidia-resume.service

sudo systemctl disable nvidia-suspend.service
sudo systemctl disable nvidia-hibernate.service
sudo systemctl disable nvidia-resume.service
```

and comment out content of `/lib/systemd/system-sleep/nvidia` file.

## Share samba directory

```
[public]
path = /home/nimbus/external
public = yes
writeable = yes
browseable = yes
create mask = 0777
directory mask = 0777
guest ok = yes
force user = nimbus
```

## Transmission web server

First install transmission:

```
sudo apt install transmission-daemon
```

Next update configurations to run it as user in this file:

```
/etc/init.d/transmission-daemon

```

Also update it here:

```
sudo systemctl edit transmission-daemon.service
```

After this transmission will create a configuration file at `.config/transmission-daemon/settings.json`. Update the following here:

- `rpc-host-whitelist` add alll the alias of your host here.
- `rpc-authentication-require` add a username and password here.