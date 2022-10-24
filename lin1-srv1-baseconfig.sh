##################################
# Config complete serveur 1 linux
##################################
#Set hostname
hostnamectl set-hostname SRV-LIN1-01

#######################################
#Edit hosts file
host_FILE="/etc/hosts"
cat <<EOM >$host_FILE

127.0.0.1       localhost
127.0.1.1       SRV-LIN1-01
127.0.1.1       SRV-LIN1-01.lin1.local

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

EOM

#######################################
#Set interface
interfaces_FILE="/etc/network/interfaces"
cat <<EOM >$interfaces_FILE

auto ens33
iface ens33 inet static
address 10.10.10.11
netmask 255.255.255.0
gateway 10.10.10.2

EOM

#######################################
#Set resolv
resolv_FILE="/etc/resolv.conf"
cat <<EOM >$resolv_FILE

domain lin1.local
search lin1.local
nameserver 10.10.10.11
nameserver 10.10.10.2

EOM

#######################################
# config dnsmasq
apt-get install dnsmasq

dnsmasq_FILE="/etc/dnsmasq.conf"
cat <<EOM >$dnsmasq_FILE

addn-hosts=/etc/dnsmasq-hosts.conf
dhcp-option=option:router,10.10.10.2
dhcp-option=option:dns-server,10.10.10.11
dhcp-option=option:domain-name,lin1.local

EOM

#######################################
# config SSH

mkdir .ssh
touch /.ssh/authorized_keys

key_FILE="/.ssh/authorized_keys"
cat <<EOM >$key_FILE

ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBJ8PjC1k6uYW/lI230p1U5P/lsC2KFqzNjIHw88M2ssFWLfaYCFElP44YvtNep8pm+CmGYUAuvgP/9NWYjtSW2Y= ecdsa-key-20221024

EOM

sshconf_FILE="/etc/ssh/sshd_config"
cat <<EOM >$sshconf_FILE

PasswordAuthentication yes
PermitEmptyPasswords no

EOM
