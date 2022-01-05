#!/bin/bash
#------------------------------------------------------------------------------------
## Script de configuration permettant d'ajouter des menus et des hosts sur smokeping
#------------------------------------------------------------------------------------

## Les variables
: ${VAR01=zenity}
: ${VAR02=/etc/smokeping}
: ${VAR03=`date +%y%m%d%H%M%S`} 
: ${VAR04=/home/pi/Documents}
: ${VAR07=connexion-ssh.sh}
: ${VAR08=`date +%s`}




# Lancement des menus

#if ($VAR01 --question --title "Paramétrages" --text "Souhaitez-vous paramétrer un Switch Aruba ?" 10 60) then

#PASSWORD=$($VAR01 --title "Mot de passe Sudo" --passwordbox "Entrez votre mot de passe Sudo" 10 60 3>&1 1>&2 2>&3)
PASSWORD=$($VAR01 --password --title="Mot de passe Sudo" --text "Entrez votre mot de passe Sudo :" --width "800" --height "40")

#VAR05=$($VAR01 --title "Adresse IP" --inputbox "Entrez l'adresse IP du switch" 10 60 3>&1 1>&2 2>&3)
VAR05=$($VAR01 --entry --title "Adresse IP" --text "Entrez l'adresse IP du switch :" --width "800" --height "40")

#VAR06=$($VAR01 --title "User" --inputbox "Entrez le nom d'utilisateur" 10 60 3>&1 1>&2 2>&3)
VAR06=$($VAR01 --entry --title "User" --text "Entrez le nom d'utilisateur :" --width "800" --height "40")

#VAR09=$($VAR01 --title "Password" --passwordbox "Entrez le mot de passe utilisateur" 10 60 3>&1 1>&2 2>&3)
VAR09=$($VAR01 --password --title="Mot de passe User" --text "Entrez le mot de passe utilisateur :" --width "800" --height "40")

#VAR10=$($VAR01 --title "Host" --inputbox "Entrez le Hostname" 10 60 3>&1 1>&2 2>&3)
VAR10=$($VAR01 --entry --title "Host" --text "Entrez le Hostname :" --width "800" --height "40")

#VAR11=$($VAR01 --title "Gateway" --inputbox "Entrez l'adresse IP de la passerelle" 10 60 3>&1 1>&2 2>&3)
VAR11=$($VAR01 --entry --title "Gateway" --text "Entrez l'adresse IP de la passerelle :" --width "800" --height "40")

#VAR12=$($VAR01 --title "DNS" --inputbox "Entrez l'adresse IP du DNS Principal" 10 60 3>&1 1>&2 2>&3)
VAR12=$($VAR01 --entry --title "DNS" --text "Entrez l'adresse IP du DNS Principal :" --width "800" --height "40")

#VAR13=$($VAR01 --title "DNS" --inputbox "Entrez l'adresse IP du DNS Secondaire" 10 60 3>&1 1>&2 2>&3)
VAR13=$($VAR01 --entry --title "DNS" --text "Entrez l'adresse IP du DNS Secondaire :" --width "800" --height "40")

 
#exitstatus=$?
#		if [ $exitstatus = 0 ]; then

## Fonction pour le mot de passe sudo
function fct001 {
	echo $PASSWORD
}

#----------------------------------------
# Appel fonctions

wget https://raw.githubusercontent.com/Yakakliker37/Base_info/main/connexion-aruba.sh

fct001 | sudo -S chmod +x connexion-aruba.sh

./connexion-aruba.sh $VAR05 $VAR06 $VAR09 $VAR10 $VAR11 $VAR12 $VAR13


#----------------------------------------
## Fin du script
#	else
#	fct001 | sudo -S systemctl reload smokeping
#	
#		$VAR01 --title "Fin" --msgbox "Fin du script" 10 60
#	fi

#	else
#	fct001 | sudo -S systemctl reload smokeping
#	
#		$VAR01 --title "Fin" --msgbox "Fin du script" 10 60
#	fi

## Yakakliker

