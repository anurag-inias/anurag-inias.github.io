# Static IP

<style>
.md-logo img {
  content: url('/ubuntu/ubuntu.svg');
}
</style>

## Background

Setting up ubuntu server on a raspberry pi 4b with Raspberry Pi Imager. However, allocating it a static ip instead of using dhcp is not possible with the dumb router I got this time.

## Steps

Update `/etc/netplan/50-cloud-init.yaml`

```yaml
# This file is generated from information provided by the datasource.  Changes
# to it will not persist across an instance reboot.  To disable cloud-init's
# network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
  version: 2
  wifis:
    renderer: networkd
    wlan0:
      access-points:
        MyHomeWifiSSID:
          password: 714d319bc30d29b40d78fe4df17600c9c226624348db3894ef0b0a4009d7dc8f
      dhcp4: no
      addresses:
        - 192.168.1.23/24
      routes:
        - to: default
          via: 192.168.1.1
      optional: true
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
```

The hashed wifi password is generated with:

```bash
$ anurag@mediaserver:~$ wpa_passphrase MyHomeWifiSSID MyHomeWifiPassword
  network={
	  ssid="MyHomeWifiSSID"
	  #psk="MyHomeWifiPassword"
	  psk=714d319bc30d29b40d78fe4df17600c9c226624348db3894ef0b0a4009d7dc8f
  }
```

Also create `/etc/cloud/cloud.cfg.d/99-disable-network-config.cfg` as instructed in the comments at the top of the file with the content:

```json
network: {config: disabled}
```

## Applying Changes

Try and apply the changes with

```bash
$ sudo netplan try
$ sudo netplan apply
```

And as a last sanity check, before restarting the server, change the static IP address to something else, say `192.168.1.37`. This is because the router may give you the same IP address just through the still-valid prior lease.

If after restart I still get `192.168.1.23`, that tells me that things didn't work out.
