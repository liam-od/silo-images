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

Then run the Ansible playbook:

```bash
./run
```

## Finalize and publish

Run finalization only after provisioning and validation are complete. It must be the final command executed inside the builder:

```bash
incus exec silo-image-builder-v1 -- sh -s < finalize.sh
incus stop silo-image-builder-v1 --timeout 60
incus publish silo-image-builder-v1 --alias silo-dev-v1
```

Do not run the playbook or another guest command between finalization and stopping the builder. Failed publication does not require rebuilding; the stopped builder is retained.
