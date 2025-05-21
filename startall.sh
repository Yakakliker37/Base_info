#!/bin/bash
# Version PRY-25052101
#
# Ce script permet de démarrer l'ensemble des environnements présents sur le serveur dans la mesure ou il existe un script dans /etc/init.d
#

############ Actions préalables
cd ~ || exit
export var25052101
var25052101=$(mktemp)  																									# Création du fichier temporaire
clear

############ Profils  à exclure de la liste des environnements
export rem001=imdeo
export rem002=montages
export rem003=prtg

############ Création du fichier avec la liste des environnements présents
cd /home || exit
for env00 in *; do
	echo "$env00" >> "$var25052101"																						# Alimentation du fichier avec la liste des environnements du système
done

############ Suppression des environnements exclus
sed -i "/$rem001/d" "$var25052101"
sed -i "/$rem002/d" "$var25052101"
sed -i "/$rem003/d" "$var25052101"

############ Les variables
export selection="(◕_◕)"
export var25042301="(°_°)"

export var24051101
var24051101=$(date +%y%m%d)																								# Variable date année-mois-jour


# Variables couleurs --- Pour faire sympa
export red="\033[31m"																									# Rouge
export turquoise="\033[36m"																								# Turquoise
export gras="\033[1m"																									# Gras
export rougegras="\033[1;31m"																							# Rouge Gras
export reset="\033[0m"																									# Réinitialisation

############ Création de la liste des environnements présents
cd ~ || exit
node_list=()
for f in $(<"$var25052101"); do
	node_list[${#node_list[@]}]=$f
	node_list[${#node_list[@]}]=""
done

## Les fonctions
############ Démarrage de tous les environnements ###############

	# Utilisation du fichier $var25052101 pour le démarrage des environnements
	cd ~ || exit
	for ligne in $(<"$var25052101"); do
		echo -e "${turquoise}" $var25042301 Démarrage de "$ligne". "${reset}"											# Affichage de la session de démarrage
		export var25042403=/etc/init.d/$ligne.sh																		# Initialisation de la variable de commande
		if [ -e "$var25042403" ]; then
			chmod +x "$var25042403"																						# On rend exécutable le script de démarrage
			$var25042403 start																							# Commande de démarrage de l'environnement
			echo "$var25042403" start																					# Affichage de la commande pour information
		else
			echo -e "${rougegras}" $var25042301 Le script "$var25042403" n"'"existe pas. "${reset}" 					# Message d'erreur si le script de démarrage n'existe pas
		fi
		echo "----------"
		sleep 10
	done
		rm -f "$var25052101" 																							# Suppression du fichier temporaire	

