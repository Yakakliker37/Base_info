#!/bin/bash
# Version PRY-251127
#
# Partage de clé SSH
#

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

	
## Les fonctions


	var25112701=$(NEWT_COLORS=${info[*]} whiptail --inputbox "$var25070203 : Serveur distant" 10 60 3>&1 1>&2 2>&3)						
	var25112702=$(NEWT_COLORS=${info[*]} whiptail --inputbox "$var25070203 : Compte utilisateur" 10 60 3>&1 1>&2 2>&3)	

ssh-copy-id $var25112702@$var25112701

	echo "(◕_◕) : That's all folks !"																																# Information de fin d'exécution du script
