#!/bin/bash

## Les variables
: ${VAR01=whiptail}
: ${url=}

############ Les variables
export selection="(◕_◕)"
export var25042301="(°_°)"
export var25070203="°(◕_◕)°"
export ver="PRY.260108"

export var24051101
var24051101=$(date +%y%m%d)																																			# Variable date année-mois-jour


# Variables couleurs --- Pour faire sympa --- Oh la belle bleue !
export red="\033[31m"																																				# Rouge
export turquoise="\033[36m"																																			# Turquoise
export gras="\033[1m"																																				# Gras
export rougegras="\033[1;31m"																																		# Rouge Gras
export reset="\033[0m"	

export alert="root=,red;window=,white;border=black,white;textbox=black,white;button=red,white"
export info="root=,blue;window=,white;border=black,white;textbox=black,white;button=red,white"

	



fct001(){

url=$(NEWT_COLORS="$info" whiptail --title "$ver" --inputbox "Entrez l'URL" 10 60 3>&1 1>&2 2>&3)

yt-dlp -x --audio-format m4a $url

fct999

}

fct002(){

url=$(NEWT_COLORS="$info" whiptail --title "$ver" --inputbox "Entrez l'URL" 10 60 3>&1 1>&2 2>&3)

yt-dlp -x --audio-format m4a $url --no-playlist

fct999

}

#####################################################


fct995() {
############# Sélection de l'action à exécuter ############################

		var25062504=$(NEWT_COLORS="$info" whiptail --menu "$var25070203 : Que souhaitez vous faire ?" --title "$ver" 25 60 15 \
			"fct001" "    Télécharger une playlist" \
			"fct002" "    Télécharger une chanson" \
			3>&1 1>&2 2>&3)

		exitstatus=$?
		if [ $exitstatus = 0 ]; then
			$var25062504																																			# Lancement de la fonction choisie
		else
			fct999
		fi
}
#########################################################


############# Fin du script ############################
fct999() {
	echo "(◕_◕) : That's all folks !"																																# Information de fin d'exécution du script
}

#### The Ultimate Software ! ####

fct995

## That's all