#!/bin/bash
wget http://www.dan.me.uk/torlist
echo "object-group network Tor-Nodes"
for file in $(cat torlist)
do
        echo "network-object host $file"
done
echo "!"
echo "access-list deny-tor-ingress extended deny ip object-group Tor-Nodes any"
echo "access-list deny-tor-egress extended deny ip any object-group Tor-Nodes"
rm torlist

