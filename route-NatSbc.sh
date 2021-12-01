#!/bin/bash

# -----------------------------------------------------------------------------------------------------
# Script de vérification des paramètres réseau pour régler le problème de route par défaut des NAT SBC
# Pour tout problème avec le script, contacter Franck
# -----------------------------------------------------------------------------------------------------

## Les variables
: ${VAR01=whiptail}
: ${VAR02=/etc/sysconfig}
: ${VAR04=/root/Documents}

# Le script
$VAR01 --title "Vérification de la configuration réseau" --msgbox "Bienvenue sur l'utilitaire de vérification réseau pour les NAT SBC" 8 90

if ($VAR01 --title "Vérification du fichier network" --yesno "Souhaitez-vous vérifier le fichier network ?" 8 90); then
cp $VAR02/network $VAR04/network.fpold
sed -i '/GATEWAY/d' $VAR02/network
$VAR01 --title "That's all folks !" --msgbox "Fichier network vérifié !" 8 39
else 
$VAR01 --title "That's all folks !" --msgbox "OK !" 8 39
fi

if ($VAR01 --title "Vérification du fichier Auto_eth1" --yesno "Souhaitez-vous vérifier le fichier Auto_eth1 ?" 8 90); then
cp $VAR02/network-scripts/ifcfg-Auto_eth1 $VAR04/ifcfg-Auto_eth1.fpold
sed -i '/DEFROUTE/d' $VAR02/network-scripts/ifcfg-Auto_eth1
echo DEFROUTE=yes >> $VAR02/network-scripts/ifcfg-Auto_eth1
$VAR01 --title "That's all folks !" --msgbox "Fichier ifcfg-Auto_eth1 vérifié !" 8 39
else
$VAR01 --title "That's all folks !" --msgbox "OK !" 8 39
fi

if ($VAR01 --title "Redémarrage du service réseau" --yesno "Souhaitez-vous redémarrer le service réseau ?" 8 90); then
/etc/init.d/network restart
$VAR01 --title "That's all folks !" --msgbox "Service réseau redémarré !" 8 39
else
$VAR01 --title "That's all folks !" --msgbox "Fin du programme !" 8 39
fi