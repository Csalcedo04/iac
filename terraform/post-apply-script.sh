#! /bin/sh

machine_name=$1
public_ip=$2
username=$3
ansible_hosts_file="../ansible/hosts"
host=$(echo $machine_name 'ansible_host='$public_ip 'ansible_user='$username 'ansible_connection=ssh ansible_ssh_private_key_file=..\/private_key.ssh')

# Saltar el chequeo del host en SSH
ssh-keyscan -H $public_ip > ~/.ssh/known_hosts
sed -i "2s/.*/$host/g" $ansible_hosts_file

ANSIBLE_CONFIG=../ansible/ansible.cfg ansible-playbook ../ansible/run.yml
