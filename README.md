ASA-Firewall
============

mpf-block-dns-query	: is just the mpf cli to add a domain or domains to block using your asa firewall

asa-expect-botnet-filter.sh is a script that will ssh into your asa firewalls and add the list of command and control botnet ip addresses from emerging threats feed to the ASA botner filter.

You must supply a text file with the IP addresses of your asa firewalls called ip.txt. Place this file into the same folder as the script. The script also pulls down the current revision number and compares it to the most recent one you downloaded.

For everything to work properly run the following cli to lay the ground work. ASA must be 8.2 or higher.

dns domain-lookup outside
dns server-group DefaultDNS
    name-server 8.8.4.4
    domain-name yourdomain.com
 
 
access-list dynamic-filter_acl extended permit ip any any
dynamic-filter enable interface outside classify-list dynamic-filter_acl
class-map dynamic-filter_snoop_class
 match port udp eq domain
 
policy-map dynamic-filter_snoop_policy
 class dynamic-filter_snoop_class
 inspect dns dynamic-filter-snoop
service-policy dynamic-filter_snoop_policy interface outside

