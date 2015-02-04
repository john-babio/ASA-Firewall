
#mpf-block-dns-query: 
mpf cli to add a domain or domains to block using your asa firewall

#asa-expect-botnet-filter.sh: 
<p>Bash script that will ssh into your asa firewalls and add the list of command and control botnet ip addresses from emerging threats feed to the ASA botnet filter.
<p>You must supply a text file with the IP addresses of your asa firewalls called ip.txt. Place this file into the same folder as the script.The script also pulls down the current revision number and compares it to the most recent one you downloaded.
For everything to work properly run the following cli to lay the ground work. ASA must be 8.2 or higher.</p>
<br>dns domain-lookup outside
<br>dns server-group DefaultDNS
  <br>name-server 8.8.4.4
  <br>domain-name yourdomain.com
  <br>access-list dynamic-filter_acl extended permit ip any any
<br>dynamic-filter enable interface outside classify-list dynamic-filter_acl
<br>class-map dynamic-filter_snoop_class
<br> match port udp eq domain
 <br>policy-map dynamic-filter_snoop_policy
  <br>class dynamic-filter_snoop_class
  <br>inspect dns dynamic-filter-snoop
<br>service-policy dynamic-filter_snoop_policy interface outside

#tor-acl-maker.ps1:  
Powershell script that pulls a list of all current tor nodes and creates an Cisco ASA object-group along with ingress and egress access control lists.

#tor-acl-maker.sh:
Bash script that pulls a list of all current tor nodes and creates an Cisco ASA object-group along with ingress and egress access control lists.
