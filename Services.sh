#!/bin/bash
# Version PRY20250410-b
#
# Ce script liste les environnements présents sur le serveur
# Il propose l'arrêt, le démarrage de chacun des environnements ainsi que de tous les environnements
# Il propose aussi de visualiser les logs de démarrage (nohup.out) de chaque environnement
#
#

# Actions préalables
clear
rm ~/env.txt
mkdir ~/tmp
rm -rf ~/tmp/*

# Fichiers à exclure de la liste des environnements
export rem001=imdeo
export rem002=montages

# Création du fichier avec la liste des environnements présents
cd /home
for env00 in *; do
echo $env00 >> ~/env.txt
done

# Suppression des environnements exclus
sed -i "/$rem001/d" ~/env.txt
sed -i "/$rem002/d" ~/env.txt

# Création d'un fichier par environnements présents
cd /home
for env00 in *; do
echo $env00 > ~/tmp/$env00
done

# Suppression des environnements exclus
rm -rf ~/tmp/$rem001
rm -rf ~/tmp/$rem002

## Les variables
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

# Création d'un fichier par environnements présents
cd /home
for env00 in *; do
echo $env00 > ~/tmp/$env00
done

# Suppression des environnements exclus
rm -rf ~/tmp/$rem001
rm -rf ~/tmp/$rem002

cd ~/tmp
for f in *;
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
/etc/init.d/$environnement.sh start
#echo $environnement
}
############ Arrêt de l'environnement ###############
fct002(){
fct998
/etc/init.d/$environnement.sh stop
#echo $environnement
}
############ Affichage des logs de l'environnement ###############
fct003(){
fct998
clear
tail -f /home/$environnement/nohup.out
}
############ Démarrage de tous les environnements ###############
fct004(){
clear
# Utilisation du fichier env.txt pour le démarrage des environnements
cd ~
for ligne in $(<env.txt)
do
echo Démarrage de $ligne
/etc/init.d/$ligne.sh start
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
echo Arrêt de $ligne
/etc/init.d/$ligne.sh stop
echo "----------"
sleep 15
done
}

############# Choix de l'environnement ############################
fct998(){
environnement=$(whiptail --menu "(◕_◕) : Choisissez un environnement :" 30 60 20 \
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
