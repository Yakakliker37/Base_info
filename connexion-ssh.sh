#!/usr/bin/expect

set timeout 20

set ip [lindex $argv 0]

set user [lindex $argv 1]

set password [lindex $argv 2]

spawn ssh "$user\@$ip"

expect "password:"

send "$password\r";

expect "administrateur@smoke:"

send "wget https://raw.githubusercontent.com/Yakakliker37/Base_info/main/smokeping.sh\r"

expect "administrateur@smoke:"

send "ls\r"

expect "administrateur@smoke:"

send "sudo chmod +x smokeping.sh\r"

expect "[sudo] password for administrateur:"

send "$password\r";

expect "administrateur@smoke:"

send "./smokeping.sh\r"

interact
#expect eof
