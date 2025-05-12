#!/bin/bash

###########################################################################
## Les fonctions

fct001(){

}
fct002(){

}
fct003(){

}
fct004(){

}
fct005(){

}
fct006(){

}


###########################################################################
## L'Interface

############# Sélection de l'action à exécuter ############################
if (whiptail --title "Environnements" --yesno "(◕_◕) : Continuer ?" 8 78); then

exitstatus=$?
if [ $exitstatus = 0 ]; then

OPTION=$(whiptail --title "Environnements" --menu "(◕_◕) : Que souhaitez vous faire ?" 20 60 10 \
"fct001" "    Fct001" \
"fct002" "    Fct002" \
"fct003" "    Fct003" \
"fct004" "    Fct004" \
"fct005" "    Fct005" \
"fct006" "    Fct006" \
3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then

$OPTION

else
fct999
fi
#########################################################
else
fct999
fi
#########################################################
else
fct999
fi
#########################################################

## Fin du script
