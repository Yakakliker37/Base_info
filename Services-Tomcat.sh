#!/bin/bash
# Version PRY20250328

## Les variables

export env01="tomcatprd11"
export env02="tomcatprd12"
export env03="tomcatprd13"
export env04="tomcatprd14"
export env05="tomcatprd31"


#####################################################
fct001(){
/etc/init.d/$env01.sh start
}
######################################################
fct002(){
/etc/init.d/$env01.sh stop
}
######################################################
fct003(){
tail -f /home/$env01/tomcat/logs/catalina.out
}
########################################################
fct004(){
/etc/init.d/$env02.sh start
}
########################################################
fct005(){
/etc/init.d/$env02.sh stop
}
######################################################
fct006(){
tail -f /home/$env02/tomcat/logs/catalina.out
}
########################################################
fct007(){
/etc/init.d/$env03.sh start
}
#########################################################
fct008(){
/etc/init.d/$env03.sh stop
}
######################################################
fct009(){
tail -f /home/$env03/tomcat/logs/catalina.out
}
#########################################################
fct010(){
/etc/init.d/$env04.sh start
}
#########################################################
fct011(){
/etc/init.d/$env04.sh stop
}
######################################################
fct012(){
tail -f /home/$env04/tomcat/logs/catalina.out
}
#########################################################
fct013(){
/etc/init.d/$env05.sh start
}
#########################################################
fct014(){
/etc/init.d/$env05.sh stop
}
######################################################
fct015(){
tail -f /home/$env05/tomcat/logs/catalina.out
}

############################################################
if (whiptail --title "Environnements Tomcat" --yesno "Continuer ?" 8 78); then


OPTION=$(whiptail --title "Environnements Tomcat" --menu "(◕_◕) : Que souhaitez vous faire ?" 30 60 20 \
"fct001" "    Démarrer $env01" \
"fct002" "    Stopper $env01" \
"fct003" "    Logs de $env01" \
"fct004" "    Démarrer $env02" \
"fct005" "    Stopper $env02" \
"fct006" "    Logs de $env02" \
"fct007" "    Démarrer $env03" \
"fct008" "    Stopper $env03" \
"fct009" "    Logs de $env03" \
"fct010" "    Démarrer $env04" \
"fct011" "    Stopper $env04" \
"fct012" "    Logs de $env04" \
"fct013" "    Démarrer $env05" \
"fct014" "    Stopper $env05" \
"fct015" "    Logs de $env05" 3>&1 1>&2 2>&3)
 
 
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
