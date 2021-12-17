#!/bin/bash

##
## Script d'installation & de paramétrage de Smokeping
## Fait les updates
## Installe quelques utilitaires réseau
## Installe Webmin pour aider la configuration réseau multiple (https://Adresse_IP:10000)
## Installe Smokeping
## Configure les envois d'alerte
##

## Les variables
: ${VAR01=whiptail}
: ${VAR02=/etc/smokeping}
: ${VAR03=`date +%y%m%d%H%M%S`} 
: ${VAR04=/home/pi/Documents}
: ${VAR08=`date +%s`}

## Upgrade Linux
function fct002 {
clear
if ($VAR01 --title "NTPDATE" --yesno "Souhaites-tu installer NTPDATE et synchroniser l'horloge ?" 8 78); then
    fct001 | sudo -S apt-get install ntpdate
	fct001 | sudo -S ntpdate ntp.midway.ovh

else
    echo "Pas de synchronisation de l'horloge."
fi
fct001 | sudo -S apt-get update
fct001 | sudo -S apt-get dist-upgrade -y
$VAR01 --title "That's all folks !" --msgbox "Fin des mises à jour, pensez à redémarrer !" 8 78
}

## Installation de Webmin
function fct003 {
clear
fct001 | sudo -S apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python -y
cd ~
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.981_all.deb
fct001 | sudo -S dpkg -i webmin_1.981_all.deb 
fct001 | sudo -S apt-get install -f -y
$VAR01 --title "That's all folks !" --msgbox "Fin de l'installation de Webmin !" 8 78
}

## Installation de Smokeping
function fct004 {
clear
fct001 | sudo -S apt-get install ntpdate
fct001 | sudo -S ntpdate ntp.midway.ovh

fct001 | sudo -S apt-get install smokeping -y
fct001 | sudo -S a2enmod cgi
fct001 | sudo -S apt-get install postfix mailutils libsasl2-2 ca-certificates libsasl2-modules -y
fct001 | sudo -S dpkg-reconfigure postfix
fct001 | sudo -S dpkg-reconfigure locales

cd ~
fct001 | sudo -S mv /etc/postfix/main.cf /etc/postfix/main.cf.inst
fct001 | sudo -S echo "
# See /usr/share/postfix/main.cf.dist for a commented, more complete version


# Debian specific:  Specifying a file name will cause the first
# line of that file to be used as the name.  The Debian default
# is /etc/mailname.
#myorigin = /etc/mailname

smtpd_banner = $myhostname ESMTP $mail_name (Ubuntu)
biff = no

# appending .domain is the MUA job.
append_dot_mydomain = no

# Uncomment the next line to generate "delayed mail" warnings
#delay_warning_time = 4h

readme_directory = no
# See http://www.postfix.org/COMPATIBILITY_README.html -- default to 2 on
# fresh installs.
compatibility_level = 2

# TLS parameters
smtpd_tls_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
smtpd_tls_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
smtpd_tls_security_level=may

smtp_tls_CApath=/etc/ssl/certs
smtp_tls_security_level=may
smtp_tls_session_cache_database = btree:${data_directory}/smtp_scache
smtpd_relay_restrictions = permit_mynetworks permit_sasl_authenticated defer_unauth_destination
myhostname = smokeping.eyes.lan
alias_maps = hash:/etc/aliases
alias_database = hash:/etc/aliases
mydestination = $myhostname, smokeping, localhost.localdomain, , localhost
#relayhost = 
mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128
mailbox_size_limit = 0
recipient_delimiter = +
inet_interfaces = all
inet_protocols = all
relayhost = [smtp.gmail.com]:587
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_tls_CAfile = /etc/postfix/cacert.pem
smtp_use_tls = yes
" >> main.cf
fct001 | sudo -S cp main.cf /etc/postfix/main.cf
$VAR01 --title "/etc/postfix/main.cf" --textbox /etc/postfix/main.cf 40 80
fct001 | sudo -S rm main.cf

cd ~
fct001 | sudo -S echo "[smtp.gmail.com]:587 technique.comasys@gmail.com:Comasys*37 " >> sasl_passwd
fct001 | sudo -S cp sasl_passwd /etc/postfix/sasl_passwd
$VAR01 --title "/etc/postfix/sasl_passwd" --textbox /etc/postfix/sasl_passwd 40 80
fct001 | sudo -S rm sasl_passwd

fct001 | sudo -S chmod 400 /etc/postfix/sasl_passwd
fct001 | sudo -S postmap /etc/postfix/sasl_passwd

#Variables pour la création du certificat#
HOSTSMOKE01=$($VAR01 --inputbox "Hostname du serveur Smokeping" 8 39 Host --title "Hostname" 3>&1 1>&2 2>&3)
country=FR
state=FRANCE
locality=TOURS
organization=COMASYS
organizationalunit=DATACENTER
commonname=$HOSTSMOKE01
email=franckp.comasys@gmail.com

cd ~
fct001 | sudo -S mv /etc/hostname /etc/hostname.inst
fct001 | sudo -S echo $HOSTSMOKE01 >> hostname
fct001 | sudo -S cp hostname /etc/hostname
$VAR01 --title "/etc/hostname" --textbox /etc/hostname 40 80
fct001 | sudo -S rm hostname

cd ~
fct001 | sudo -S mv /etc/hosts /etc/hosts.inst
fct001 | sudo -S echo "127.0.0.1 localhost
127.0.1.1 "$HOSTSMOKE01"

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters" >> hosts
fct001 | sudo -S cp hosts /etc/hosts
$VAR01 --title "/etc/hosts" --textbox /etc/hosts 40 80
fct001 | sudo -S rm hosts



cd ~
cd /etc/ssl/certs
fct001 | sudo -S openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout key-for-smtp-gmail.pem -out cert-for-smtp-gmail.pem -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
fct001 | sudo -S cat /etc/ssl/certs/cert-for-smtp-gmail.pem | sudo tee -a /etc/postfix/cacert.pem

fct001 | sudo -S systemctl restart postfix

# Test d'envoi de mail
MAIL=$($VAR01 --title "Votre adresse mail" --inputbox "Entrez votre adresse mail" 10 60 3>&1 1>&2 2>&3)
exitstatus=$?
		if [ $exitstatus = 0 ]; then
fct001 | sudo -S echo "Test d'envoi de mail" | mail -s "Test" $MAIL
	else
		$VAR01 --title "Fin" --msgbox "Fin du script" 10 60
	fi
cd ~
fct001 | sudo -S cp /etc/aliases aliases
fct001 | sudo -S chmod a+w aliases
fct001 | sudo -S mv /etc/aliases /etc/aliases.inst
fct001 | sudo -S echo "smokealert: :include:/etc/smokeping/config.d/userstoalert " >> aliases
fct001 | sudo -S cp aliases /etc/aliases
$VAR01 --title "/etc/aliases" --textbox /etc/aliases 12 80
fct001 | sudo -S chmod a-w /etc/aliases
fct001 | sudo -S rm aliases


fct001 | sudo -S echo "
franckp.comasys@gmail.com
parisy.franck@gmail.com
julien.michaux@comasys.fr
francois.barthelemy@comasys.fr" >> userstoalert
fct001 | sudo -S cp userstoalert /etc/smokeping/config.d/userstoalert
$VAR01 --title "/etc/smokeping/config.d/userstoalert" --textbox /etc/smokeping/config.d/userstoalert 12 80
fct001 | sudo -S rm userstoalert

fct001 | sudo -S newaliases

cd ~
fct001 | sudo -S mv /etc/smokeping/config.d/General /etc/smokeping/config.d/General.inst
fct001 | sudo -S echo "
*** General ***

owner    = Franck Parisy
contact  = franckp.comasys@gmail.com
mailhost = smtp.comasys.fr
# NOTE: do not put the Image Cache below cgi-bin
# since all files under cgi-bin will be executed ... this is not
# good for images.
cgiurl   = http://127.0.0.1/smokeping/smokeping.cgi
# specify this to get syslog logging
syslogfacility = local0
# each probe is now run in its own process
# disable this to revert to the old behaviour
# concurrentprobes = no

@include /etc/smokeping/config.d/pathnames " >> General
fct001 | sudo -S cp General /etc/smokeping/config.d/General 
$VAR01 --title "/etc/smokeping/config.d/General" --textbox /etc/smokeping/config.d/General 40 80
fct001 | sudo -S rm General


cd ~
fct001 | sudo -S mv /etc/smokeping/config.d/Alerts /etc/smokeping/config.d/Alerts.inst
fct001 | sudo -S echo "
*** Alerts ***
to = smokealert@localhost
from = Alerte_Salle_Blanche@eyes-telecom.com

+someloss
type = loss
#in percent
pattern = >0%,*12*,>0%,*12*,>0%
comment = loss 3 times  in a row

# This rule checks for one period (1 * 5mins) of >50% loss
+hostdown
type = loss
# in percent
pattern = >50%
edgetrigger = yes
comment = Massive loss for 5 mins " >> Alerts
fct001 | sudo -S cp Alerts /etc/smokeping/config.d/Alerts
$VAR01 --title "/etc/smokeping/config.d/Alerts" --textbox /etc/smokeping/config.d/Alerts 40 80
fct001 | sudo -S rm Alerts

cd ~
fct001 | sudo -S mv /etc/smokeping/config.d/Probes /etc/smokeping/config.d/Probes.inst
fct001 | sudo -S echo "
*** Probes ***

+ FPing

binary = /usr/bin/fping
#packetsize = 500

hostinterval = 1.5
mininterval = 0.001
offset = 50%
timeout = 1.5
step = 300
pings = 20

 # these expect to find echoping in /usr/bin
 # if not, you'll have to specify the location separately for each probe
 # + EchoPing         # uses TCP or UDP echo (port 7)
 # + EchoPingDiscard  # uses TCP or UDP discard (port 9)
 # + EchoPingChargen  # uses TCP chargen (port 19)
 + EchoPingSmtp       # SMTP (25/tcp) for mail servers

 + EchoPingHttps      # HTTPS (443/tcp) for web servers

binary = /usr/bin/echoping
 forks = 5
 offset = 50%
 step = 300

 # The following variables can be overridden in each target section
accept_redirects = yes
# extraopts = -some-letter-the-author-did-not-think-of
# ignore_cache = yes
# ipversion = 4
# pings = 20
port = 37443
# priority = 6
# prot = 3443
# revalidate_data = no
# timeout = 20
# tos = 0xa0
# url = /
# waittime = 1


 + EchoPingHttp       # HTTP (80/tcp) for web servers and caches

 binary = /usr/bin/echoping
 forks = 5
 offset = 50%
 step = 300
timeout = 10


 # The following variables can be overridden in each target section
 accept_redirects = yes
 port = 80

 
 + EchoPingIcp        # ICP (3130/udp) for caches
 # these need at least echoping 6 with the corresponding plugins

 binary = /usr/bin/echoping
 forks = 5
 offset = 50%
 step = 300

 # The following variables can be overridden in each target section
 extraopts = -some-letter-the-author-did-not-think-of
 ipversion = 4
 pings = 20
 priority = 6
 timeout = 5
 tos = 0xa0
 url = http://www.example.org/ # mandatory
 waittime = 1


 + EchoPingDNS        # DNS (53/udp or tcp) servers
 + EchoPingLDAP       # LDAP (389/tcp) servers
 + EchoPingWhois      # Whois (43/tcp) servers

#++ FPingNormal
#offset = 0%


#++ FPingLarge
#packetsize = 5000
#offset = 50%

+ Curl
 # probe-specific variables
 binary = /usr/bin/curl
 step = 60
 
 # a default for this target-specific variable
 urlformat = http://%host%/ " >> Probes
fct001 | sudo -S cp Probes /etc/smokeping/config.d/Probes
$VAR01 --title "/etc/smokeping/config.d/Probes" --textbox /etc/smokeping/config.d/Probes 40 80
fct001 | sudo -S rm Probes



fct001 | sudo -S systemctl restart postfix
fct001 | sudo -S systemctl restart smokeping
tSmoke --testmail

$VAR01 --title "That's all folks !" --msgbox "
Fin de l'installation de Smokeping !
Vous pouvez vous connecter à l'adresse http://adresse_IP/smokeping/smokeping.cgi" 20 80

}

## Installation de l'agent de prise de main à distance Dwservice
function fct005 {
clear
cd ~
wget https://www.dwservice.net/download/dwagent_generic.sh

fct001 | sudo -S chmod +x dwagent_x86.sh
./dwagent_x86.sh
}



function fct007 {

## Configuration d'un host

sudo -S chmod 777 $VAR02/config.d/Targets
$VAR01 --title "Targets" --textbox $VAR02/config.d/Targets 12 80

VAR10=$($VAR01 --inputbox "Niveau ?" 8 39 ++ --title "Niveau" 3>&1 1>&2 2>&3)
VAR05=$($VAR01 --inputbox "Menu ?" 8 39 Menu --title "Menu" 3>&1 1>&2 2>&3)
VAR06=$($VAR01 --inputbox "Titre ?" 8 39 Titre --title "Titre" 3>&1 1>&2 2>&3)
VAR07=$($VAR01 --inputbox "Adresse IP du Host ?" 8 39 192.168.1.1 --title "Host" 3>&1 1>&2 2>&3)


fct001 | sudo -S cp $VAR02/config.d/Targets $VAR02/config.d/Targets.$VAR08
sudo -S chmod 777 $VAR02/config.d/Targets.$VAR08
VAR09=`date +%s`
fct001 | sudo -S echo "
"$VAR10" "$VAR09"
menu =  "$VAR05" 
title = "$VAR06"
host = "$VAR07"
alerts = hostdown
" >> $VAR02/config.d/Targets.$VAR08
fct001 | sudo -S rm $VAR02/config.d/Targets
fct001 | sudo -S cp $VAR02/config.d/Targets.$VAR08 $VAR02/config.d/Targets


fct008
fct001 | sudo -S systemctl reload smokeping
}

function fct008 {

# choix


if ($VAR01 --title "Paramétrages" --yesno "Souhaites-tu ajouter un paramètre Smokeping ?" 10 60) then
exitstatus=$?
		if [ $exitstatus = 0 ]; then
		
VAR11=($VAR01 --separate-output --checklist "Select options:" 22 76 16)
options=(1 "Menu" off    # any option can be set to default to "on"
         2 "Host" off)
choices=$("${VAR11[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
    case $choice in
        1)
            fct009
            ;;
        2)
            fct007
            ;;
    esac
done
		else
			$VAR01 --title "Fin" --msgbox "Fin du script" 10 60
		fi	
		else
			$VAR01 --title "Fin" --msgbox "Fin du script" 10 60
		fi	

}

function fct009 {

## Configuration d'un menu

sudo -S chmod 777 $VAR02/config.d/Targets
$VAR01 --title "Targets" --textbox $VAR02/config.d/Targets 12 80

VAR10=$($VAR01 --inputbox "Niveau ?" 8 39 + --title "Niveau" 3>&1 1>&2 2>&3)
VAR05=$($VAR01 --inputbox "Menu ?" 8 39 Menu --title "Menu" 3>&1 1>&2 2>&3)
VAR06=$($VAR01 --inputbox "Titre ?" 8 39 Titre --title "Titre" 3>&1 1>&2 2>&3)
#VAR07=$($VAR01 --inputbox "Adresse IP du Host ?" 8 39 192.168.1.1 --title "Host" 3>&1 1>&2 2>&3)


fct001 | sudo -S cp $VAR02/config.d/Targets $VAR02/config.d/Targets.$VAR08
sudo -S chmod 777 $VAR02/config.d/Targets.$VAR08
VAR09=`date +%s`
fct001 | sudo -S echo "
"$VAR10" "$VAR09"
menu =  "$VAR05" 
title = "$VAR06"
" >> $VAR02/config.d/Targets.$VAR08
fct001 | sudo -S rm $VAR02/config.d/Targets
fct001 | sudo -S cp $VAR02/config.d/Targets.$VAR08 $VAR02/config.d/Targets

fct008
fct001 | sudo -S systemctl reload smokeping
}



## Installation des utilitaires
function util001 {
fct001 | sudo -S apt-get install bmon -y
}
function util002 {
fct001 | sudo -S apt-get install iperf iperf3 -y
}
function util003 {
fct001 | sudo -S apt-get install iftop -y
}
function util004 {
fct001 | sudo -S apt-get install cbm -y
}
function util005 {
fct001 | sudo -S apt-get install netdiscover -y
}
function util006 {
fct001 | sudo -S apt-get install wireshark -y 
} 
function util007 {
fct001 | sudo -S apt-get install keepassxc -y
}
function util008 {
fct001 | sudo -S apt-get install terminator -y
}
function util009 {
fct001 | sudo -S apt-get install default-jdk -y
}
function util010 {
fct001 | sudo -S apt-get install zim -y
}
function util011 {
fct001 | sudo -S apt-get install arping -y
}
function util012 {
fct001 | sudo -S apt-get install putty -y
}
function util013 {
fct001 | sudo -S apt-get install filezilla -y
}
function util014 {
fct001 | sudo -S apt-get install rsyslog -y
}
function util015 {
fct001 | sudo -S apt-get install ifstat -y
}
function util016 {
fct001 | sudo -S apt-get install tcpdump -y
}
function util017 {
fct001 | sudo -S apt-get install mtr -y
}

## Menus d'installation
function menu001 {

$VAR01 --title "Modules" --checklist --separate-output "Sélection des outils ?" 25 40 18 \
"util001" "BMON" off \
"util002" "IPERF IPERF3" off \
"util003" "IFTOP" off \
"util004" "CBM" off \
"util005" "NETDISCOVER" off \
"util006" "WIRESHARK" off \
"util007" "KEEPASSXC" off \
"util008" "TERMINATOR" off \
"util009" "JDK" off \
"util010" "ZIM" off \
"util011" "ARPING" off \
"util012" "PUTTY" off \
"util013" "FILEZILLA" off \
"util014" "RSYSLOG" off \
"util015" "IFSTAT" off \
"util016" "TCPDUMP" off \
"util017" "MTR" off \
"menu002" "Autres applications" off 2>results

while read choice
do
        case $choice in
                util001) util001
                ;;
                util002) util002
                ;;
                util003) util003
                ;;
				util004) util004
                ;;
				util005) util005
                ;;
				util006) util006
                ;;
				util007) util007
                ;;
				util008) util008
                ;;
				util009) util009
                ;;
				util010) util010
                ;;
				util011) util011
                ;;
				util012) util012
                ;;
				util013) util013
                ;;
				util014) util014
                ;;
				util015) util015
                ;;
				util016) util016
                ;;
				util017) util017
                ;;
				menu002) menu002
                ;;
				*)
                ;;
        esac
done < results

}

function menu002 {

$VAR01 --title "Sélections" --checklist --separate-output "Sélection des applications ?" 25 50 17 \
"fct003" "WEBMIN" off \
"fct002" "UPGRADE SYSTEME" off \
"fct005" "DWSERVICE	" off \
"fct008" "Configuration de Smokeping " off \
"fct004" "Installation de Smokeping " off 2>results

while read choice
do
        case $choice in
                fct003) fct003
                ;;
                fct002) fct002
                ;;
                fct005) fct005
                ;;
                fct008) fct008
                ;;
                fct004) fct004
                ;;
				*)
                ;;
        esac
done < results


}


# Lancement des menus

if ($VAR01 --title "Paramétrages" --yesno "Souhaites-tu lancer les installations ?" 10 60) then

PASSWORD=$($VAR01 --title "Mot de passe Sudo" --passwordbox "Entrez votre mot de passe" 10 60 3>&1 1>&2 2>&3)
 
exitstatus=$?
		if [ $exitstatus = 0 ]; then

## Fonction pour le mot de passe sudo
function fct001 {
	echo $PASSWORD
}

## Update & synchronisation de l'horloge avant toute nouvelle installation
clear
fct001 | sudo -S apt-get update
#menu001
fct002
fct003
fct005
util001
util002
util003
util004
util005
util011
util014
util015
util016
util017
fct004




## Fin du script

		else
			$VAR01 --title "Fin" --msgbox "Fin du script" 10 60
		fi	

	else
		$VAR01 --title "Fin" --msgbox "Fin du script" 10 60
	fi
	
## Yakakliker


