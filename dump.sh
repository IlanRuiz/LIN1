#######################################
# config dnsmasq

dnsmasq_FILE="/etc/dnsmasq.conf"
cat <<EOM >$dnsmasq_FILE

addn-hosts=/etc/dnsmasq-hosts.conf
dhcp-option=option:router,10.10.10.2
dhcp-option=option:dns-server,10.10.10.11
dhcp-option=option:domain-name,lin1.local

EOM
