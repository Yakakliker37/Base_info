#!/bin/bash
# Version PRY2025052101
#
# Ce script liste les environnements présents sur le serveur
# Il propose l'arrêt ou le démarrage de chacun des environnements ainsi que de tous les environnements
# Il propose aussi de visualiser les logs de démarrage (nohup.out ou catalina.out) de chaque environnement
# Il propose aussi la création de l'environnement
#

############ Actions préalables
cd ~ || exit
export var25052101
var25052101=$(mktemp)  # Fichier temporaire

clear

############ Profils  à exclure de la liste des environnements
export rem001=imdeo
export rem002=montages
export rem003=prtg

############ Création du fichier avec la liste des environnements présents
cd /home || exit
for env00 in *; do
	echo "$env00" >> "$var25052101"
done

############ Suppression des environnements exclus
sed -i "/$rem001/d" "$var25052101"
sed -i "/$rem002/d" "$var25052101"
sed -i "/$rem003/d" "$var25052101"

############ Les variables
export selection="(◕_◕)"
export var25042301="(°_°)"

export var24051101
var24051101=$(date +%y%m%d)


# Variables couleurs --- Ca sert à rien mais ça a de la gueule
export red="\033[31m"
export turquoise="\033[36m"
export gras="\033[1m"
export rougegras="\033[1;31m"
export reset="\033[0m"

############ Création de la liste des environnements
cd ~ || exit
node_list=()
for f in $(<"$var25052101"); do
	node_list[${#node_list[@]}]=$f
	node_list[${#node_list[@]}]=""
done

## Les fonctions

############ Démarrage de l'environnement ###############
fct001() {
	fct998
	export var25042401=/etc/init.d/$var25052104.sh
	if [ -e "$var25042401" ]; then
		chmod +x "$var25042401"
		$var25042401 start
		echo "$var25042401" start
	else
		echo -e "${rougegras}" $var25042301 Le script "$var25042401" n"'"existe pas. "${reset}"
	fi
}
############ Arrêt de l'environnement ###############
fct002() {
	fct998
	export var25042401=/etc/init.d/$var25052104.sh
	if [ -e "$var25042401" ]; then
		chmod +x "$var25042401"
		$var25042401 stop
		echo "$var25042401" stop
	else
		echo -e "${rougegras}" $var25042301 Le script "$var25042401" n"'"existe pas. "${reset}"
	fi
}
############ Affichage des logs de l'environnement ###############
fct003() {
	fct998
	clear
	#echo $var25052104

	export var25052102=/home/$var25052104/tomcat/logs/catalina.out
	export var25052103=/home/$var25052104/nohup.out

	# Test pour vérifier quel fichier log existe
	if [ -e "$var25052102" ]; then
		rm -f "$var25052101" # Suppression du fichier temporaire
		tail -f "$var25052102" # Affichage du log
	else
		if [ -e "$var25052103" ]; then
			rm -f "$var25052101" # Suppression du fichier temporaire
			tail -f "$var25052103" # Affichage du log
		else
			rm -f "$var25052101" # Suppression du fichier temporaire
			echo -e "${rougegras}" $var25042301 Impossible d"'"afficher les logs de "$var25052104". "${reset}" # Message d'erreur
		fi
	fi
}

############ Démarrage de tous les environnements ###############
fct004() {
	clear
	# Utilisation du fichier $var25052101 pour le démarrage des environnements
	cd ~ || exit
	for ligne in $(<"$var25052101"); do
		echo -e "${turquoise}" $var25042301 Démarrage de "$ligne". "${reset}"
		export var25042403=/etc/init.d/$ligne.sh
		if [ -e "$var25042403" ]; then
			chmod +x "$var25042403"
			$var25042403 start
			echo "$var25042403" start
		else
			echo -e "${rougegras}" $var25042301 Le script "$var25042403" n"'"existe pas. "${reset}"
		fi
		echo "----------"
		sleep 10
	done
}
############ Arrêt de tous les environnements ###############
fct005() {
	clear
	# Utilisation du fichier $var25052101 pour l'arrêt des environnements
	cd ~ || exit
	for ligne in $(<"$var25052101"); do
		echo -e "${turquoise}" $var25042301 Arrêt de "$ligne" "${reset}"
		export var25042404=/etc/init.d/$ligne.sh
		if [ -e "$var25042404" ]; then
			chmod +x "$var25042404"
			$var25042404 stop
			echo "$var25042404" stop
		else
			echo -e "${rougegras}" $var25042301 Le script "$var25042404" n"'"existe pas. "${reset}"
		fi
		echo "----------"
		sleep 10
	done
}

############ Htop ###############
fct006() {
	htop
}

############ Création de l'environnement ###############
fct007() {
	cd / || exit

	var25051201=$(whiptail --title "Environnement" --inputbox "Entrez le nom de l'environnement" 10 60 3>&1 1>&2 2>&3)

	# Environnement
	echo "$var25051201"
	useradd -s /bin/bash -m "$var25051201"
	passwd "$var25051201"

	# Démarrage et arrêt de l'environnement
	if (whiptail --title "Init.d" --yesno "(◕_◕) : Création du script init ?" 8 78); then

		touch /etc/init.d/"$var25051201".sh
		chmod +x /etc/init.d/"$var25051201".sh

		echo "création du script init.d"
		tee /etc/init.d/"$var25051201".sh <<EOF
#! /bin/bash
#

# chkconfig: 345 81 15
# SpringBoot Start the Springboot server.
#
# description: service de demarrage SpringBoot
# Source function library
#. /etc/init.d/functions

case "$1" in
        start)
                echo -ne "Starting tomcat... \n"
                su - $var25051201 -c '/home/$var25051201/applis/api/scripts/start.sh'
                exit 1
        ;;

        stop)
                echo -ne "Stopping tomcat...\n"
                su - $var25051201 -c '/home/$var25051201/applis/api/scripts/stop.sh'
                exit 1
        ;;

        *)
                echo "Usage: /etc/init.d/$var25051201.sh {start|stop}"
                exit 1
        ;;
esac

exit 0
EOF

	else
		echo ""
	fi

	# Configuration Apache
	if (whiptail --title "Apache" --yesno "(◕_◕) : Création du fichier Apache ?" 8 78); then

		touch /etc/apache2/sites-available/"$var24051101"-"$var25051201".conf

	else
		echo ""
	fi

	# Création du fichier logrotate dans /etc/apache2/logrotate
	if (whiptail --title "Logrotate" --yesno "(◕_◕) : Création du fichier logrotate ?" 8 78); then

		touch /etc/apache2/"$var25051201".cfg

		echo "création du fichier logrotate"
		tee /etc/apache2/logrotate/"$var25051201".cfg <<EOF
/home/$var25051201/logs-apache/*.log {
        daily
        rotate 90
        compress
	delaycompress
	missingok
	copytruncate
}
EOF
	else
		echo ""
	fi
	whiptail --msgbox "Création de l'environnement terminée." 10 50 –title "Environnement"

}

############# Choix de l'environnement ############################
fct998() {
	var25052104=$(whiptail --menu "(◕_◕) : Choisissez un environnement :" 30 60 20 "${node_list[@]}" 3>&1 1>&2 2>&3)
}

############# Fin du script ############################
fct999() {
	rm -f "$var25052101"
	echo "(◕_◕) : That's all folks !"
}

###########################################################################
## L'Interface graphique

############# Sélection de l'action à exécuter ############################
if (whiptail --title "Environnements" --yesno "(◕_◕) : Continuer ?" 8 78); then

	exitstatus=$?
	if [ $exitstatus = 0 ]; then

		OPTION=$(whiptail --title "Environnements" --menu "(◕_◕) : Que souhaitez vous faire ?" 20 60 10 \
			"fct001" "    Démarrer un environnement" \
			"fct002" "    Stopper un environnement" \
			"fct003" "    Logs d' un environnement" \
			"fct004" "    Démarrer tous les environnements" \
			"fct005" "    Arrêter tous les environnements" \
			"fct006" "    Htop" \
			"fct007" "    Création d'un environnement" \
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
