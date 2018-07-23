#!/bin/sh

echo server=`getent hosts dnsquad9 | cut -d" " -f 1`#8053 >> /etc/dnsmasq.conf 
# echo "before trying to run dnsmasq" >> /var/log/dnsmasq/testing
dnsmasq -k --log-facility=${LOGFILE}
# echo "after trying to run dnsmasq" >> /var/log/dnsmasq/testing