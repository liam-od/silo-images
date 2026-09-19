#!/bin/sh
set -eu

# This must be the final command run inside the builder before it is stopped.
old_hostname="$(cat /etc/hostname)"

# Do not allow sshd to recreate host keys before shutdown.
systemctl stop ssh.socket ssh.service 2>/dev/null || true

# Remove credentials and per-instance SSH identity.
rm -rf /home/agent/.ssh
rm -f /etc/ssh/ssh_host_*

# Remove build caches, temporary files, and shell histories.
apt-get clean
rm -rf /var/lib/apt/lists/*
rm -rf /root/.ansible /root/.cache
rm -rf /home/agent/.ansible /home/agent/.cache /home/agent/.npm
rm -f /root/.bash_history
rm -f /home/agent/.bash_history /home/agent/.zsh_history
rm -f /tmp/install-mise

# Remove the builder hostname. Per-instance cloud-init supplies the real one.
hosts_tmp="$(mktemp)"
awk -v hostname="$old_hostname" '
    {
        keep = 1
        for (field = 2; field <= NF; field++) {
            if ($field == hostname) {
                keep = 0
            }
        }
        if (keep) {
            print
        }
    }
' /etc/hosts > "$hosts_tmp"
cat "$hosts_tmp" > /etc/hosts
rm -f "$hosts_tmp"
printf 'localhost\n' > /etc/hostname

# Remove boot-specific state and logs.
rm -f /var/lib/systemd/random-seed
journalctl --rotate >/dev/null 2>&1 || true
journalctl --vacuum-time=1s >/dev/null 2>&1 || true

# Reset cloud-init and machine identity for the child instance's first boot.
cloud-init clean --logs --machine-id --seed
