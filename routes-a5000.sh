#!/bin/bash

## Les variables
: ${VAR01=whiptail}
: ${VAR02=./etc/sysconfig}
: ${VAR03=whiptail}

$VAR01 --title "Création de routes réseau" --msgbox "Bienvenue sur l'utilitaire de création de routes persistantes A5000" 8 90

if ($VAR01 --title "Vérification du fichier network" --yesno "Souhaitez-vous vérifier le fichier network ?" 8 90); then

nano /etc/sysconfig/network

else 
echo "Cancel."
fi


if ($VAR01 --title "Vérification du fichier Auto_eth1" --yesno "Souhaitez-vous vérifier le fichier Auto_eth1 ?" 8 90); then

nano /etc/sysconfig/network-scripts/ifcfg-Auto_eth1


else


$VAR01 --title "That's all folks !" --msgbox "Au revoir !" 8 39

fi
