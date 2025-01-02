# Static IP

<style>
.md-logo img {
  content: url('/ubuntu/ubuntu.svg');
}

</style>

## About

Transmission web is a great way to grab movies/shows in background. A raspberry pi doesn't take too much power, so you can leave it running all way for weeks.

## Setup

First the installation:

```bash
$ sudo apt install transmission-daemon
```

Next we want to run it as our `$USER`, instead of the default user `debian-transmission`. So first stop the transmission daemon:

```bash
$ sudo systemctl stop transmission-daemon.service
```

## Daemon Configuration

Next edit its configuration:

```bash
$ sudo systemctl edit transmission-daemon.service
```

This will show you something like this:

```
### Editing /etc/systemd/system/transmission-daemon.service.d/override.conf
### Anything between here and the comment below will become the contents of the drop-in file

### Edits below this comment will be discarded

### /usr/lib/systemd/system/transmission-daemon.service
# [Unit]
# Description=Transmission BitTorrent Daemon
# Wants=network-online.target
# After=network-online.target
#
# [Service]
# User=debian-transmission
# Type=notify
# ExecStart=/usr/bin/transmission-daemon -f --log-level=error
# ExecReload=/bin/kill -s HUP $MAINPID
# NoNewPrivileges=true
# MemoryDenyWriteExecute=true
# ProtectSystem=true
# PrivateTmp=true
#
# [Install]
# WantedBy=multi-user.target
```

here we place the following lines, bare minimum require to override the service config:

```
[Service]
User=johndoe
Type=simple
```

i.e., change the username to your own `$USER` and change the type from `notify` to `simple`.

Next simply start back the daemon:

```bash
$ sudo systemctl start transmission-daemon.service
```

## Web UI configuration

You'll notice a new folder in `~/.config/transmission-daemon`. Edit the `settings.json`:

- Update `download-dir` if needed.
- Enable `incomplete-dir-enabled` and set `incomplete-dir`.
- Update `rpc-host-whitelist` to the static ip previously picked.
- Expand `rpc-whitelist` with `192.168.1.*` so only clients on your wifi network can access the web UI.
