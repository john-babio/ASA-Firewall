ASA-Firewall
============

<p>mpf-block-dns-query	: is just the mpf cli to add a domain or domains to block using your asa firewall</p>
<p>asa-expect-botnet-filter.sh is a script that will ssh into your asa firewalls and add the list of command and control botnet ip addresses from emerging threats feed to the ASA botnet filter.
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

