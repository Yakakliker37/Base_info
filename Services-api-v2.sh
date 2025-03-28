#!/bin/bash
# Version PRY20250328-a

## Les variables

export env01="bffgpaoapi"
export env02="bffnocontestapi"
export env03="bffplanning"
export env04="bffreferentielapi"
export env05="bffsseapi"
export env06="bienapi"
export env07="gdtapi"
export env08="geideapi"
export env09="svp-expertiseapi"

export selection="(◕_◕)"

## Les fonctions

#####################################################
fct001(){
/etc/init.d/$selection.sh start
}
######################################################
fct002(){
/etc/init.d/$selection.sh stop
}
######################################################
fct003(){
tail -f /home/$selection/applis/api/logs/api.log
}
fct999(){
echo "(◕_◕) : That's all folks !"
}


## L'Interface

############################################################
if (whiptail --title "Environnements API" --yesno "(◕_◕) : Continuer ?" 8 78); then

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
"fct003" "    Logs de $selection" \
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
