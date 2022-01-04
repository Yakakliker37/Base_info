#!/usr/bin/expect

set timeout 20

set ip [lindex $argv 0]

set user [lindex $argv 1]

set password [lindex $argv 2]

spawn ssh "$user\@$ip"
expect "password:"

send "$password\r";
expect "6100#"

send "config\r"
expect "6100(config)#"

send "ip dns server-address 8.8.8.8\r"
expect "6100(config)#"

send "ip dns server-address 8.8.4.4\r"
expect "6100(config)#"

send "vlan 2\r"
expect "6100(config-vlan-2)#"

send "description Isis\r"
expect "6100(config-vlan-2)#"

send "no shutdown\r"
expect "6100(config-vlan-2)#"

send "vlan 10\r"
expect "6100(config-vlan-10)#"

send "description Video\r"
expect "6100(config-vlan-10)#"

send "no shutdown\r"
expect "6100(config-vlan-10)#"

send "vlan 11\r"
expect "6100(config-vlan-11)#"

send "description Intrusion\r"
expect "6100(config-vlan-11)#"

send "no shutdown\r"
expect "6100(config-vlan-11)#"

send "vlan 200\r"
expect "6100(config-vlan-200)#"

send "description Wifi_Prive\r"
expect "6100(config-vlan-200)#"

send "no shutdown\r"
expect "6100(config-vlan-200)#"

send "vlan 300\r"
expect "6100(config-vlan-300)#"

send "description Wifi_Public\r"
expect "6100(config-vlan-300)#"

send "no shutdown\r"
expect "6100(config-vlan-300)#"

send "vlan 253\r"
expect "6100(config-vlan-253)#"

send "description Vlan0253\r"
expect "6100(config-vlan-253)#"

send "no shutdown\r"
expect "6100(config-vlan-253)#"

send "vlan 255\r"
expect "6100(config-vlan-255)#"

send "description Vlan0255\r"
expect "6100(config-vlan-255)#"

send "no shutdown\r"
expect "6100(config-vlan-255)#"

send "interface 1/1/2-1/1/52\r"
expect "6100(config-if-<1/1/2-1/1/52>)#"

send "vlan trunk native 1\r"
expect "6100(config-if-<1/1/2-1/1/52>)#"

send "vlan trunk allowed 1,2,10,11\r"
expect "6100(config-if-<1/1/2-1/1/52>)#"

send "no shutdown\r"
expect "6100(config-if-<1/1/2-1/1/52>)#"

send "exit\r"
expect "6100(config)#"

send "wr memory \r"
expect "6100(config)#"

send "exit\r"
expect "6100#"

send "exit\r"

interact
#expect eof
