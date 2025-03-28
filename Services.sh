#!/bin/bash

## Les variables
: ${VAR01=whiptail}



#####################################################
fct001(){
systemctl start contrats.service
}
######################################################
fct002(){
systemctl stop contrats.service
}
########################################################
fct003(){
systemctl status contrats.service
}
########################################################
fct004(){
systemctl start analyse-images.service
}
########################################################
fct005(){
systemctl stop analyse-images.service
}
########################################################
fct006(){
systemctl status analyse-images.service
}
########################################################
fct007(){
systemctl start datamining-3.12.9.service
}
#########################################################
fct008(){
systemctl stop datamining-3.12.9.service
}
#########################################################
fct009(){
systemctl status datamining-3.12.9.service
}
#########################################################
fct010(){
systemctl start predictions.service
}
#########################################################
fct011(){
systemctl stop predictions.service
}
#########################################################
fct012(){
systemctl status predictions.service
}
#########################################################
fct013(){
systemctl start text_to_speech_gh.service
}
#########################################################
fct014(){
systemctl stop text_to_speech_gh.service
}
#########################################################
fct015(){
systemctl status text_to_speech_gh.service
}
#########################################################
fct016(){
systemctl start analyse_contrat_clients.service
}
#########################################################
fct017(){
systemctl stop analyse_contrat_clients.service
}
#########################################################
fct018(){
systemctl status analyse_contrat_clients.service
}

############################################################
if (whiptail --title "Services" --yesno "Continuer ?" 8 78); then


OPTION=$(whiptail --title "Services" --menu "(◕_◕) : Que souhaitez vous faire ?" 30 60 20 \
"fct001" "    Démarrer le service contrats" \
"fct002" "    Stopper le service contrats" \
"fct003" "    Statut du service contrats" \
"fct004" "    Démarrer le service analyse images" \
"fct005" "    Stopper le service analyse images" \
"fct006" "    Statut du service analyse images" \
"fct007" "    Démarrer le service datamining" \
"fct008" "    Stopper le service datamining" \
"fct009" "    Statut du service datamining" \
"fct010" "    Démarrer le service predictions" \
"fct011" "    Stopper le service predictions" \
"fct012" "    Statut du service predictions" \
"fct013" "    Démarrer le service text to speech" \
"fct014" "    Stopper le service text to speech" \
"fct015" "    Statut du service text to speech" \
"fct016" "    Démarrer le service analyse contrat clients" \
"fct017" "    Stopper le service analyse contrat clients" \
"fct018" "    Statut du service analyse contrat clients" 3>&1 1>&2 2>&3)
 
 
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
