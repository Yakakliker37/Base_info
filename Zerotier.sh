#!/bin/bash

## Les variables
: ${VAR01=whiptail}



#####################################################
fct001(){
sudo apt-get update -y

sudo curl -s https://install.zerotier.com | sudo bash
}


######################################################
fct002(){
ID=$(whiptail --inputbox "Votre ID réseau ?" 8 39  --title "ID Réseau" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then

sudo zerotier-cli join $ID

else
    echo "Annulation."
fi
}


########################################################
fct003(){
ID=$(whiptail --inputbox "Votre ID réseau ?" 8 39  --title "ID Réseau" 3>&1 1>&2 2>&3)


exitstatus=$?
if [ $exitstatus = 0 ]; then


sudo zerotier-cli leave $ID

else
    echo "Annulation."
fi
}

########################################################
fct004(){

sudo zerotier-cli listnetworks

}
########################################################
fct005(){

sudo zerotier-cli status

}

########################################################
fct006(){

sudo systemctl restart zerotier-one

}
########################################################
fct007(){
ID=12ac4a1e7186593d
sudo zerotier-cli join $ID
}
#########################################################
fct008(){
ID=12ac4a1e7186593d
sudo zerotier-cli leave $ID
}
############################################################
if (whiptail --title "Zerotier" --yesno "Continuer ?" 8 78); then


OPTION=$(whiptail --title "Zerotier" --menu "Que souhaitez vous faire ?" 15 60 6 \
"fct001" "    Installer Zerotier" \
"fct002" "    Vous connecter" \
"fct003" "    Vous déconnecter" \
"fct004" "    Lister les connexions réseau" \
"fct005" "    Connaitre l'état du client Zerotier" \
"fct006" "    Redémarrer le service Zerotier" \
"fct007" "    Se connecter @Home" \
"fct008" "    Se déconnecter de @Home" 3>&1 1>&2 2>&3)
 
 
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


