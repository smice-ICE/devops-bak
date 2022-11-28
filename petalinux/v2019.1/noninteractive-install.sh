#!/usr/bin/expect
set version [ lindex $argv 0 ]
set install_dir [ lindex $argv 1 ]

set timeout 3600

spawn ./petalinux-v$version-final-installer.run $install_dir
expect "Press Enter to display the license agreements"
send "\r"
expect "*>*"
send "y\r"
expect "*>*"
send "y\r"
expect "*>*"
send "y\r"
expect "*Petalinux SDK has been installed to*"
send_user "auto install petalinux done\r"
send_user "wait several minutes to clean up\r"
exit
