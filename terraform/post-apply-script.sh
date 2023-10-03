#! /bin/sh

ansible_hosts_file="../ansible/hosts"
vars_file="../ansible/vars/main.yml"

# wireguard
machine_name=$1
public_ip=$2
username=$3
private_key_file=$4
compose_env_file="../ansible/roles/wireguard/files/compose/wireguard/.env"
compose_file="../ansible/roles/wireguard/files/compose/wireguard/docker-compose.yml"

host=$(sed 's/[\/&]/\\&/g' <<< $(echo $machine_name 'ansible_host='$public_ip 'ansible_user='$username 'ansible_connection=ssh ansible_ssh_private_key_file='$4))
vol_dir=$(sed 's/[\/&]/\\&/g' <<< $(echo VOL_DIR=/home/$username/volumes))
username_var=$(echo "username:" $username)
server_url=$(sed 's/[\/&]/\\&/g' <<< $(echo "      - SERVERURL=$public_ip"))

# Saltar el chequeo del host en SSH
#ssh-keyscan -H $public_ip > ~/.ssh/known_hosts

# General
sed -i "1s/.*/$username_var/g" $vars_file

# Wireguard
sed -i "2s/.*/$host/g" $ansible_hosts_file
sed -i "1s/.*/$vol_dir/g" $compose_env_file 
# sed -i "12s/.*/$server_url/g" $compose_file
sed -i "12s/.*/     - SERVERURL=$public_ip/g" $compose_file


#ANSIBLE_CONFIG=../ansible/ansible.cfg ansible-playbook ../ansible/run.yml
