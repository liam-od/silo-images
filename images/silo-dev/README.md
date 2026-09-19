# silo-dev

Minimal Ubuntu development image for Silo.

## Baseline packages

[`packages.txt`](packages.txt) contains only the initial baseline:

- OpenSSH server
- CA certificates
- curl
- Git

Development tools are added only after the base image is built.

## Provisioning policy

Ansible provisions the builder through the Incus guest agent using the `community.general.incus` connection plugin. Provisioning does not require SSH or copy personal credentials into the guest.

The image retains Ubuntu's package-provided OpenSSH configuration. Per-instance cloud-init disables SSH password authentication and supplies the instance user and public key.
