# Sidedoor

Sidedoor - https://github.com/daradib/sidedoor

Your box is your personal box, with your private key.
Don't share your private key.

The target machine:
- not a personal box.
- disposable.
- easily compromised
- its private key isn’t very private.
- The target box will ssh into a public server, account has limited privs.
- Now you can log in from your personal box to the target via the server.
- You can safely deploy your public key to the target.

The server machine:
https://github.com/daradib/sidedoor?tab=readme-ov-file#recommendations

NB: the remote server is not ansible managed.
You will need securly do the following:

1. Generate a set of keys for the target box:
ssh-keygen -t rsa -N '' -f /tmp/id_rsa

1. deploy the public key to the remote server:
`ssh-copy-id -i /tmp/id_rsa user@example.com` (the user@host in .yml)

1. Vault the private key:
```
cd inventory/group_vars/all
printf '%s\n' --- 'sd_ssh_private_key: |' > sd_ssh_private_key.yml
cat /tmp/id_rsa >> sd_ssh_private_key.yml
vim sd_ssh_private_key.yml # and indent it >:
ansible-vault encrypt --vault-password-file=~/.ansible-vault sd_ssh_private_key.yml
```

1. Get the remote server's host key and store in inventory:
```
printf "sd_remote_key: ">> sidedoor.yml
ssh-keyscan -t ecdsa -H example.com >> sidedoor.yml
vim sidedoor.yml # quote it
```
btw: this key should also be in tail -1 .ssh/known_hosts, from the copy-id

1. clean up
`rm /tmp/id_rsa.*`

1. allow connetions from outside. no jump box account needed.
```
/etc/ssh/sshd.conf
GatewayPorts clientspecified
```
"By default, OpenSSH only allows connecting to remote forwarded ports from the server host"
https://www.ssh.com/academy/ssh/tunneling-example#remote-forwarding



## Tasks

* `tasks/sidedoor.yml`: Manages SSH tunnel

## Available variables

Sidedoor variables are:

* `sd_remote_user`:         User on avlaible ssh server.

* `sd_remote_server`:       Publicly avlaible ssh server.

* `sd_remote_key`:          SSH host key of the server. (for known_hosts)

* `sd_ssh_private_key`:     SSH private key to connect to the server. (saved to id-rsa)

* `sd_port`:                Port on remote server to forward to local 22
                            Thus each box needs a uniquie port.

* `sd_more_options`:        Additional options to pass ssh

Other variables used are:

* `skip_unit_test`:  Used internally by the test suite to disable actions that
                     can't be performed in the gitlab-ci test runner.
