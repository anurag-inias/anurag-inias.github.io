# NFS setup

=== "Server"

    ```bash
    # Install NFS
    $ sudo apt install nfs-kernel-server

    # Edit config
    $ sudo nano /etc/exports
    ```

    In the config file

    ```
    /home/johndoe 192.168.1.0/24(rw,sync,no_subtree_check,insecure,all_squash,anonuid=1000,anongid=1000)
    ```

    Restart NFS

    ```
    sudo exportfs -a
    sudo systemctl restart nfs-kernel-server
    ```

=== "Client"

    In MacOS Finder, enter `cmd+k` add

    ```
    nfs://192.168.1.4/home/johndoe
    ```
