#!/bin/bash

## Les variables
: ${VAR01=whiptail}
: ${VAR02=/etc/smokeping}
: ${VAR03=`date +%y%m%d%H%M%S`} 
: ${VAR04=/home/pi/Documents}
: ${VAR08=`date +%s`}

## Les Fonctions
function fct007 {

## Configuration d'un host

#sudo -S chmod 777 $VAR02/config.d/Targets
#$VAR01 --title "Targets" --textbox $VAR02/config.d/Targets 12 80

VAR10=$($VAR01 --inputbox "Niveau ?" 8 39 ++ --title "Niveau" 3>&1 1>&2 2>&3)
VAR05=$($VAR01 --inputbox "Menu & Titre ?" 8 39 --title "Menu" 3>&1 1>&2 2>&3)
#VAR06=$($VAR01 --inputbox "Titre ?" 8 39 --title "Titre" 3>&1 1>&2 2>&3)
VAR07=$($VAR01 --inputbox "Adresse IP du Host ?" 8 39 --title "Host" 3>&1 1>&2 2>&3)


#fct001 | sudo -S cp $VAR02/config.d/Targets $VAR02/config.d/Targets.$VAR08
#sudo -S chmod 777 $VAR02/config.d/Targets.$VAR08
VAR09=`date +%s`
echo "
"$VAR10" "$VAR09"
menu = "$VAR05" 
title = "$VAR05" "$VAR07"
host = "$VAR07"
alerts = hostdown" >> $VAR12

#fct001 | sudo -S rm $VAR02/config.d/Targets
#fct001 | sudo -S cp $VAR02/config.d/Targets.$VAR08 $VAR02/config.d/Targets


fct008
#fct001 | sudo -S systemctl reload smokeping
}

function fct008 {
# choix

if ($VAR01 --title "Paramétrages" --yesno "Souhaites-tu ajouter un paramètre Smokeping ?" 10 60) then
exitstatus=$?
		if [ $exitstatus = 0 ]; then

VAR11=($VAR01 --separate-output --checklist "Select options:" 10 30 3)
options=(1 "Menu     " off    # any option can be set to default to "on"
         2 "Host     " off)
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

#sudo -S chmod 777 $VAR02/config.d/Targets
#$VAR01 --title "Targets" --textbox $VAR02/config.d/Targets 12 80

VAR10=$($VAR01 --inputbox "Niveau ?" 8 39 ++ --title "Niveau" 3>&1 1>&2 2>&3)
VAR05=$($VAR01 --inputbox "Menu & Titre ?" 8 39 --title "Menu" 3>&1 1>&2 2>&3)
#VAR06=$($VAR01 --inputbox "Titre ?" 8 39 --title "Titre" 3>&1 1>&2 2>&3)
#VAR07=$($VAR01 --inputbox "Adresse IP du Host ?" 8 39 192.168.1.1 --title "Host" 3>&1 1>&2 2>&3)


#fct001 | sudo -S cp $VAR02/config.d/Targets $VAR02/config.d/Targets.$VAR08
#sudo -S chmod 777 $VAR02/config.d/Targets.$VAR08
VAR09=`date +%s`
echo "
#---------------------------
"$VAR10" "$VAR09"
menu = "$VAR05" 
title = "$VAR05 >> $VAR12



#fct001 | sudo -S rm $VAR02/config.d/Targets
#fct001 | sudo -S cp $VAR02/config.d/Targets.$VAR08 $VAR02/config.d/Targets

fct008
#fct001 | sudo -S systemctl reload smokeping
}


function fct010 {
VAR12=$($VAR01 --inputbox "Nom du fichier de configuration" 8 39 Targets --title "Fichier" 3>&1 1>&2 2>&3)
}

# Lancement des menus

if ($VAR01 --title "Paramétrages" --yesno "Souhaites-tu paramétrer Smokeping ?" 10 60) then
#PASSWORD=$($VAR01 --title "Mot de passe Sudo" --passwordbox "Entrez votre mot de passe" 10 60 3>&1 1>&2 2>&3)
#exitstatus=$?
#		if [ $exitstatus = 0 ]; then

## Fonction pour le mot de passe sudo
#function fct001 {
#	echo $PASSWORD
#}

#----------------------------------------
# Appel fonctions
fct010
fct008		 

#----------------------------------------
## Fin du script
	else
		$VAR01 --title "Fin" --msgbox "Fin du script" 10 60
	fi
#$VAR01 --title "Fin" --msgbox "Fin du script" 10 60



