#!/bin/bash

: ${SSH_USERNAME:=user}
: ${SSH_USERPASS:=$(dd if=/dev/urandom bs=1 count=15 | base64)}

__create_rundir() {
   mkdir -p /var/run/sshd
}

__create_user() {
   useradd $SSH_USERNAME
   echo -e "$SSH_USERPASS\n$SSH_USERPASS" | (passwd --stdin $SSH_USERNAME)
   echo ssh user password: $SSH_USERPASS
   echo 'user ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoer
}

__create_hostkeys() {
   ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 
}

# Call all functions
__create_rundir
__create_hostkeys
__create_user

exec "$@"
