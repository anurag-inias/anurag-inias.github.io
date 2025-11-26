# Samba

<style>
.md-logo img {
  content: url('/ubuntu/ubuntu.svg');
}

</style>

## Share samba directory

=== "global"

    ```conf
    [global]
    # Enable Apple extensions
    vfs objects = fruit streams_xattr

    # Apple optimizations
    fruit:metadata = stream
    fruit:model = MacSamba
    fruit:posix_rename = yes
    fruit:veto_appledouble = no
    fruit:nfs_aces = no
    fruit:wipe_intentionally_left_blank_rfork = yes
    fruit:delete_empty_adfiles = yes

    # Performance tweaks
    min protocol = SMB2
    ea support = yes
    ```

=== "public"

    ```conf
    [public]
    path = /home/johndoe/external
    public = yes
    writeable = yes
    browseable = yes
    create mask = 0777
    directory mask = 0777
    guest ok = yes
    force user = johndoe

    # ignore .DS_Store metadata writes
    veto files = /._*/.DS_Store/
    delete veto files = yes
    ```
