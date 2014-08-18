#!/bin/bash
wget http -O FWnew http://rules.emergingthreats.net/fwrules/FWrev
if cmp -s "FWcurrent" "FWnew"
then
    echo "same revision number"
    rm FWnew
else
    mv FWnew FWcurrent
    wget -O fw.txt http://rules.emergingthreats.net/fwrules/emerging-PIX-CC.rules
    wget http://mirror1.malwaredomains.com/files/domains.txt
 
    cat fw.txt | cut -d" " -f6 > ips.txt
    tail -n +44 ips.txt > cc.txt
    rm ips.txt
    rm fw.txt
 
    cat domains.txt | grep fastflux | cut -d$'\t' -f3 > fastflux.txt
 
    /usr/bin/expect -c '
    set list [open cc.txt r]
    set filedata [read $list]
    close $list
    set iplist [open ip.txt r]
    set ipadd [read $iplist]
    close $iplist
    set fflist [open fastflux.txt r]
    set dlist [read $fflist]
    close $fflist
    set username username
    set password password
    foreach add $ipadd {
    spawn ssh $username@$add
    expect -re ".*(yes/no)" {
            send "yes\r"
            exp_continue
    }
    expect -re ".*password:"
    send -- "$password\r"
    expect -re ".*>"
    send "enable\r"
    expect -re ".*Password:"
    send -- "$password\r"
    expect -re ".*#"
    send "config t\r"
    expect -re ".* (config)#"
    send "no dynamic-filter blacklist\r"
    expect -re ".* (config)#"
    send "dynamic-filter enable\r"
    send "dynamic-filter drop blacklist interface outside\r"
    send "dynamic-filter blacklist\r"
    expect -re ".* (config-llist)#"
    foreach line $filedata {
    send "address $line 255.255.255.255\r"
    expect -re ".*#"
    }
    foreach line $dlist {
    send "name $line\r"
    expect -re ".*#"
    }
    send "exit\r"
    expect ".* (config)#"
    send "exit\r"
    expect ".*#"
    send "write mem\r"
    expect ".*#"
    send "exit\r"
    send "exit\r"
    }
    '
    rm cc.txt
    rm domains.txt
    rm fastflux.txt
fi
