Invoke-WebRequest https://www.dan.me.uk/torlist -OutFile torlist.txt
"object-group network Tor-Nodes" | Out-File tor-asa.cfg -Append
foreach ( $tornode in get-content torlist.txt ) { 
    "object-group host $tornode" | Out-File tor-asa.cfg -Append 
}
"access-list deny-tor-ingress extended deny ip object-group Tor-Nodes any" | Out-File tor-asa.cfg -Append
"access-list deny-tor-egress extended deny ip any object-group Tor-Nodes" | Out-File tor-asa.cfg -Append
rm torlist.txt
