#!/bin/bash


## Les variables
: ${VAR01=whiptail}



#####################################################
fct001(){

sudo ip route add 172.16.0.0/28 via 10.37.150.129
sudo ip route add 172.16.1.0/28 via 10.37.150.129
sudo ip route add 172.16.2.0/28 via 10.37.150.129
sudo ip route add 172.16.3.0/28 via 10.37.150.129
sudo ip route add 172.16.4.0/28 via 10.37.150.129
sudo ip route add 172.16.5.0/28 via 10.37.150.129
sudo ip route add 172.16.6.0/28 via 10.37.150.129
sudo ip route add 172.16.7.0/28 via 10.37.150.129
sudo ip route add 172.16.8.0/28 via 10.37.150.129
sudo ip route add 172.16.9.0/28 via 10.37.150.129
sudo ip route add 172.16.10.0/28 via 10.37.150.129
sudo ip route add 172.16.11.0/28 via 10.37.150.129
sudo ip route add 172.16.12.0/28 via 10.37.150.129
sudo ip route add 172.16.13.0/28 via 10.37.150.129
sudo ip route add 172.16.14.0/28 via 10.37.150.129
sudo ip route add 172.16.15.0/28 via 10.37.150.129
sudo ip route add 172.16.16.0/28 via 10.37.150.129
sudo ip route add 172.16.17.0/28 via 10.37.150.129

}


######################################################
fct002(){
ID=$(whiptail --inputbox "Reseau de destination ?" 8 39  --title "IP Réseau" 3>&1 1>&2 2>&3)
GW=$(whiptail --inputbox "IP Gateway ?" 8 39  --title "GW Réseau" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then

sudo ip route add $ID via $GW
else
    echo "Annulation."
fi
}


########################################################
fct003(){

sudo route

}

########################################################
fct004(){

sudo ifconfig

}
########################################################
fct005(){

sudo ip route del 172.16.0.0/28 
sudo ip route del 172.16.1.0/28 
sudo ip route del 172.16.2.0/28 
sudo ip route del 172.16.3.0/28 
sudo ip route del 172.16.4.0/28 
sudo ip route del 172.16.5.0/28 
sudo ip route del 172.16.6.0/28 
sudo ip route del 172.16.7.0/28 
sudo ip route del 172.16.8.0/28 
sudo ip route del 172.16.9.0/28 
sudo ip route del 172.16.10.0/28 
sudo ip route del 172.16.11.0/28 
sudo ip route del 172.16.12.0/28 
sudo ip route del 172.16.13.0/28 
sudo ip route del 172.16.14.0/28 
sudo ip route del 172.16.15.0/28 
sudo ip route del 172.16.16.0/28 
sudo ip route del 172.16.17.0/28 


}

########################################################
fct006(){

ID=$(whiptail --inputbox "Reseau de destination ?" 8 39  --title "IP Réseau" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then

sudo ip route del $ID
else
    echo "Annulation."
fi

}


############################################################
if (whiptail --title "Reseau" --yesno "Continuer ?" 8 78); then


OPTION=$(whiptail --title "Reseau" --menu "Que souhaitez vous faire ?" 15 60 6 \
"fct001" "    Ajouter les routes IP vers le VLAN Mgnt" \
"fct002" "    Ajouter une route IP" \
"fct003" "    Connaître les routes IP" \
"fct004" "    Connaître les adresses IP" \
"fct005" "    Supprimer les routes vers le VLAN Mgt" \
"fct006" "    Supprimer une route" 3>&1 1>&2 2>&3)
 
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

