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

send "vlan 2\r"

expect "6100(config-vlan-2)#"

send "description Isis\r"

expect "6100(config-vlan-2)#"

send "vlan 10\r"

expect "6100(config-vlan-10)#"

send "description Video\r"

expect "6100(config-vlan-10)#"

send "vlan 11\r"

expect "6100(config-vlan-11)#"

send "description Intrusion\r"

expect "6100(config-vlan-11)#"

send "exit\r"

expect "6100(config)#"

send "exit\r"

expect "6100#"

send "exit\r"

interact
#expect eof
