---
title: "Mount exFAT external drive on boot"
date: 2021-10-06T13:44:24+05:30
---

1. Find device `UUID`.
```bash
$ blkid
> /dev/sda1: LABEL="External 2T" UUID="40A1-F12E" TYPE="exfat" ....
```

2. Add an entry in `/etc/fstab` for mounting this device on boot.

```bash
UUID=40A1-F12E /mnt ext4 defaults 0 0
```

3. Finally confirm it that the changes are valid.
```bash
$ sudo mount -a
```
