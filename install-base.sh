#!/bin/bash

## Les variables
export VAR01="whiptail"
export VAR02="001.sh"

export red="\033[31m"
export turquoise="\033[36m"
export bleue="\033[34m"
export jaune="\033[33m"
export vert="\033[32m"
export gras="\033[1m"
export souligne="\033[4m"
export clignotant="\033[5m"
export reset="\033[0m"
export rougegrasclignotant="\033[31;1;5m"
export turquoisegras="\033[36;1m"
export vertgras="\033[32;1m"
export jaunegras="\033[33;1m"



#####################################################
fct001(){
sudo apt-get update -y
sudo apt-get upgrade -y
}


######################################################
fct002(){
sudo apt-get install build-essential linux-headers-$(uname -r)
sudo apt-get install net-tools
sudo apt-get install rkhunter


}


########################################################
fct003(){
sudo curl -s https://install.zerotier.com | sudo bash
curl -o Zerotier.sh https://raw.githubusercontent.com/Yakakliker37/Base_info/main/Zerotier.sh
sh Zerotier.sh

}

########################################################
fct004(){

sudo apt install ufw -y
sudo ufw allow ssh
sudo ufw enable
sudo apt install fail2ban -y
sudo systemctl enable fail2ban
sudo systemctl start fail2ban


}
########################################################
fct005(){


}

########################################################
fct006(){



}
########################################################
fct007(){

}
#########################################################
fct008(){

}
############################################################
if (whiptail --title "Zerotier" --yesno "Continuer ?" 8 78); then


OPTION=$(whiptail --title "Zerotier" --menu "Que souhaitez vous faire ?" 15 60 6 \
"fct001" "    Mises à jours" \
"fct002" "    Installation des utilitaires de base" \
"fct003" "    Installation de Zerotier" \
"fct004" "    Installation de Fail2ban" 3>&1 1>&2 2>&3)
 
 
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


