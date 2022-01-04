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

send "vlan 2"

expect "6100(config-vlan-2)#"

send "description Isis"

expect "6100(config-vlan-2)#"

send "vlan 10"

expect "6100(config-vlan-10)#"

send "description Video"

expect "6100(config-vlan-10)#"

send "vlan 11"

expect "6100(config-vlan-11)#"

send "description Intrusion"

expect "6100(config-vlan-11)#"

send "exit"

expect "6100(config)#"

send "exit"

expect "6100#"

send "exit"

interact
#expect eof
