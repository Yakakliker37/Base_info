#!/bin/bash

## Les variables
: ${VAR01=whiptail}
: ${url=}



fct001(){

yt-dlp -x --audio-format mp3 $url

}

#####################################################


############################################################
if ($VAR01 --title "Download" --yesno "Souhaitez-vous télécharger une chanson ?" 10 60) then

url=$($VAR01 --title "URL" --inputbox "Entrez l'URL" 10 60 3>&1 1>&2 2>&3)

exitstatus=$?
		if [ $exitstatus = 0 ]; then


fct001

fi

else
    echo "vous avez annulé"
fi


#########################################################

## Fin du script

