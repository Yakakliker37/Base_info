#!/bin/bash
# Version PRY-25070102
#
# Ce script liste les environnements présents sur le serveur
# Il propose l'arrêt ou le démarrage de chacun des environnements ainsi que de tous les environnements
# Il propose aussi de visualiser les logs de démarrage (nohup.out ou catalina.out) de chaque environnement
# Il propose aussi la création de l'environnement
# Il propose la gestion de Haproxy (Vérification du fichier conf / Arrêt, démarrage, statut du service / Application de la configuration)
#

############ Actions préalables
cd ~ || exit
export var25052101
var25052101=$(mktemp)  																										# Création du fichier temporaire

############ Profils  à exclure de la liste des environnements
export rem001=imdeo
export rem002=montages
export rem003=prtg

############ Création du fichier avec la liste des environnements présents
cd /home || exit
for env00 in *; do
	echo "$env00" >> "$var25052101"																							# Alimentation du fichier avec la liste des environnements du système
done

############ Suppression des environnements exclus
sed -i "/$rem001/d" "$var25052101"
sed -i "/$rem002/d" "$var25052101"
sed -i "/$rem003/d" "$var25052101"

############ Les variables
export selection="(◕_◕)"
export var25042301="(°_°)"

export var24051101
var24051101=$(date +%y%m%d)																									# Variable date année-mois-jour


# Variables couleurs --- Pour faire sympa --- Oh la belle bleue !
export red="\033[31m"																										# Rouge
export turquoise="\033[36m"																									# Turquoise
export gras="\033[1m"																										# Gras
export rougegras="\033[1;31m"																								# Rouge Gras
export reset="\033[0m"	

export alert=(
		root=,red
		window=,white
		border=black,white
		textbox=black,white
		button=red,white
	)

export info=(
		root=,blue
		window=,white
		border=black,white
		textbox=black,white
		button=red,white
	)

	
############ Création de la liste des environnements présents
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
		rm -f "$var25052101" 																												# Suppression du fichier temporaire	
		chmod +x "$var25042401" 																											# On rend exécutable le script
		$var25042401 start 																													# Démarrage de l'environnement
		echo "$var25042401" start 																											# Affichage de la commande pour information
	else
		echo -e "${rougegras}" $var25042301 Le script "$var25042401" n"'"existe pas. "${reset}"												# Message d'erreur si le script de démarrage n'existe pas
		NEWT_COLORS=$alert whiptail --msgbox ""$var25042301" Le script "$var25042401" n'existe pas. " --title "Fichier inexistant" 8 78

	fi
}

############ Arrêt de l'environnement ###############
fct002() {
	fct998
	export var25042401=/etc/init.d/$var25052104.sh
	if [ -e "$var25042401" ]; then
		rm -f "$var25052101" 																												# Suppression du fichier temporaire	
		chmod +x "$var25042401"																												# On rend exécutable le script
		$var25042401 stop																													# Arrêt de l'environnement
		echo "$var25042401" stop																											# Affichage de la commande pour information
	else
		echo -e "${rougegras}" $var25042301 Le script "$var25042401" n"'"existe pas. "${reset}"												# Message d'erreur si le script d'arrêt n'existe pas
		NEWT_COLORS=$alert whiptail --msgbox ""$var25042301" Le script "$var25042401" n'existe pas. " --title "Fichier inexistant" 8 78

	fi
}

############ Affichage des logs de l'environnement ###############
fct003() {
	fct998
	clear
	#echo $var25052104

	export var25052102=/home/$var25052104/tomcat/logs/catalina.out																				# Log Catalina
	export var25052105=/home/$var25052104/applis/api/logs/api.log																				# Log api.log
	export var25052103=/home/$var25052104/nohup.out																								# Log nohup

	# On teste si le fichier log est présent et on l'affiche
	if [ -e "$var25052102" ]; then
		rm -f "$var25052101" 																													# Suppression du fichier temporaire
		tail -f "$var25052102" 																													# Affichage du log
	else
		if [ -e "$var25052105" ]; then
			rm -f "$var25052101" 																												# Suppression du fichier temporaire
			tail -f "$var25052105" 																												# Affichage du log

		else
			if [ -e "$var25052103" ]; then
				rm -f "$var25052101" 																											# Suppression du fichier temporaire
				tail -f "$var25052103" 																											# Affichage du log
			else
				rm -f "$var25052101" 																											# Suppression du fichier temporaire
				echo -e "${rougegras}" $var25042301 Impossible d"'"afficher les logs de "$var25052104". "${reset}" 								# Message d'erreur
				NEWT_COLORS=$alert whiptail --msgbox ""$var25042301" Impossible d'afficher les logs de "$var25052104". " --title "Fichier inexistant" 8 78

			fi
		fi
	fi
}

############ Démarrage de tous les environnements ###############
fct004() {
	clear
	# Utilisation du fichier $var25052101 pour le démarrage des environnements
	cd ~ || exit
	for ligne in $(<"$var25052101"); do
		echo -e "${turquoise}" $var25042301 Démarrage de "$ligne". "${reset}"																	# Affichage de la session de démarrage
		export var25042403=/etc/init.d/$ligne.sh																								# Initialisation de la variable de commande
		if [ -e "$var25042403" ]; then
			chmod +x "$var25042403"																												# On rend exécutable le script de démarrage
			$var25042403 start																													# Commande de démarrage de l'environnement
			echo "$var25042403" start																											# Affichage de la commande pour information
		else
			echo -e "${rougegras}" $var25042301 Le script "$var25042403" n"'"existe pas. "${reset}" 											# Message d'erreur si le script de démarrage n'existe pas
			NEWT_COLORS=$alert whiptail --msgbox ""$var25042301" Le script "$var25042403" n'existe pas. " --title "Fichier inexistant" 8 78

		fi
		echo "----------"
		sleep 10
	done
		rm -f "$var25052101" 																													# Suppression du fichier temporaire	
}

############ Arrêt de tous les environnements ###############
fct005() {
	clear
	# Utilisation du fichier $var25052101 pour l'arrêt des environnements
	cd ~ || exit
	for ligne in $(<"$var25052101"); do
		echo -e "${turquoise}" $var25042301 Arrêt de "$ligne". "${reset}"																		# Affichage de la session d'arrêt
		export var25042404=/etc/init.d/$ligne.sh																								# Initialisation de la variable de commande
		if [ -e "$var25042404" ]; then
			chmod +x "$var25042404"																												# On rend exécutable le script d'arrêt
			$var25042404 stop																													# Commande d'arrêt de l'environnement
			echo "$var25042404" stop																											# Affichage de la commande pour information
		else
			echo -e "${rougegras}" $var25042301 Le script "$var25042404" n"'"existe pas. "${reset}"												# Message d'erreur si le script d'arrêt n'existe pas
			NEWT_COLORS=$alert whiptail --msgbox ""$var25042301" Le script "$var25042404" n'existe pas. " --title "Fichier inexistant" 8 78

		fi
		echo "----------"
		sleep 10
	done
		rm -f "$var25052101" 																													# Suppression du fichier temporaire	
}

############ Htop ###############
fct006() {
	rm -f "$var25052101" 																														# Suppression du fichier temporaire	
	htop																																		# Commande htop pour affichage des processus
}

############ Création de l'environnement ###############
fct007() {
	cd / || exit

	var25051201=$(NEWT_COLORS=$info whiptail --inputbox "Entrez le nom de l'environnement" 10 60 3>&1 1>&2 2>&3)								# Initialisation de la variable d'environnement 

		fct104

	# Type d'environnement

		var25062401=$(NEWT_COLORS=$info whiptail --menu "(◕_◕) : Sélection du type d'environnement ?" 25 60 15 \
			"fct100" "    Springboot" \
			"fct101" "    Python" \
			"fct102" "    Node JS" \
			3>&1 1>&2 2>&3)

		exitstatus=$?
		if [ $exitstatus = 0 ]; then
			$var25062401																														# Lancement de la fonction choisie
		fi	
}

######## Démarrage du service Haproxy #####################
fct008(){
	systemctl start haproxy
	fct996
}
######## Arrêt du service Haproxy #########################
fct009(){
	systemctl stop haproxy
	fct996
}
######## Rechargement de la configuration Haproxy #########
fct010(){
	systemctl reload haproxy
	fct996
}
######## Vérification de la configuration Haproxy #########
fct011(){
clear
export var25062701
var25062701=$(haproxy -f /etc/haproxy/haproxy.cfg -c 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
#if [ "$var25062701" = "Configuration file is valid" ]; then
	NEWT_COLORS=$info whiptail --msgbox "(◕_◕) : Le fichier de configuration est valide !" --title "Fichier valide" 8 55
	clear
	else
	NEWT_COLORS=$alert whiptail --msgbox "$var25062701" --title "Fichier non valide" 30 150
fi
fct996

}
######## Statut du service Haproxy ########################
fct012(){
hatop -s /var/run/haproxy/admin.sock
}



###########################################################
	# Création de l' arborescence Springboot	
fct100() {
	if (NEWT_COLORS=$info whiptail --yesno "(◕_◕) : Création de l'arborescence Springboot ?" 8 78); then										# Création de l'arborescence Springboot ? OUI/NON
	mkdir /home/$var25051201/deploy-logs
	mkdir /home/$var25051201/logs-apache
	mkdir /home/$var25051201/www
	mkdir -p /home/$var25051201/applis/api/conf/backup
	mkdir -p /home/$var25051201/applis/api/logs
	mkdir -p /home/$var25051201/applis/api/scripts
	chown -R $var25051201: /home/$var25051201

		# Création du script init
			if (NEWT_COLORS=$info whiptail --yesno "(◕_◕) : Création du script init ?" 8 78); then												# Création du script de démarrage ? OUI/NON
		fct103
		fi

	# Configuration Apache
		if (NEWT_COLORS=$info whiptail --yesno "(◕_◕) : Création du fichier Apache ?" 8 78); then												# Création du fichier de configuration Apache ? OUI/NON
		fct105																																	# Création du fichier vierge date-environnement.conf
		fi

	# Création du fichier logrotate dans /etc/apache2/logrotate
		if (NEWT_COLORS=$info whiptail --yesno "(◕_◕) : Création du fichier logrotate ?" 8 78); then											# Création du fichier logrotate ? OUI/NON
		fct106
		fi

		if (NEWT_COLORS=$info whiptail --yesno "(◕_◕) : Création lien Java ?" 8 78); then														# Création du lien JDK ? OUI/NON
		fct107
		fi
	
	rm -f "$var25052101" 																														# Suppression du fichier temporaire	
		NEWT_COLORS=$info whiptail --msgbox "Création de l'environnement terminée." 10 60 														# Message d'information de fin de création de l'environnement
	fi
}

###########################################################
	# Création de l' arborescence Python	
fct101() {
	if (NEWT_COLORS=$info whiptail --yesno "(◕_◕) : Création de l'arborescence Python ?" 8 78); then											# Création de l'arborescence Python ? OUI/NON
	mkdir /home/$var25051201/deploy-logs
	mkdir /home/$var25051201/www
	mkdir /home/$var25051201/www/logs-gunicorn
	chown -R $var25051201: /home/$var25051201
	touch /etc/systemd/system/"$var25051201".service	

	# Création du Service
	echo "création du Service"																													# Message d'information
	tee /etc/systemd/system/"$var25051201".service <<EOF
[Unit]
Description=Gunicorn instance to serve $var25051201
After=network.target

[Service]
LogLevelMax=6
User=$var25051201
Group=$var25051201
WorkingDirectory=/home/$var25051201/www
Environment="PATH=/home/$var25051201/www"
ExecStart=/home/$var25051201/.pyenv/versions/$var25051201-3.12.9/bin/gunicorn -w 4 -t 6000 -c gunicorn_3.12.9_conf.py 'app_main:app' --bind 127.0.0.1:8888

[Install]
WantedBy=default.target
EOF

	usermod -aG sudo $var25051201
	
	rm -f "$var25052101" 																									# Suppression du fichier temporaire	
		NEWT_COLORS=$info whiptail --msgbox "Création de l'environnement terminée." 10 60 														# Message d'information de fin de création de l'environnement
	fi
}

##########################################################
	# Création de l' arborescence Node JS	
fct102() {
	if (NEWT_COLORS=$info whiptail --yesno "(◕_◕) : Création de l'arborescence Node JS ?" 8 78); then										# Création de l'arborescence Node JS ? OUI/NON
	mkdir /home/$var25051201/deploy-logs
	mkdir /home/$var25051201/logs-apache
	mkdir /home/$var25051201/www
	chown -R $var25051201: /home/$var25051201

	# Configuration Apache
		if (NEWT_COLORS=$info whiptail --yesno "(◕_◕) : Création du fichier Apache ?" 8 78); then											# Création du fichier de configuration Apache ? OUI/NON
		fct105																												# Création du fichier vierge date-environnement.conf
		fi

	# Création du fichier logrotate dans /etc/apache2/logrotate
		if (NEWT_COLORS=$info whiptail --yesno "(◕_◕) : Création du fichier logrotate ?" 8 78); then											# Création du fichier logrotate ? OUI/NON
		fct106
		fi
	
	rm -f "$var25052101" 																									# Suppression du fichier temporaire	
		NEWT_COLORS=$info whiptail --msgbox "Création de l'environnement terminée." 10 60 														# Message d'information de fin de création de l'environnement
	fi
}

##########################################################
	# Création du fichier init
fct103() {
		touch /etc/init.d/"$var25051201".sh																					# Création du fichier vierge "environnement.sh"
		chmod +x /etc/init.d/"$var25051201".sh																				# On rend exécutable le script

		echo "création du script init.d"																					# Message d'information
		tee /etc/init.d/"$var25051201".sh <<EOF
#! /bin/bash
#

# chkconfig: 345 81 15
# SpringBoot Start the Springboot server.
#
# description: service de demarrage SpringBoot
# Source function library
#. /etc/init.d/functions

case "\$1" in
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
}

##########################################################
	# Création de l'environnement
fct104() {
	echo "$var25051201"																										# Affichage du nom de l'environnement
	useradd -s /bin/bash -m "$var25051201"																					# Commande de création de l'environnement
	passwd "$var25051201"																									# Définition du mot de passe de l'environnement
}

##########################################################
	# Création du fichier vierge Apache
fct105() {
		touch /etc/apache2/sites-available/"$var24051101"-"$var25051201".conf												# Création du fichier vierge date-environnement.conf
}

##########################################################
	# Création du fichier logrotate
fct106() {

		touch /etc/apache2/"$var25051201".cfg																				# Création du fichier vierge logrotate

		echo "création du fichier logrotate"																				# Message d'information 
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
}

##########################################################
	# Création du lien Java
fct107() {

	var25052203=$(NEWT_COLORS=$info whiptail --inputbox "Entrez la version du JDK" 10 60 3>&1 1>&2 2>&3)										# Initialisation de la variable du JDK
	cd /usr/java || exit

		if [ -d "$var25052203" ]; then																						# Vérification de la présence du JDK
			#echo "Le dossier $var25052203 existe."
			ln -s "$var25052203" java-"$var25051201"																		# Création du lien JDK
		else
			#echo "La version $var25052203 n'est pas présente sur le serveur. "
			NEWT_COLORS=$alert whiptail --msgbox "La version $var25052203 n'est pas présente sur le serveur. " 10 60   						# Message d'alerte concernant le JDK
		fi

}

##########################################################
	# Installation des utilitaires Linux
fct200() {

	apt-get install build-essential linux-headers-$(uname -r)
	apt-get install net-tools htop curl dos2unix tcpdump git
	
	NEWT_COLORS=$info whiptail --msgbox "Création de l'environnement terminée." 10 60 														# Message d'information de fin d'installation des utilitaires Linux

}


##########################################################
###########################################################################
## Les Interfaces graphiques
fct994() {
############# Gestion de Linux ############################
	var25070101=$(NEWT_COLORS=$info whiptail --menu "(◕_◕) : Que souhaitez vous faire ?" 25 60 15 \
			"fct200" "    Installation des utilitaires Linux" \
			"fct006" "    Htop" \
			3>&1 1>&2 2>&3)
			
		exitstatus=$?
		if [ $exitstatus = 0 ]; then
			$var25070101																											# Lancement de la fonction choisie
		else
			fct995
		fi

}

fct995() {
############# Sélection de l'action à exécuter ############################

		var25062504=$(NEWT_COLORS=$info whiptail --menu "(◕_◕) : Que souhaitez vous faire ?" 25 60 15 \
			"fct997" "    Gestion des environnements" \
			"fct006" "    Htop" \
			"fct996" "    Gestion de Haproxy" \
			"fct994" "    Gestion de Linux" \
			3>&1 1>&2 2>&3)

		exitstatus=$?
		if [ $exitstatus = 0 ]; then
			$var25062504																											# Lancement de la fonction choisie
		else
			fct999
		fi
#########################################################
}
######## Menu de Gestion de Haproxy ########################
fct996() {

		var25062502=$(NEWT_COLORS=$info whiptail --menu "(◕_◕) : Que souhaitez vous faire ?" 25 60 15 \
			"fct008" "    Démarrer le service Haproxy" \
			"fct009" "    Stopper le service Haproxy" \
			"fct010" "    Rechargement Haproxy" \
			"fct011" "    Vérification de la configuration Haproxy" \
			"fct012" "    Statut du service Haproxy" \
			3>&1 1>&2 2>&3)

		exitstatus=$?
		if [ $exitstatus = 0 ]; then
			$var25062502																											# Lancement de la fonction choisie
		else
			fct995
		fi
}
######## Menu de Gestion des environnements ########################
fct997() {

		var25062503=$(NEWT_COLORS=$info whiptail --menu "(◕_◕) : Que souhaitez vous faire ?" 25 60 15 \
			"fct001" "    Démarrer un environnement" \
			"fct002" "    Stopper un environnement" \
			"fct003" "    Logs d' un environnement" \
			"fct004" "    Démarrer tous les environnements" \
			"fct005" "    Arrêter tous les environnements" \
			"fct007" "    Création d'un environnement" \
			3>&1 1>&2 2>&3)

		exitstatus=$?
		if [ $exitstatus = 0 ]; then
			$var25062503																											# Lancement de la fonction choisie
		else
			fct995
		fi
}
############# Choix de l'environnement ############################
fct998() {
	var25052104=$(NEWT_COLORS=$info whiptail --menu "(◕_◕) : Choisissez un environnement :" 30 60 20 "${node_list[@]}" 3>&1 1>&2 2>&3)		# Initialisation de la variable d'environnement
}

############# Fin du script ############################
fct999() {
	rm -f "$var25052101"																									# Suppression du fichier temporaire
	echo "(◕_◕) : That's all folks !"																						# Information de fin d'exécution du script
}

#### The Ultimate Software ! ####

fct995

## That's all