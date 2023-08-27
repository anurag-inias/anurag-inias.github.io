---
tags:
  - guides
  - ntfs
---

# NTFS

## 1. List partition table

```shell
$ sudo fdisk -l
...
Disk /dev/sda: 29.25 GiB, 31406948352 bytes, 61341696 sectors
Disk model: Cruzer Blade    
...

Device     Boot Start      End  Sectors  Size Id Type
/dev/sda1        2048 61341695 61339648 29.2G  7 HPFS/NTFS/exFAT
```

## 2. Fix NTFS not writable

```shell
$ sudo ntfsfix /dev/sda1 # from previous command
Mounting volume... OK
Processing of $MFT and $MFTMirr completed successfully.
Checking the alternate boot sector... OK
NTFS volume version is 3.1.
NTFS partition /dev/sda3 was processed successfully.
```