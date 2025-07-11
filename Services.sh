#!/bin/bash
# Version PRY-25071101
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
var25052101=$(mktemp)  																																				# Création du fichier temporaire

############ Profils  à exclure de la liste des environnements
export rem001=imdeo
export rem002=montages
export rem003=prtg

############ Création du fichier avec la liste des environnements présents
cd /home || exit
for env00 in *; do
	echo "$env00" >> "$var25052101"																																	# Alimentation du fichier avec la liste des environnements du système
done

############ Suppression des environnements exclus
sed -i "/$rem001/d" "$var25052101"
sed -i "/$rem002/d" "$var25052101"
sed -i "/$rem003/d" "$var25052101"

############ Les variables
export selection="(◕_◕)"
export var25042301="(°_°)"
export var25070203="°(◕_◕)°"

export var24051101
var24051101=$(date +%y%m%d)																																			# Variable date année-mois-jour


# Variables couleurs --- Pour faire sympa --- Oh la belle bleue !
export red="\033[31m"																																				# Rouge
export turquoise="\033[36m"																																			# Turquoise
export gras="\033[1m"																																				# Gras
export rougegras="\033[1;31m"																																		# Rouge Gras
export reset="\033[0m"	

export alert=(
		"root=,red"
		"window=,white"
		"border=black,white"
		"textbox=black,white"
		"button=red,white"
	)

export info=(
		"root=,blue"
		"window=,white"
		"border=black,white"
		"textbox=black,white"
		"button=red,white"
	)

	
############ Création de la liste des environnements présents
cd ~ || exit
node_list=()
for f in $(<"$var25052101"); do
	node_list[${#node_list[@]}]=$f
	node_list[${#node_list[@]}]=""
done

## Les fonctions



fct001() {
############ Démarrage de l'environnement ###############

	fct998
	export var25042401=/etc/init.d/$var25052104.sh
	if [ -e "$var25042401" ]; then
		rm -f "$var25052101" 																																		# Suppression du fichier temporaire	
		chmod +x "$var25042401" 																																	# On rend exécutable le script
		$var25042401 start 																																			# Démarrage de l'environnement
		echo "$var25042401" start 																																	# Affichage de la commande pour information
	else
		echo -e "${rougegras}" $var25042301 Le script "$var25042401" n"'"existe pas. "${reset}"																		# Message d'erreur si le script de démarrage n'existe pas
		NEWT_COLORS=${alert[*]} whiptail --msgbox "$var25042301 Le script $var25042401 n'existe pas. " --title "Fichier inexistant" 8 78

	fi
	fct997
}

fct002() {
############ Arrêt de l'environnement ###############

	fct998
	export var25042401=/etc/init.d/$var25052104.sh
	if [ -e "$var25042401" ]; then
		rm -f "$var25052101" 																																		# Suppression du fichier temporaire	
		chmod +x "$var25042401"																																		# On rend exécutable le script
		$var25042401 stop																																			# Arrêt de l'environnement
		echo "$var25042401" stop																																	# Affichage de la commande pour information
	else
		echo -e "${rougegras}" $var25042301 Le script "$var25042401" n"'"existe pas. "${reset}"																		# Message d'erreur si le script d'arrêt n'existe pas
		NEWT_COLORS=${alert[*]} whiptail --msgbox "$var25042301 Le script $var25042401 n'existe pas. " --title "Fichier inexistant" 8 78

	fi
	fct997
}

fct003() {
############ Affichage des logs de l'environnement ###############

	fct998
	clear
	#echo $var25052104

	export var25052102=/home/$var25052104/tomcat/logs/catalina.out																									# Log Catalina
	export var25052105=/home/$var25052104/applis/api/logs/api.log																									# Log api.log
	export var25052103=/home/$var25052104/nohup.out																													# Log nohup

	# On teste si le fichier log est présent et on l'affiche
	if [ -e "$var25052102" ]; then
		rm -f "$var25052101" 																																		# Suppression du fichier temporaire
		tail -f "$var25052102" 																																		# Affichage du log
	else
		if [ -e "$var25052105" ]; then
			rm -f "$var25052101" 																																	# Suppression du fichier temporaire
			tail -f "$var25052105" 																																	# Affichage du log

		else
			if [ -e "$var25052103" ]; then
				rm -f "$var25052101" 																																# Suppression du fichier temporaire
				tail -f "$var25052103" 																																# Affichage du log
			else
				rm -f "$var25052101" 																																# Suppression du fichier temporaire
				echo -e "${rougegras}" $var25042301 Impossible d"'"afficher les logs de "$var25052104". "${reset}" 													# Message d'erreur
				NEWT_COLORS=${alert[*]} whiptail --msgbox "$var25042301 Impossible d'afficher les logs de $var25052104. " --title "Fichier inexistant" 8 78

			fi
		fi
	fi
}


fct004() {
############ Démarrage de tous les environnements ###############

	clear
	# Utilisation du fichier $var25052101 pour le démarrage des environnements
	cd ~ || exit
	for ligne in $(<"$var25052101"); do
		echo -e "${turquoise}" $var25042301 Démarrage de "$ligne". "${reset}"																						# Affichage de la session de démarrage
		export var25042403=/etc/init.d/$ligne.sh																													# Initialisation de la variable de commande
		if [ -e "$var25042403" ]; then
			chmod +x "$var25042403"																																	# On rend exécutable le script de démarrage
			$var25042403 start																																		# Commande de démarrage de l'environnement
			echo "$var25042403" start																																# Affichage de la commande pour information
		else
			echo -e "${rougegras}" $var25042301 Le script "$var25042403" n"'"existe pas. "${reset}" 																# Message d'erreur si le script de démarrage n'existe pas
			NEWT_COLORS=${alert[*]} whiptail --msgbox "$var25042301 Le script $var25042403 n'existe pas. " --title "Fichier inexistant" 8 78

		fi
		echo "----------"
		sleep 10
	done
		rm -f "$var25052101" 																																		# Suppression du fichier temporaire	
}

fct005() {
############ Arrêt de tous les environnements ###############

	clear
	# Utilisation du fichier $var25052101 pour l'arrêt des environnements
	cd ~ || exit
	for ligne in $(<"$var25052101"); do
		echo -e "${turquoise}" $var25042301 Arrêt de "$ligne". "${reset}"																							# Affichage de la session d'arrêt
		export var25042404=/etc/init.d/$ligne.sh																													# Initialisation de la variable de commande
		if [ -e "$var25042404" ]; then
			chmod +x "$var25042404"																																	# On rend exécutable le script d'arrêt
			$var25042404 stop																																		# Commande d'arrêt de l'environnement
			echo "$var25042404" stop																																# Affichage de la commande pour information
		else
			echo -e "${rougegras}" $var25042301 Le script "$var25042404" n"'"existe pas. "${reset}"																	# Message d'erreur si le script d'arrêt n'existe pas
			NEWT_COLORS=${alert[*]} whiptail --msgbox "$var25042301 Le script $var25042404 n'existe pas. " --title "Fichier inexistant" 8 78

		fi
		echo "----------"
		sleep 10
	done
		rm -f "$var25052101" 																																		# Suppression du fichier temporaire	
}

fct006() {
############ Htop ###############

	rm -f "$var25052101" 																																			# Suppression du fichier temporaire	
	htop																																							# Commande htop pour affichage des processus
}

fct007() {
############ Création de l'environnement ###############

	cd / || exit

	var25051201=$(NEWT_COLORS=${info[*]} whiptail --inputbox "$var25070203 : Entrez le nom de l'environnement" 10 60 3>&1 1>&2 2>&3)								# Initialisation de la variable d'environnement 

		fct104

	# Type d'environnement

		var25062401=$(NEWT_COLORS=${info[*]} whiptail --menu "$var25070203 : Sélection du type d'environnement ?" 25 60 15 \
			"fct100" "    Springboot" \
			"fct101" "    Python" \
			"fct102" "    Node JS" \
			3>&1 1>&2 2>&3)

		exitstatus=$?
		if [ $exitstatus = 0 ]; then
			$var25062401																																			# Lancement de la fonction choisie
		fi	
}

fct008(){
######## Démarrage du service Haproxy #####################

	systemctl start haproxy
	NEWT_COLORS=${info[*]} whiptail --msgbox "$var25070203 : Démarrage du service Haproxy effectué." 10 60 															# Message d'information de fin d'installation des utilitaires Linux	
	fct996
}
fct009(){
######## Arrêt du service Haproxy #########################

	systemctl stop haproxy
	NEWT_COLORS=${info[*]} whiptail --msgbox "$var25070203 : Arrêt du service Haproxy effectué." 10 60 																# Message d'information de fin d'installation des utilitaires Linux		
	fct996
}
fct010(){
######## Rechargement de la configuration Haproxy #########

	systemctl reload haproxy
	NEWT_COLORS=${info[*]} whiptail --msgbox "$var25070203 : Rechargement de la configuration Haproxy effectué." 10 60 												# Message d'information de fin d'installation des utilitaires Linux		
	fct996
}
fct011(){
######## Vérification de la configuration Haproxy #########

clear
export var25062701
var25062701=$(haproxy -f /etc/haproxy/haproxy.cfg -c 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
#if [ "$var25062701" = "Configuration file is valid" ]; then
	NEWT_COLORS=${info[*]} whiptail --msgbox "$var25070203 : Le fichier de configuration est valide !" --title "Fichier valide" 8 55
	clear
	else
	NEWT_COLORS=${alert[*]} whiptail --msgbox "$var25062701" --title "Fichier non valide" 30 150
fi
fct996

}
fct012(){
######## Statut du service Haproxy ########################

	hatop -s /var/run/haproxy/admin.sock
}

fct013(){
######## Statut du service Haproxy ########################

	apt-get install haproxy hatop rsyslog socat
}



###########################################################
fct100() {
	# Création de l' arborescence Springboot	

	if (NEWT_COLORS=${info[*]} whiptail --yesno "$var25070203 : Création de l'arborescence Springboot ?" 8 78); then												# Création de l'arborescence Springboot ? OUI/NON
	mkdir /home/"$var25051201"/deploy-logs
	mkdir /home/"$var25051201"/logs-apache
	mkdir /home/"$var25051201"/www
	mkdir -p /home/"$var25051201"/applis/api/conf/backup
	mkdir -p /home/"$var25051201"/applis/api/logs
	mkdir -p /home/"$var25051201"/applis/api/scripts
	touch /home/"$var25051201"/deploy.sh
	chmod +x /home/"$var25051201"/deploy.sh
	touch /home/"$var25051201"/applis/api/scripts/start.sh
	touch /home/"$var25051201"/applis/api/scripts/stop.sh
	chmod +x /home/"$var25051201"/applis/api/scripts/start.sh
	chmod +x /home/"$var25051201"/applis/api/scripts/stop.sh
	chown -R "$var25051201": /home/"$var25051201"

		# Création du script init
			if (NEWT_COLORS=${info[*]} whiptail --yesno "$var25070203 : Création du script init ?" 8 78); then														# Création du script de démarrage ? OUI/NON
		fct103
		fi

	# Configuration Apache
		if (NEWT_COLORS=${info[*]} whiptail --yesno "$var25070203 : Création du fichier Apache ?" 8 78); then														# Création du fichier de configuration Apache ? OUI/NON
		fct105																																						# Création du fichier vierge date-environnement.conf
		fi

	# Création du fichier logrotate dans /etc/apache2/logrotate
		if (NEWT_COLORS=${info[*]} whiptail --yesno "$var25070203 : Création du fichier logrotate ?" 8 78); then													# Création du fichier logrotate ? OUI/NON
		fct106
		fi

		if (NEWT_COLORS=${info[*]} whiptail --yesno "$var25070203 : Création lien Java ?" 8 78); then																# Création du lien JDK ? OUI/NON
		fct107
		fi
	
	rm -f "$var25052101" 																																			# Suppression du fichier temporaire	
		NEWT_COLORS=${info[*]} whiptail --msgbox "$var25070203 : Création de l'environnement terminée." 10 60 														# Message d'information de fin de création de l'environnement
	fi
}

###########################################################
fct101() {
	# Création de l' arborescence Python	

	if (NEWT_COLORS=${info[*]} whiptail --yesno "$var25070203 : Création de l'arborescence Python ?" 8 78); then													# Création de l'arborescence Python ? OUI/NON
	mkdir /home/"$var25051201"/deploy-logs
	mkdir /home/"$var25051201"/www
	mkdir /home/"$var25051201"/www/logs-gunicorn
	chown -R "$var25051201": /home/"$var25051201"
	touch /etc/systemd/system/"$var25051201".service

	# Création du Service
	echo "création du Service"																																		# Message d'information
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

	usermod -aG sudo "$var25051201"
	
	rm -f "$var25052101" 																																			# Suppression du fichier temporaire	
		NEWT_COLORS=${info[*]} whiptail --msgbox "$var25070203 : Création de l'environnement terminée." 10 60 														# Message d'information de fin de création de l'environnement
	fi
}

##########################################################
fct102() {
	# Création de l' arborescence Node JS	

	if (NEWT_COLORS=${info[*]} whiptail --yesno "$var25070203 : Création de l'arborescence Node JS ?" 8 78); then													# Création de l'arborescence Node JS ? OUI/NON
	mkdir /home/"$var25051201"/deploy-logs
	mkdir /home/"$var25051201"/logs-apache
	mkdir /home/"$var25051201"/www
	chown -R "$var25051201": /home/"$var25051201"

	# Configuration Apache
		if (NEWT_COLORS=${info[*]} whiptail --yesno "$var25070203 : Création du fichier Apache ?" 8 78); then														# Création du fichier de configuration Apache ? OUI/NON
		fct105																																						# Création du fichier vierge date-environnement.conf
		fi

	# Création du fichier logrotate dans /etc/apache2/logrotate
		if (NEWT_COLORS=${info[*]} whiptail --yesno "$var25070203 : Création du fichier logrotate ?" 8 78); then													# Création du fichier logrotate ? OUI/NON
		fct106
		fi
	
	rm -f "$var25052101" 																																			# Suppression du fichier temporaire	
		NEWT_COLORS=${info[*]} whiptail --msgbox "$var25070203 : Création de l'environnement terminée." 10 60 														# Message d'information de fin de création de l'environnement
	fi
}

##########################################################
fct103() {
	# Création du fichier init

		touch /etc/init.d/"$var25051201".sh																															# Création du fichier vierge "environnement.sh"
		chmod +x /etc/init.d/"$var25051201".sh																														# On rend exécutable le script

		echo "création du script init.d"																															# Message d'information
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
fct104() {
	# Création de l'environnement

	echo "$var25051201"																																				# Affichage du nom de l'environnement
	useradd -s /bin/bash -m "$var25051201"																															# Commande de création de l'environnement
	passwd "$var25051201"	# Définition du mot de passe de l'environnement
	chmod 755 /home/"$var25051201"
}

##########################################################
fct105() {
	# Création du fichier vierge Apache

		touch /etc/apache2/sites-available/"$var24051101"-"$var25051201".conf																						# Création du fichier vierge date-environnement.conf


############# Gestion d'Apache ############################

		var25070302=$(NEWT_COLORS=${info[*]} whiptail --inputbox "$var25070203 : URL ? ( URL.integration.groupeherve.com )" 10 60 3>&1 1>&2 2>&3)					# Initialisation de la variable du JDK


		var25070303=$(NEWT_COLORS=${info[*]} whiptail --inputbox "$var25070203 : Port AJP ?" 10 60 3>&1 1>&2 2>&3)													# Initialisation de la variable du JDK


		var25070304=$(NEWT_COLORS=${info[*]} whiptail --menu "$var25070203 : Type d'environnement ?" 25 60 15 \
			"fct401" "    Integration" \
			"fct402" "    Recette" \
			"fct403" "    Production" \
			3>&1 1>&2 2>&3)
			
		exitstatus=$?
		if [ $exitstatus = 0 ]; then
			$var25070304																																			# Lancement de la fonction choisie
		fi

}

##########################################################
fct106() {
	# Création du fichier logrotate

		touch /etc/apache2/"$var25051201".cfg																														# Création du fichier vierge logrotate

		echo "création du fichier logrotate"																														# Message d'information 
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
fct107() {
	# Création du lien Java

	var25052203=$(NEWT_COLORS=${info[*]} whiptail --inputbox "$var25070203 : Entrez la version du JDK" 10 60 3>&1 1>&2 2>&3)										# Initialisation de la variable du JDK
	cd /usr/java || exit

		if [ -d "$var25052203" ]; then																																# Vérification de la présence du JDK
			#echo "Le dossier $var25052203 existe."
			ln -s "$var25052203" java-"$var25051201"																												# Création du lien JDK
		else
			#echo "La version $var25052203 n'est pas présente sur le serveur. "
			NEWT_COLORS=${alert[*]} whiptail --msgbox "$var25070203 : La version $var25052203 n'est pas présente sur le serveur. " 10 60   							# Message d'alerte concernant le JDK
		fi

}

##########################################################
fct200() {
	# Installation des utilitaires Linux

	apt-get update
	apt-get install build-essential linux-headers-"$(uname -r)"
	apt-get install net-tools htop curl dos2unix tcpdump git shellcheck rsync -y
	
	NEWT_COLORS=${info[*]} whiptail --msgbox "$var25070203 : Installation des utilitaires terminée." 10 60 															# Message d'information de fin d'installation des utilitaires Linux

}

##########################################################
fct300() {
	# Test de la configuration Apache

	clear
	export var25070202
	var25070202=$(apachectl configtest 3>&1 1>&2 2>&3)
		exitstatus=$?
#		if [ $exitstatus = 0 ]; then
		if [ "$var25070202" = "Syntax OK" ]; then
		NEWT_COLORS=${info[*]} whiptail --msgbox "$var25070203 : La configuration est valide !" --title "Configuration valide" 8 55
		clear
		else
		NEWT_COLORS=${alert[*]} whiptail --msgbox "$var25070202" --title "Configuration non valide" 30 150
		fi
	fct993
	
}

fct301() {
	# application de la configuration Apache

	apachectl graceful
	NEWT_COLORS=${info[*]} whiptail --msgbox "$var25070203 : Rechargement de la configuration Apache effectuée." 10 60 												# Message d'information de fin d'installation des utilitaires Linux
	fct993
	
}

##########################################################
fct401() {
	# Configuration Apache Integration

	# Création du fichier environnement.conf
	tee /etc/apache2/sites-available/"$var24051101"-"$var25051201".conf <<EOF
	<VirtualHost *:80>

			ServerName $var25070302.integration.lan.groupeherve.com

			ErrorLog /home/$var25051201/logs-apache/error_lan_com.log
			CustomLog /home/$var25051201/logs-apache/access_lan_com.log combined

			Redirect permanent / https://$var25070302.integration.lan.groupeherve.com/

	</VirtualHost>

	<VirtualHost *:80>

			ServerName $var25070302.integration.groupeherve.com

			ErrorLog /home/$var25051201/logs-apache/error_com.log
			CustomLog /home/$var25051201/logs-apache/access_com.log combined

			Redirect permanent / https://$var25070302.integration.groupeherve.com/

	</VirtualHost>



	<VirtualHost *:443>

			SSLEngine on
			SSLHonorCipherOrder on

			SSLCertificateFile    /etc/apache2/certifs/wildcard.integration.lan.groupeherve.com/wildcard.integration.lan.groupeherve.com.crt
			SSLCertificateKeyFile /etc/apache2/certifs/wildcard.integration.lan.groupeherve.com/wildcard.integration.lan.groupeherve.com.key
			SSLCertificateChainFile  /etc/apache2/certifs/wildcard.integration.lan.groupeherve.com/GandiRSADomainValidationSecureServerCA3.pem

			# configuration du SSL
			SSLCipherSuite "EECDH+ECDSA+AESGCM EECDH+aRSA+AESGCM EECDH+ECDSA+SHA384 EECDH+ECDSA+SHA256 EECDH+aRSA+SHA384 EECDH+aRSA+SHA256 EECDH+aRSA+RC4 EECDH EDH+aRSA RC4 !aNULL !eNULL !LOW !3DES !MD5 !EXP !PSK !SRP !DSS !RC4"

			SSLProtocol all -SSLv2 -SSLv3

			ServerName $var25070302.integration.lan.groupeherve.com

		DocumentRoot /home/$var25051201/applis

			DirectoryIndex index.htm index.html default.htm default.html

			ErrorLog /home/$var25051201/logs-apache/error_lan_com.log
			CustomLog /home/$var25051201/logs-apache/access_lan_com.log combined

			ProxyPass  "/" "ajp://127.0.0.1:$var25070303/"
			ProxyPreserveHost On
	#        Proxypass "/" "http://127.0.0.1:8104/"

			<Directory /home/$var25051201/applis/>
					Options Includes FollowSymLinks
					Require all granted
			</Directory>

	</VirtualHost>

	<VirtualHost *:443>

			SSLEngine on
			SSLHonorCipherOrder on

			SSLCertificateFile    /etc/apache2/certifs/wildcard.integration.groupeherve.com/wildcard.integration.groupeherve.com.crt
			SSLCertificateKeyFile /etc/apache2/certifs/wildcard.integration.groupeherve.com/wildcard.integration.groupeherve.com.key
			SSLCertificateChainFile  /etc/apache2/certifs/wildcard.integration.groupeherve.com/GandiRSADomainValidationSecureServerCA3.pem

			# configuration du SSL
			SSLCipherSuite "EECDH+ECDSA+AESGCM EECDH+aRSA+AESGCM EECDH+ECDSA+SHA384 EECDH+ECDSA+SHA256 EECDH+aRSA+SHA384 EECDH+aRSA+SHA256 EECDH+aRSA+RC4 EECDH EDH+aRSA RC4 !aNULL !eNULL !LOW !3DES !MD5 !EXP !PSK !SRP !DSS !RC4"

			SSLProtocol all -SSLv2 -SSLv3

			ServerName $var25070302.integration.groupeherve.com

		DocumentRoot /home/$var25051201/applis

			DirectoryIndex index.htm index.html default.htm default.html

			ErrorLog /home/$var25051201/logs-apache/error_com.log
			CustomLog /home/$var25051201/logs-apache/access_com.log combined

			ProxyPass  "/" "ajp://127.0.0.1:$var25070303/"
			ProxyPreserveHost On
	#        Proxypass "/" "http://127.0.0.1:8104/"

			<Directory /home/$var25051201/applis/>
					Options Includes FollowSymLinks
					Require all granted
			</Directory>

	</VirtualHost>
EOF

# Création du lien dans /etc/apache2/sites-enabled
	cd /etc/apache2/sites-enabled || exit
	ln -s ../sites-available/"$var24051101"-"$var25051201".conf /etc/apache2/sites-enabled/"$var24051101"-"$var25051201".conf

}

##########################################################
fct402() {
	# Configuration Apache Recette

	# Création du fichier environnement.conf
	tee /etc/apache2/sites-available/"$var24051101"-"$var25051201".conf <<EOF
	<VirtualHost *:80>

			ServerName $var25070302.recette.lan.groupeherve.com

			ErrorLog /home/$var25051201/logs-apache/error_lan_com.log
			CustomLog /home/$var25051201/logs-apache/access_lan_com.log combined

			Redirect permanent / https://$var25070302.recette.lan.groupeherve.com/

	</VirtualHost>

	<VirtualHost *:80>

			ServerName $var25070302.recette.groupeherve.com

			ErrorLog /home/$var25051201/logs-apache/error_com.log
			CustomLog /home/$var25051201/logs-apache/access_com.log combined

			Redirect permanent / https://$var25070302.recette.groupeherve.com/

	</VirtualHost>



	<VirtualHost *:443>

			SSLEngine on
			SSLHonorCipherOrder on

			SSLCertificateFile    /etc/apache2/certifs/wildcard.recette.lan.groupeherve.com/wildcard.recette.lan.groupeherve.com.crt
			SSLCertificateKeyFile /etc/apache2/certifs/wildcard.recette.lan.groupeherve.com/wildcard.recette.lan.groupeherve.com.key
			SSLCertificateChainFile  /etc/apache2/certifs/wildcard.recette.lan.groupeherve.com/GandiRSADomainValidationSecureServerCA3.pem

			# configuration du SSL
			SSLCipherSuite "EECDH+ECDSA+AESGCM EECDH+aRSA+AESGCM EECDH+ECDSA+SHA384 EECDH+ECDSA+SHA256 EECDH+aRSA+SHA384 EECDH+aRSA+SHA256 EECDH+aRSA+RC4 EECDH EDH+aRSA RC4 !aNULL !eNULL !LOW !3DES !MD5 !EXP !PSK !SRP !DSS !RC4"

			SSLProtocol all -SSLv2 -SSLv3

			ServerName $var25070302.recette.lan.groupeherve.com

		DocumentRoot /home/$var25051201/applis

			DirectoryIndex index.htm index.html default.htm default.html

			ErrorLog /home/$var25051201/logs-apache/error_lan_com.log
			CustomLog /home/$var25051201/logs-apache/access_lan_com.log combined

			ProxyPass  "/" "ajp://127.0.0.1:$var25070303/"
			ProxyPreserveHost On
	#        Proxypass "/" "http://127.0.0.1:8104/"

			<Directory /home/$var25051201/applis/>
					Options Includes FollowSymLinks
					Require all granted
			</Directory>

	</VirtualHost>

	<VirtualHost *:443>

			SSLEngine on
			SSLHonorCipherOrder on

			SSLCertificateFile    /etc/apache2/certifs/wildcard.recette.groupeherve.com/wildcard.recette.groupeherve.com.crt
			SSLCertificateKeyFile /etc/apache2/certifs/wildcard.recette.groupeherve.com/wildcard.recette.groupeherve.com.key
			SSLCertificateChainFile  /etc/apache2/certifs/wildcard.recette.groupeherve.com/GandiRSADomainValidationSecureServerCA3.pem

			# configuration du SSL
			SSLCipherSuite "EECDH+ECDSA+AESGCM EECDH+aRSA+AESGCM EECDH+ECDSA+SHA384 EECDH+ECDSA+SHA256 EECDH+aRSA+SHA384 EECDH+aRSA+SHA256 EECDH+aRSA+RC4 EECDH EDH+aRSA RC4 !aNULL !eNULL !LOW !3DES !MD5 !EXP !PSK !SRP !DSS !RC4"

			SSLProtocol all -SSLv2 -SSLv3

			ServerName $var25070302.recette.groupeherve.com

		DocumentRoot /home/$var25051201/applis

			DirectoryIndex index.htm index.html default.htm default.html

			ErrorLog /home/$var25051201/logs-apache/error_com.log
			CustomLog /home/$var25051201/logs-apache/access_com.log combined

			ProxyPass  "/" "ajp://127.0.0.1:$var25070303/"
			ProxyPreserveHost On
	#        Proxypass "/" "http://127.0.0.1:8104/"

			<Directory /home/$var25051201/applis/>
					Options Includes FollowSymLinks
					Require all granted
			</Directory>

	</VirtualHost>
EOF

# Création du lien dans /etc/apache2/sites-enabled
	cd /etc/apache2/sites-enabled || exit
	ln -s ../sites-available/"$var24051101"-"$var25051201".conf /etc/apache2/sites-enabled/"$var24051101"-"$var25051201".conf

}

##########################################################
fct403() {
	# Configuration Apache Production

	# Création du fichier environnement.conf
	tee /etc/apache2/sites-available/"$var24051101"-"$var25051201".conf <<EOF
	<VirtualHost *:80>

			ServerName $var25070302.production.lan.groupeherve.com

			ErrorLog /home/$var25051201/logs-apache/error_lan_com.log
			CustomLog /home/$var25051201/logs-apache/access_lan_com.log combined

			Redirect permanent / https://$var25070302.production.lan.groupeherve.com/

	</VirtualHost>

	<VirtualHost *:80>

			ServerName $var25070302.production.groupeherve.com

			ErrorLog /home/$var25051201/logs-apache/error_com.log
			CustomLog /home/$var25051201/logs-apache/access_com.log combined

			Redirect permanent / https://$var25070302.production.groupeherve.com/

	</VirtualHost>



	<VirtualHost *:443>

			SSLEngine on
			SSLHonorCipherOrder on

			SSLCertificateFile    /etc/apache2/certifs/wildcard.production.lan.groupeherve.com/wildcard.production.lan.groupeherve.com.crt
			SSLCertificateKeyFile /etc/apache2/certifs/wildcard.production.lan.groupeherve.com/wildcard.production.lan.groupeherve.com.key
			SSLCertificateChainFile  /etc/apache2/certifs/wildcard.production.lan.groupeherve.com/GandiRSADomainValidationSecureServerCA3.pem

			# configuration du SSL
			SSLCipherSuite "EECDH+ECDSA+AESGCM EECDH+aRSA+AESGCM EECDH+ECDSA+SHA384 EECDH+ECDSA+SHA256 EECDH+aRSA+SHA384 EECDH+aRSA+SHA256 EECDH+aRSA+RC4 EECDH EDH+aRSA RC4 !aNULL !eNULL !LOW !3DES !MD5 !EXP !PSK !SRP !DSS !RC4"

			SSLProtocol all -SSLv2 -SSLv3

			ServerName $var25070302.production.lan.groupeherve.com

		DocumentRoot /home/$var25051201/applis

			DirectoryIndex index.htm index.html default.htm default.html

			ErrorLog /home/$var25051201/logs-apache/error_lan_com.log
			CustomLog /home/$var25051201/logs-apache/access_lan_com.log combined

			ProxyPass  "/" "ajp://127.0.0.1:$var25070303/"
			ProxyPreserveHost On
	#        Proxypass "/" "http://127.0.0.1:8104/"

			<Directory /home/$var25051201/applis/>
					Options Includes FollowSymLinks
					Require all granted
			</Directory>

	</VirtualHost>

	<VirtualHost *:443>

			SSLEngine on
			SSLHonorCipherOrder on

			SSLCertificateFile    /etc/apache2/certifs/wildcard.production.groupeherve.com/wildcard.production.groupeherve.com.crt
			SSLCertificateKeyFile /etc/apache2/certifs/wildcard.production.groupeherve.com/wildcard.production.groupeherve.com.key
			SSLCertificateChainFile  /etc/apache2/certifs/wildcard.production.groupeherve.com/GandiRSADomainValidationSecureServerCA3.pem

			# configuration du SSL
			SSLCipherSuite "EECDH+ECDSA+AESGCM EECDH+aRSA+AESGCM EECDH+ECDSA+SHA384 EECDH+ECDSA+SHA256 EECDH+aRSA+SHA384 EECDH+aRSA+SHA256 EECDH+aRSA+RC4 EECDH EDH+aRSA RC4 !aNULL !eNULL !LOW !3DES !MD5 !EXP !PSK !SRP !DSS !RC4"

			SSLProtocol all -SSLv2 -SSLv3

			ServerName $var25070302.production.groupeherve.com

		DocumentRoot /home/$var25051201/applis

			DirectoryIndex index.htm index.html default.htm default.html

			ErrorLog /home/$var25051201/logs-apache/error_com.log
			CustomLog /home/$var25051201/logs-apache/access_com.log combined

			ProxyPass  "/" "ajp://127.0.0.1:$var25070303/"
			ProxyPreserveHost On
	#        Proxypass "/" "http://127.0.0.1:8104/"

			<Directory /home/$var25051201/applis/>
					Options Includes FollowSymLinks
					Require all granted
			</Directory>

	</VirtualHost>
EOF

# Création du lien dans /etc/apache2/sites-enabled
	cd /etc/apache2/sites-enabled || exit
	ln -s ../sites-available/"$var24051101"-"$var25051201".conf /etc/apache2/sites-enabled/"$var24051101"-"$var25051201".conf

}


##########################################################
###########################################################################
## Les Interfaces graphiques
fct993() {
############# Gestion d'Apache ############################
		var25070201=$(NEWT_COLORS=${info[*]} whiptail --menu "$var25070203 : Que souhaitez vous faire ?" 25 60 15 \
			"fct300" "    Test de la configuration Apache" \
			"fct301" "    Application de la configuration Apache" \
			"fct105" "    Création d'un environnement Apache" \
			"fct006" "    Htop" \
			3>&1 1>&2 2>&3)
			
		exitstatus=$?
		if [ $exitstatus = 0 ]; then
			$var25070201																																			# Lancement de la fonction choisie
		else
			fct995
		fi

}

fct994() {
############# Gestion de Linux ############################
		var25070101=$(NEWT_COLORS=${info[*]} whiptail --menu "$var25070203 : Que souhaitez vous faire ?" 25 60 15 \
			"fct200" "    Installation des utilitaires Linux" \
			"fct006" "    Htop" \
			3>&1 1>&2 2>&3)
			
		exitstatus=$?
		if [ $exitstatus = 0 ]; then
			$var25070101																																			# Lancement de la fonction choisie
		else
			fct995
		fi

}

fct995() {
############# Sélection de l'action à exécuter ############################

		var25062504=$(NEWT_COLORS=${info[*]} whiptail --menu "$var25070203 : Que souhaitez vous faire ?" 25 60 15 \
			"fct997" "    Gestion des environnements" \
			"fct006" "    Htop" \
			"fct996" "    Gestion de Haproxy" \
			"fct994" "    Gestion de Linux" \
			"fct993" "    Gestion d'Apache" \
			3>&1 1>&2 2>&3)

		exitstatus=$?
		if [ $exitstatus = 0 ]; then
			$var25062504																																			# Lancement de la fonction choisie
		else
			fct999
		fi
#########################################################
}
fct996() {
######## Menu de Gestion de Haproxy ########################

		var25062502=$(NEWT_COLORS=${info[*]} whiptail --menu "$var25070203 : Que souhaitez vous faire ?" 25 60 15 \
			"fct008" "    Démarrer le service Haproxy" \
			"fct009" "    Stopper le service Haproxy" \
			"fct010" "    Rechargement Haproxy" \
			"fct011" "    Vérification de la configuration Haproxy" \
			"fct012" "    Statut du service Haproxy" \
			"fct013" "    Installation du service Haproxy" \
			3>&1 1>&2 2>&3)

		exitstatus=$?
		if [ $exitstatus = 0 ]; then
			$var25062502																																			# Lancement de la fonction choisie
		else
			fct995
		fi
}
fct997() {
######## Menu de Gestion des environnements ########################

		var25062503=$(NEWT_COLORS=${info[*]} whiptail --menu "$var25070203 : Que souhaitez vous faire ?" 25 60 15 \
			"fct001" "    Démarrer un environnement" \
			"fct002" "    Stopper un environnement" \
			"fct003" "    Logs d' un environnement" \
			"fct004" "    Démarrer tous les environnements" \
			"fct005" "    Arrêter tous les environnements" \
			"fct007" "    Création d'un environnement" \
			3>&1 1>&2 2>&3)

		exitstatus=$?
		if [ $exitstatus = 0 ]; then
			$var25062503																																			# Lancement de la fonction choisie
		else
			fct995
		fi
}
############# Choix de l'environnement ############################
fct998() {
		var25052104=$(NEWT_COLORS=${info[*]} whiptail --menu "$var25070203 : Choisissez un environnement :" 30 60 20 "${node_list[@]}" 3>&1 1>&2 2>&3)				# Initialisation de la variable d'environnement
}

############# Fin du script ############################
fct999() {
	rm -f "$var25052101"																																			# Suppression du fichier temporaire
	echo "(◕_◕) : That's all folks !"																																# Information de fin d'exécution du script
}

#### The Ultimate Software ! ####

fct995

## That's all