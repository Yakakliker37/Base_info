#!/usr/bin/expect

set timeout 20

set ip [lindex $argv 0]

set user [lindex $argv 1]

set password [lindex $argv 2]

spawn ssh "$user\@$ip"

expect "password:"

send "$password\r";

expect "administrateur@"

send "wget https://raw.githubusercontent.com/Yakakliker37/Base_info/main/smokeping.sh\r"

expect "administrateur@"

send "ls\r"

expect "administrateur@"

send "sudo chmod +x smokeping.sh\r"

expect "password"

send "$password\r";

expect "administrateur@"

send "./smokeping.sh\r"

interact
#expect eof
