#!/bin/bash
# Version PRY20250424-b
#
# Ce script liste les environnements présents sur le serveur
# Il propose l'arrêt ou le démarrage de chacun des environnements ainsi que de tous les environnements
# Il propose aussi de visualiser les logs de démarrage (nohup.out ou catalina.out) de chaque environnement
#
#

############ Actions préalables
clear
export var25042302="~/env.txt"
if [ -e "$var25042302" ]; then
    rm ~/env.txt
else
    echo Ok
fi




############ Fichiers à exclure de la liste des environnements
export rem001=imdeo
export rem002=montages

############ Création du fichier avec la liste des environnements présents
cd /home
for env00 in *; do
echo $env00 >> ~/env.txt
done

############ Suppression des environnements exclus
sed -i "/$rem001/d" ~/env.txt
sed -i "/$rem002/d" ~/env.txt

############ Les variables
export env0=""
export env1=""
export env2=""
export env3=""
export env4=""
export env5=""
export env6=""
export env7=""
export env8=""
export env9=""
export env10=""
export env11=""
export env12=""
export env13=""
export env14=""
export env15=""
export env16=""
export env17=""
export selection="(◕_◕)"
export var25042301="(°_°)"

# Variables couleurs
export red="\033[31m"
export turquoise="\033[36m"
export gras="\033[1m"
export rougegras="\033[1;31m"
export reset="\033[0m"

############ Création de la liste des environnements
cd ~
i="0"
for f in $(<env.txt)
do
var='env'
var001="${var}${i}"

export $var001=$f
let "i++"

done


## Les fonctions

############ Démarrage de l'environnement ###############
fct001(){
fct998
export var25042401="/etc/init.d/"$environnement".sh"
if [ -e "$var25042401" ]; then
	$var25042401 start
	#echo $var25042401 start
else
    echo -e "${rougegras}"$var25042301" Le script "$var25042401" n'existe pas""$reset"
fi
}
############ Arrêt de l'environnement ###############
fct002(){
fct998
export var25042401="/etc/init.d/"$environnement".sh"
if [ -e "$var25042401" ]; then
	$var25042401 stop
	#echo $var25042401 stop
else
    echo -e "${rougegras}"$var25042301" Le script "$var25042401" n'existe pas""$reset"
fi
}
############ Affichage des logs de l'environnement ###############
fct003(){
fct998
clear
#echo $environnement

export catalina="/home/"$environnement"/tomcat/logs/catalina.out"
export nohup="/home/"$environnement"/nohup.out"

# Test pour vérifier quel fichier log existe
if [ -e "$catalina" ]; then
    tail -f $catalina
else
if [ -e "$nohup" ]; then
	tail -f $nohup
else
	echo -e "${rougegras}"$var25042301" Impossible d'afficher les logs""$reset"
fi
fi
}

############ Démarrage de tous les environnements ###############
fct004(){
clear
# Utilisation du fichier env.txt pour le démarrage des environnements
cd ~
for ligne in $(<env.txt)
do
echo -e "${turquoise}"$var25042301" Démarrage de "$ligne"$reset"
export var25042403="/etc/init.d/"$ligne".sh"
if [ -e "$var25042403" ]; then
	$var25042403 start
	#echo $var25042403 start
else
    echo -e "${rougegras}"$var25042301" Le script "$var25042403" n'existe pas""$reset"
fi
echo "----------"
sleep 15
done
}
############ Arrêt de tous les environnements ###############
fct005(){
clear
# Utilisation du fichier env.txt pour le démarrage des environnements
cd ~
for ligne in $(<env.txt)
do
echo -e "${turquoise}"$var25042301" Arrêt de "$ligne"$reset"
export var25042404="/etc/init.d/"$ligne".sh"
if [ -e "$var25042404" ]; then
	$var25042404 stop
	#echo $var25042404 stop
else
    echo -e "${rougegras}"$var25042301" Le script "$var25042404" n'existe pas""$reset"
fi
echo "----------"
sleep 15
done
}

############# Choix de l'environnement ############################
fct998(){
environnement=$(whiptail --menu "(◕_◕) : Choisissez un environnement :" 30 60 20 \
"$env0" "" \
"$env1" "" \
"$env2" "" \
"$env3" "" \
"$env4" "" \
"$env5" "" \
"$env6" "" \
"$env7" "" \
"$env8" "" \
"$env9" "" \
"$env10" "" \
"$env11" "" \
"$env12" "" \
"$env13" "" \
"$env14" "" \
"$env15" "" \
"$env16" "" \
"$env17" "" \
3>&1 1>&2 2>&3)
}

############# Fin du script ############################
fct999(){
echo "(◕_◕) : That's all folks !"
}

## L'Interface

############# Sélection de l'action à exécuter ############################
if (whiptail --title "Environnements API" --yesno "(◕_◕) : Continuer ?" 8 78); then

#fct998
exitstatus=$?
if [ $exitstatus = 0 ]; then

OPTION=$(whiptail --title "Environnements API" --menu "(◕_◕) : Que souhaitez vous faire ?" 20 60 10 \
"fct001" "    Démarrer un environnement" \
"fct002" "    Stopper un environnement" \
"fct003" "    Logs d' un environnement" \
"fct004" "    Démarrer tous les environnements" \
"fct005" "    Arrêter tous les environnements" \
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
