#!/usr/bin/expect

set timeout 20

set ip [lindex $argv 0]

set user [lindex $argv 1]

set password [lindex $argv 2]

set nom [lindex $argv 3]

set gw [lindex $argv 4]

set dns1 [lindex $argv 5]

set dns2 [lindex $argv 6]

spawn ssh -o "StrictHostKeyChecking no" "$user\@$ip"
expect "password:"

send "$password\r";
expect "#"

send "config\r"
expect "#"

send "hostname $nom\r"
expect "#"

send "ntp server pool.ntp.org minpoll 4 maxpoll 4 iburst\r"
expect "#"

send "ntp enable\r"
expect "#"

send "spanning-tree\r"
expect "#"

send "ip route 0.0.0.0/0 $gw\r"
expect "#"

send "ip dns server-address $dns1\r"
expect "#"

send "ip dns server-address $dns2\r"
expect "#"

send "interface vlan 1\r"
expect "#"

send "no ip dhcp\r"
expect "#"

send "vlan 2\r"
expect "#"

send "description Isis\r"
expect "#"

send "no shutdown\r"
expect "#"

send "vlan 10\r"
expect "#"

send "description Video\r"
expect "#"

send "no shutdown\r"
expect "#"

send "vlan 11\r"
expect "#"

send "description Intrusion\r"
expect "#"

send "no shutdown\r"
expect "#"

send "vlan 200\r"
expect "#"

send "description Wifi_Prive\r"
expect "#"

send "no shutdown\r"
expect "#"

send "vlan 300\r"
expect "#"

send "description Wifi_Public\r"
expect "#"

send "no shutdown\r"
expect "#"

send "vlan 253\r"
expect "#"

send "description Vlan0253\r"
expect "#"

send "no shutdown\r"
expect "#"

send "vlan 255\r"
expect "#"

send "description Vlan0255\r"
expect "#"

send "no shutdown\r"
expect "#"

send "interface 1/1/2-1/1/52\r"
expect "#"

send "vlan trunk native 1\r"
expect "#"

send "vlan trunk allowed 1,2,10,11\r"
expect "#"

send "no shutdown\r"
expect "#"

send "exit\r"
expect "#"

send "wr memory \r"
expect "#"

send "exit\r"
expect "#"

send "exit\r"

interact
#expect eof
