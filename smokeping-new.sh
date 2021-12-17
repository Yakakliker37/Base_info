#!/bin/bash
#------------------------------------------------------------------------------------
## Script de configuration permettant d'ajouter des menus et des hosts sur smokeping
#------------------------------------------------------------------------------------

## Les variables
: ${VAR01=whiptail}
: ${VAR02=/etc/smokeping}
: ${VAR03=`date +%y%m%d%H%M%S`} 
: ${VAR04=/home/pi/Documents}
: ${VAR07=connexion-ssh.sh}
: ${VAR08=`date +%s`}




# Lancement des menus

if ($VAR01 --title "Paramétrages" --yesno "Souhaitez-vous paramétrer Smokeping ?" 10 60) then

PASSWORD=$($VAR01 --title "Mot de passe Sudo" --passwordbox "Entrez votre mot de passe" 10 60 3>&1 1>&2 2>&3)

VAR05=$($VAR01 --title "Adresse IP" --inputbox "Entrez l'adresse IP du serveur" 10 60 3>&1 1>&2 2>&3)

VAR06=$($VAR01 --title "User" --inputbox "Entrez le nom d'utilisateur" 10 60 3>&1 1>&2 2>&3)

VAR09=$($VAR01 --title "Password" --passwordbox "Entrez le mot de passe utilisateur" 10 60 3>&1 1>&2 2>&3)

 
exitstatus=$?
		if [ $exitstatus = 0 ]; then

## Fonction pour le mot de passe sudo
function fct001 {
	echo $PASSWORD
}

#----------------------------------------
# Appel fonctions

wget https://raw.githubusercontent.com/Yakakliker37/Base_info/main/connexion-ssh.sh

fct001 | sudo -S chmod +x connexion-ssh.sh

./connexion-ssh.sh $VAR05 $VAR06 $VAR09


#----------------------------------------
## Fin du script
	else
#	fct001 | sudo -S systemctl reload smokeping
	
		$VAR01 --title "Fin" --msgbox "Fin du script" 10 60
	fi

	else
#	fct001 | sudo -S systemctl reload smokeping
	
		$VAR01 --title "Fin" --msgbox "Fin du script" 10 60
	fi

## Yakakliker

