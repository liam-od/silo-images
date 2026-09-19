# silo-dev

Minimal Ubuntu development image for Silo.

## Creating the image

 ```bash
   incus init images:<pinned-fingerprint> <name> \
     --vm \
     -c limits.cpu=4 \
     -c limits.memory=4GiB \
     -d root,size=20GiB
 ```

 I'm using `ubuntu/26.04/cloud` for the resolute cloud image,
 but check out the [image server](https://images.linuxcontainers.org/).

Then to run the ansible playbook: `./run`
