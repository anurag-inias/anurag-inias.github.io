# Samba

<style>
.md-logo img {
  content: url('/ubuntu/ubuntu.svg');
}

</style>

## Share samba directory

```
[public]
path = /home/johndoe/external
public = yes
writeable = yes
browseable = yes
create mask = 0777
directory mask = 0777
guest ok = yes
force user = johndoe
```
