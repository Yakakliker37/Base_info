#!/bin/bash

## Les variables
export VAR01="whiptail"
export VAR02="001.sh"

export red="\033[31m"
export turquoise="\033[36m"
export bleue="\033[34m"
export jaune="\033[33m"
export vert="\033[32m"
export gras="\033[1m"
export souligne="\033[4m"
export clignotant="\033[5m"
export reset="\033[0m"
export rougegrasclignotant="\033[31;1;5m"
export turquoisegras="\033[36;1m"
export vertgras="\033[32;1m"
export jaunegras="\033[33;1m"





#####################################################
fct001(){
sudo apt-get update -y
sudo apt-get upgrade -y
}


######################################################
fct002(){
sudo apt-get install -q -y build-essential linux-headers-$(uname -r)
sudo apt-get install -q -y net-tools
sudo apt-get install -q -y rkhunter
curl -O https://raw.githubusercontent.com/Yakakliker37/Base_info/main/Zerotier.sh



}


########################################################
fct003(){
sudo curl -s https://install.zerotier.com | sudo bash

}

########################################################
fct004(){

sudo apt-get install -q -y ufw -y
sudo ufw allow ssh
sudo ufw enable
sudo apt-get install -q -y fail2ban -y
sudo systemctl enable fail2ban
sudo systemctl start fail2ban


}
########################################################
fct005(){

sudo apt-get install -q -y postfix mailutils libsasl2-2 ca-certificates libsasl2-modules
sudo dpkg-reconfigure postfix
cd ~
sudo -S mv /etc/postfix/main.cf /etc/postfix/main.cf.inst
sudo -S echo "
# See /usr/share/postfix/main.cf.dist for a commented, more complete version


# Debian specific:  Specifying a file name will cause the first
# line of that file to be used as the name.  The Debian default
# is /etc/mailname.
#myorigin = /etc/mailname

smtpd_banner = $myhostname ESMTP $mail_name (Ubuntu)
biff = no

# appending .domain is the MUA's job.
append_dot_mydomain = no

# Uncomment the next line to generate "delayed mail" warnings
#delay_warning_time = 4h

readme_directory = no

# See http://www.postfix.org/COMPATIBILITY_README.html -- default to 3.6 on
# fresh installs.
compatibility_level = 3.6



# TLS parameters
smtpd_tls_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
smtpd_tls_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
#smtpd_tls_security_level=may

smtp_tls_CApath=/etc/ssl/certs

smtp_tls_session_cache_database = btree:${data_directory}/smtp_scache

smtp_tls_wrappermode = yes
smtp_tls_security_level = encrypt


smtpd_relay_restrictions = permit_mynetworks permit_sasl_authenticated defer_unauth_destination
myhostname = monitor.yakakliker.org
alias_maps = hash:/etc/aliases
alias_database = hash:/etc/aliases
#myorigin = /etc/mailname
mydestination = monitor, localhost.localdomain, localhost
#relayhost = 
mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128
mailbox_size_limit = 0
recipient_delimiter = +
inet_interfaces = all
inet_protocols = all

relayhost = smtp-fr.securemail.pro:465

smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options =
smtp_tls_CAfile = /etc/postfix/cacert.pem
smtp_use_tls = yes

smtp_sasl_mechanism_filter = login

sender_canonical_maps = hash:/etc/postfix/sender_canonical
recipient_canonical_maps = hash:/etc/postfix/recipient_canonical
" >> main.cf
sudo -S cp main.cf /etc/postfix/main.cf

##########

sudo -S echo "
root										monitor@yakakliker.org
root@monitor								monitor@yakakliker.org
root@monitor.yakakliker.org					monitor@yakakliker.org
administrateur			 					monitor@yakakliker.org
administrateur@monitor 						monitor@yakakliker.org
administrateur@monitor.yakakliker.org		monitor@yakakliker.org
" >> sender_canonical
sudo -S cp sender_canonical /etc/postfix/sender_canonical

##########


sudo -S echo "
root										monitor@yakakliker.org
root@monitor								monitor@yakakliker.org
root@monitor.yakakliker.org					monitor@yakakliker.org
administrateur			 					monitor@yakakliker.org
administrateur@monitor 						monitor@yakakliker.org
administrateur@monitor.yakakliker.org		monitor@yakakliker.org
" >> recipient_canonical
sudo -S cp recipient_canonical /etc/postfix/recipient_canonical

##########
#Création du certificat#

cd ~
cd /etc/ssl/certs
sudo openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout key-for-smtp-gmail.pem -out cert-for-smtp-gmail.pem -subj "/C=FR/ST=FRANCE/L=TOURS/O=YAKAKLIKER/OU=Web/CN=observium/emailAddress=webmaster@yakakliker.org"
sudo -S cat /etc/ssl/certs/cert-for-smtp-gmail.pem | sudo tee -a /etc/postfix/cacert.pem

}
############################################################
if (whiptail --title "Zerotier" --yesno "Continuer ?" 8 78); then


OPTION=$(whiptail --title "Zerotier" --menu "Que souhaitez vous faire ?" 15 60 6 \
"fct001" "    Mises à jours" \
"fct002" "    Installation des utilitaires de base" \
"fct003" "    Installation de Zerotier" \
"fct004" "    Installation de Fail2ban" \
"fct005" "    Installation de Postfix" 3>&1 1>&2 2>&3)
 
 
exitstatus=$?
if [ $exitstatus = 0 ]; then
#    echo "Vous avez choisi la distribution : " $OPTION
$OPTION

else
    echo "vous avez annulé"
fi


#########################################################

## Fin du script

else
	echo "Fin."
fi


