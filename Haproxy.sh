#!/bin/bash

## Les variables
: ${VAR01=whiptail}



#####################################################
fct001(){
systemctl start haproxy
}
######################################################
fct002(){
systemctl stop haproxy
}
########################################################
fct003(){
systemctl reload haproxy
}
########################################################
fct004(){
haproxy -f /etc/haproxy/haproxy.cfg -c
}
#########################################################
fct018(){
hatop -s /var/run/haproxy/admin.sock
}

############################################################
if (whiptail --title "Haproxy" --yesno "Continuer ?" 8 78); then


OPTION=$(whiptail --title "Haproxy" --menu "(◕_◕) : Que souhaitez vous faire ?" 30 60 20 \
"fct001" "    Démarrer le service Haproxy" \
"fct002" "    Stopper le service Haproxy" \
"fct003" "    Reload le service Haproxy" \
"fct004" "    Vérification de la configuration Haproxy" \
"fct018" "    Statut du service Haproxy" 3>&1 1>&2 2>&3)
 
 
exitstatus=$?
if [ $exitstatus = 0 ]; then

$OPTION

else
    echo "(◕_◕) : Vous avez annulé votre demande. "
fi


#########################################################

## Fin du script

else
	echo "(◕_◕) : That's all folks !"
fi
