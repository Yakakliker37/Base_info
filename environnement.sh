#!/bin/bash
# version PRY25051901
###########################################################################
## Les variables

var24051101=`date +%y%m%d`

###########################################################################
## Les fonctions

fct001(){
cd /

var25051201=$(whiptail --title "Environnement" --inputbox "Entrez le nom de l'environnement" 10 60 3>&1 1>&2 2>&3)

# Environnement
### Arborescence initiale créée dans /etc/skel

echo $var25051201
useradd -s /bin/bash -m $var25051201
passwd $var25051201

# Démarrage et arrêt de l'environnement
if (whiptail --title "Init.d" --yesno "(◕_◕) : Création du script init ?" 8 78); then

touch /etc/init.d/$var25051201.sh
chmod +x /etc/init.d/$var25051201.sh

echo "création du script init.d"
tee /etc/init.d/$var25051201.sh <<EOF
#! /bin/bash
#

# chkconfig: 345 81 15
# SpringBoot Start the Springboot server.
#
# description: service de demarrage SpringBoot
# Source function library
#. /etc/init.d/functions

case "$1" in
        start)
                echo -ne "Starting tomcat... \n"
                su - $var25051201 -c '/home/$var25051201/applis/api/scripts/start.sh'
                exit 1
        ;;

        stop)
                echo -ne "Stopping tomcat...\n"
                su - $var25051201 -c '/home/$var25051201/applis/api/scripts/stop.sh'
                exit 1
        ;;

        *)
                echo "Usage: /etc/init.d/$var25051201.sh {start|stop}"
                exit 1
        ;;
esac

exit 0
EOF

else
echo ""
fi


# Configuration Apache
if (whiptail --title "Apache" --yesno "(◕_◕) : Création du fichier Apache ?" 8 78); then

touch /etc/apache2/sites-available/$var24051101-$var25051201.conf

else
echo ""
fi

# Création du fichier logrotate dans /etc/apache2/logrotate
if (whiptail --title "Logrotate" --yesno "(◕_◕) : Création du fichier logrotate ?" 8 78); then

touch /etc/apache2/$var25051201.cfg

echo "création du fichier logrotate"
tee /etc/apache2/logrotate/$var25051201.cfg <<EOF
/home/$var25051201/logs-apache/*.log {
        daily
        rotate 90
        compress
	delaycompress
	missingok
	copytruncate
}
EOF
else
echo ""
fi
whiptail --msgbox "Création de l'environnement terminée." 10 50 –title "Environnement"

}
fct002(){
echo ""
}
fct003(){
echo ""
}
fct004(){
echo ""
}
fct005(){
echo ""
}
fct006(){
echo ""
}
############# Fonction fin de script ############################
fct999(){
echo "(◕_◕) : That's all folks !"
}


###########################################################################
## L'Interface

############# Sélection de l'action à exécuter ############################
if (whiptail --title "Environnements" --yesno "(◕_◕) : Continuer ?" 8 78); then

exitstatus=$?
if [ $exitstatus = 0 ]; then

OPTION=$(whiptail --title "Environnements" --menu "(◕_◕) : Que souhaitez vous faire ?" 20 60 10 \
"fct001" "    Création de l'environnement" \
"fct002" "    Fct002" \
"fct003" "    Fct003" \
"fct004" "    Fct004" \
"fct005" "    Fct005" \
"fct006" "    Fct006" \
3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then

$OPTION

else
fct999
fi
#########################################################
else
fct999
fi
#########################################################
else
fct999
fi
#########################################################

## Fin du script
