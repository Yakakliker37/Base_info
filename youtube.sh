#!/bin/bash

## Les variables
: ${VAR01=whiptail}
: ${url=}



fct001(){

url=$($VAR01 --title "URL" --inputbox "Entrez l'URL" 10 60 3>&1 1>&2 2>&3)

yt-dlp -x --audio-format m4a $url

fct999

}

fct002(){

url=$($VAR01 --title "URL" --inputbox "Entrez l'URL" 10 60 3>&1 1>&2 2>&3)

yt-dlp -x --audio-format m4a $url --no-playlist

fct999

}

#####################################################


fct995() {
############# Sélection de l'action à exécuter ############################

		var25062504=$(NEWT_COLORS=${info[*]} whiptail --menu "$var25070203 : Que souhaitez vous faire ?" 25 60 15 \
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