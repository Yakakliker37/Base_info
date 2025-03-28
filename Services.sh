#!/bin/bash
# Version PRY20250328-a

## Les variables

export env01="contrats.service"
export env02="analyse-images.service"
export env03="datamining-3.12.9.service"
export env04="predictions.service"
export env05="text_to_speech_gh.service"
export env06="analyse_contrat_clients.service"
export env07="(◕_◕)"
export env08="(◕_◕)"
export env09="(◕_◕)"

export selection=""

## Les fonctions

#####################################################
fct001(){
systemctl start $selection
}
######################################################
fct002(){
systemctl stop $selection
}
######################################################
fct003(){
systemctl status $selection
}
fct999(){
echo "(◕_◕) : That's all folks !"
}


## L'Interface

############################################################
if (whiptail --title "Environnements" --yesno "(◕_◕) : Continuer ?" 8 78); then

environnement=$(whiptail --menu "(◕_◕) : Choisissez un environnement :" 30 60 20 \
"1" "$env01" \
"2" "$env02" \
"3" "$env03" \
"4" "$env04" \
"5" "$env05" \
"6" "$env06" \
"7" "$env07" \
"8" "$env08" \
"9" "$env09" \
3>&1 1>&2 2>&3)


if [ $environnement -eq 1 ]
then selection=$env01
elif [ $environnement -eq 2 ]
then selection=$env02
elif [ $environnement -eq 3 ]
then selection=$env03
elif [ $environnement -eq 4 ]
then selection=$env04
elif [ $environnement -eq 5 ]
then selection=$env05
elif [ $environnement -eq 6 ]
then selection=$env06
elif [ $environnement -eq 7 ]
then selection=$env07
elif [ $environnement -eq 8 ]
then selection=$env08
elif [ $environnement -eq 9 ]
then selection=$env09

else
fct999
fi


exitstatus=$?
if [ $exitstatus = 0 ]; then

OPTION=$(whiptail --title "Environnements API" --menu "(◕_◕) : Que souhaitez vous faire ?" 20 60 10 \
"fct001" "    Démarrer $selection" \
"fct002" "    Stopper $selection" \
"fct003" "    Statut de $selection" \
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
