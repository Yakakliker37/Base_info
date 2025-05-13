#!/bin/bash

###########################################################################
## Les variables

var24051101=`date +%y%m%d`

###########################################################################
## Les fonctions

fct001(){
cd /

var25051201=$(whiptail --title "Environnement" --inputbox "Entrez le nom de l'environnement" 10 60 3>&1 1>&2 2>&3)

# Environnement
echo $var25051201
useradd -m $var25051201
passwd $var25051201

# Démarrage et arrêt de l'environnement
touch /etc/init.d/$var25051201.sh
chmod +x /etc/init.d/$var25051201.sh

# Configuration Apache
touch /etc/apache2/sites-available/$var24051101-$var25051201.conf

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
