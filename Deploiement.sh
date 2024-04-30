#!/bin/bash
## Les variables
export VAR01="whiptail"
export VAR02="001.sh"

export red="\033[31m"
export turquoise="\033[36m"
export bleue="\033[34m"
export jaune="\033[33m"
export vert="\033[32m"
export gras="\033[1m"
export souligne="\033[4m"
export clignotant="\033[5m"
export reset="\033[0m"
export rougegrasclignotant="\033[31;1;5m"
export turquoisegras="\033[36;1m"
export vertgras="\033[32;1m"
export jaunegras="\033[33;1m"

export travail="./temp/"
export tomcatapi="./Springboot/tomcatAPI/"
export tomcat="./Tomcat/tomcatXX/"
export apache2api="./Springboot/apache2/"
export apache2="./Tomcat/apache2/"
export demarrageapi="./Springboot/init.d/"
export demarrage="./Tomcat/init.d/"
export rotationapi="./Springboot/logrotate.d/"
export rotation="./Tomcat/logrotate.d/"
export log="./Deploiement.log"

## Fonction pour le mot de passe sudo
fct001() {
	echo $PASSWORD
}

############################################################
fct103(){

if whiptail --yesno "SpringBoot API ?" 0 0; then
  fct003
fi
}

#####################################################
## Deploiement SpringBoot API
fct003(){

fct100

#PASSWORD=$($VAR01 --title "Mot de passe Sudo" --passwordbox "Entrez votre mot de passe Sudo" 10 60 3>&1 1>&2 2>&3)
VAR05=$($VAR01 --title "Adresse IP" --inputbox "Entrez l'adresse IP ou le nom du Srv" 10 60 3>&1 1>&2 2>&3)
#VAR06=$($VAR01 --title "User" --inputbox "Entrez le nom d'utilisateur" 10 60 3>&1 1>&2 2>&3)
#VAR09=$($VAR01 --title "Password" --passwordbox "Entrez le mot de passe utilisateur" 10 60 3>&1 1>&2 2>&3)
VAR08=$($VAR01 --title "Passroot" --passwordbox "Entrez le mot de passe root de connexion" 10 60 3>&1 1>&2 2>&3)
VAR07=$($VAR01 --title "Dossier" --inputbox "Entrez le nom de l'instance Tomcat" 10 60 3>&1 1>&2 2>&3)
#VAR11=$($VAR01 --title "Dossier" --inputbox "Entrez le server port Tomcat" 10 60 3>&1 1>&2 2>&3)
#VAR12=$($VAR01 --title "Dossier" --inputbox "Entrez le port AJP Tomcat" 10 60 3>&1 1>&2 2>&3)
VAR14=$($VAR01 --title "URL" --inputbox "Host souhaité dans l'URL" 10 60 3>&1 1>&2 2>&3)
VAR15=$($VAR01 --title "Java" --inputbox "Version du JDK" 10 60 3>&1 1>&2 2>&3)

if $VAR01 --title "Récapitulatif" --yesno "Type de déploiement : $versionint " 8 78; then
echo "Type de déploiement "$versionint" validé" >> $log
else
echo "Type de déploiement "$versionint" refusé" >> $log
 fct008
fi

if $VAR01 --title "Récapitulatif" --yesno "Adresse ou Nom du serveur : $VAR05 " 8 78; then
echo "Adresse ou Nom du serveur "$VAR05" validé" >> $log
else
echo "Adresse ou Nom du serveur "$VAR05" refusé" >> $log
 fct008
fi

if $VAR01 --title "Récapitulatif" --yesno "Instance Tomcat : $VAR07 " 8 78; then
echo "Instance Tomcat "$VAR07" validée" >> $log
else
echo "Instance Tomcat "$VAR07" refusée" >> $log
 fct008
fi

if $VAR01 --title "Récapitulatif" --yesno "URL : $VAR14 " 8 78; then
echo "URL "$VAR14" validée" >> $log
else
echo "URL "$VAR14" refusée" >> $log
 fct008
fi

if $VAR01 --title "Récapitulatif" --yesno "Version du JDK : $VAR15 " 8 78; then
echo "Version du JDK "$VAR15" validée" >> $log
else
echo "Version du JDK "$VAR15" refusée" >> $log
 fct008
fi


#####################################################
#Préparation locale de la configuration
clear
rm -rf $log
export SSHPASS=$VAR08
echo "${turquoisegras}Test d'accès au serveur " $VAR05 "$reset"
echo "Test d'accès au serveur " $VAR05 >> $log
#IP="8.8.8.8" # Replace with the IP address you want to ping
COUNT=1 # Number of ping attempts
 
if ping -c $COUNT $VAR05 > /dev/null 2>&1; then
  echo "\t${vertgras}Le serveur "$VAR05" est bien accessible.""$reset"
  echo "\tLe serveur "$VAR05" est bien accessible." >> $log

else
  echo "\t${rougegrasclignotant}Attention ! Le serveur "$VAR05" ne répond pas.""$reset"
  echo "\tAttention ! Le serveur "$VAR05" ne répond pas." >> $log
  fct008
fi

echo "${turquoisegras}Echange des cles avec le serveur distant""$reset"
echo "Echange des cles avec le serveur distant" >> $log
ssh-copy-id root@$VAR05 >> $log 2>&1

echo "${turquoisegras}Création des dossiers de travail""$reset"
echo "Création des dossiers de travail" >> $log
mkdir -p ./temp >> $log 2>&1
mkdir -p ./temp/$VAR07/$VAR07 >> $log 2>&1
mkdir -p ./temp/$VAR07/apache2 >> $log 2>&1
mkdir -p ./temp/$VAR07/java >> $log 2>&1
mkdir -p ./temp/$VAR07/init.d >> $log 2>&1
mkdir -p ./temp/$VAR07/logrotate.d >> $log 2>&1
mkdir -p ./temp/$VAR07/java/$VAR15 >> $log 2>&1

mkdir ./temp-sites >> $log 2>&1
chmod 777 ./temp-sites >> $log 2>&1
rm -rf ./temp-sites/* >> $log 2>&1

mkdir ./temp-java >> $log 2>&1
chmod 777 ./temp-java >> $log 2>&1
rm -rf ./temp-java/* >> $log 2>&1

rsync -r $tomcatapi ./temp/$VAR07/$VAR07 >> $log 2>&1
rsync -r $apache2api ./temp/$VAR07/apache2 >> $log 2>&1
rsync -r $demarrageapi ./temp/$VAR07/init.d >> $log 2>&1
rsync -r $rotationapi ./temp/$VAR07/logrotate.d >> $log 2>&1

# modification des fichiers start.sh & stop.sh
echo "${turquoisegras}Modification des fichiers start.sh & stop.sh""$reset"
echo "Modification des fichiers start.sh & stop.sh" >> $log
sed -i 's|XXX|'"$VAR07"'|g' ./temp/$VAR07/$VAR07/applis/api/scripts/* >> $log 2>&1

#Création d'un dossier temporaire pour le nommage du fichier conf Apache -- Dossier de récupération des conf existantes
echo "${turquoisegras}Configuration du serveur Apache""$reset"
echo "Configuration du serveur Apache" >> $log
#Connexion au serveur Apache et récupération des fichiers conf Apache existants
echo "\t${jaunegras}-Récupération des fichiers conf existants sur le serveur Apache" $VAR05 "$reset"
echo "\t-Récupération des fichiers conf existants sur le serveur Apache" $VAR05 >> $log
sshpass -e scp root@$VAR05:/etc/apache2/sites-available/* ./temp-sites/ >> $log 2>&1

## Boucle de test pour déterminer le nommage du fichier conf
echo "\t${jaunegras}-Analyse des noms des fichiers""$reset"
echo "\t-Analyse des noms des fichiers" >> $log
i=1
var=00$i

ls ./temp-sites/$var*.conf 2>&1 > /dev/null >> $log 2>&1

status=$?

while [ $status -eq 0 ];
do
#echo $status
i=$(( i + 1 ))
var=00$i
ls ./temp-sites/$var*.conf 2>&1 > /dev/null >> $log 2>&1
status=$?

done

echo "\t${jaunegras}-Création du fichier conf" $var-$VAR07".conf Apache""$reset"
echo "\t-Création du fichier conf" $var-$VAR07".conf Apache" >> $log
mv ./temp/$VAR07/apache2/sites-available/001-default.conf ./temp/$VAR07/apache2/sites-available/$var-$VAR07.conf >> $log 2>&1

# Configuration du fichier conf Apache 
echo "\t${jaunegras}-Configuration du fichier" $var-$VAR07".conf Apache""$reset"
echo "\t-Configuration du fichier" $var-$VAR07".conf Apache" >> $log
sed -i 's|XXX|'"$VAR07"'|g' ./temp/$VAR07/apache2/sites-available/* >> $log 2>&1
sed -i 's|YYY|'"$VAR14"'|g' ./temp/$VAR07/apache2/sites-available/* >> $log 2>&1
sed -i 's|ZZZ|'"$versionint"'|g' ./temp/$VAR07/apache2/sites-available/* >> $log 2>&1

echo "\t${jaunegras}-Création du lien dynamique vers "$var-$VAR07".conf""$reset"
echo "\t-Création du lien dynamique vers "$var-$VAR07".conf" >> $log
cd ./temp/$VAR07/apache2/sites-enabled/ >> $log 2>&1
ln -s ../sites-available/$var-$VAR07.conf $var-$VAR07.conf >> $log 2>&1
cd ..
cd ..
cd ..
cd ..
  

echo "${turquoisegras}Fin de la configuration Apache""$reset"
echo "Fin de la configuration Apache" >> $log

echo "${turquoisegras}Configuration Java""$reset"
echo "Configuration Java" >> $log
varjava='java-'$VAR07
echo "\t${jaunegras}-Création du lien dynamique "$varjava "$reset"
echo "\t-Création du lien dynamique "$varjava >> $log
cd ./temp/$VAR07/java/ >> $log 2>&1
ln -s $VAR15 $varjava >> $log 2>&1
cd ..
cd ..
cd ..

echo "${turquoisegras}Fin de la configuration Java""$reset"
echo "Fin de la configuration Java" >> $log


echo "${turquoisegras}Configuration Init.d""$reset"
echo "Configuration Init.d" >> $log

sed -i 's|XXX|'"$VAR07"'|g' ./temp/$VAR07/init.d/*
mv ./temp/$VAR07/init.d/demarrageAPI.sh ./temp/$VAR07/init.d/$VAR07.sh >> $log 2>&1
chmod +x ./temp/$VAR07/init.d/$VAR07.sh >> $log 2>&1

echo "${turquoisegras}Configuration Logrotate""$reset"
echo "Configuration Logrotate" >> $log

sed -i 's|XXX|'"$VAR07"'|g' ./temp/$VAR07/logrotate.d/*
mv ./temp/$VAR07/logrotate.d/logrotate ./temp/$VAR07/logrotate.d/$VAR07 >> $log 2>&1

echo "${turquoisegras}Transfert de la configuration vers le serveur de destination "$VAR05 "$reset"
echo "Transfert de la configuration vers le serveur de destination "$VAR05 >> $log
echo "\t${jaunegras}-Creation de l'instance""$reset"
echo "\t-Creation de l'instance" >> $log
sshpass -e ssh root@$VAR05 useradd -s /bin/bash -m $VAR07 >> $log 2>&1
echo "\t${jaunegras}-Transfert de l'arborescence "$VAR07 "$reset"
echo "\t-Transfert de l'arborescence "$VAR07 >> $log
sshpass -e rsync ./temp/$VAR07/$VAR07/* root@$VAR05:/home/$VAR07/ -av --progress -e ssh >> $log 2>&1
echo "\t${jaunegras}-Transfert de l'arborescence Apache2""$reset"
echo "\t-Transfert de l'arborescence Apache2" >> $log
sshpass -e rsync ./temp/$VAR07/apache2/* root@$VAR05:/etc/apache2/ -av --progress -e ssh >> $log 2>&1
echo "\t${jaunegras}-Transfert du lien Java""$reset"
echo "\t-Transfert du lien Java" >> $log
sshpass -e rsync ./temp/$VAR07/java/$varjava root@$VAR05:/usr/java/ -av --progress -e ssh >> $log 2>&1
echo "\t${jaunegras}-Transfert du script Init.d""$reset"
echo "\t-Transfert du script Init.d" >> $log
sshpass -e rsync ./temp/$VAR07/init.d/* root@$VAR05:/etc/init.d/ -av --progress -e ssh >> $log 2>&1
echo "\t${jaunegras}-Transfert du script Logrotate""$reset"
echo "\t-Transfert du script Logrotate" >> $log
sshpass -e rsync ./temp/$VAR07/logrotate.d/* root@$VAR05:/etc/logrotate/ -av --progress -e ssh >> $log 2>&1
echo "\t${jaunegras}-Modification des droits dans le dossier Home" $VAR07 "$reset"
echo "\t-Modification des droits dans le dossier Home" $VAR07 >> $log
sshpass -e ssh root@$VAR05 'chown -R' $VAR07: /home/$VAR07/ >> $log 2>&1

# Nettoyage de l'installation
rm -rf ./temp-sites >> $log 2>&1
rm -rf ./temp-java >> $log 2>&1
rm -rf ./temp >> $log 2>&1
echo "${vertgras}----------------------------------------------------------""$reset"
echo "${vertgras}  -----------------------------------------------------""$reset"
echo "${vertgras}    -------------------------------------------------""$reset"
echo "${vertgras}                Fin de la configuration""$reset"
echo "                Fin de la configuration" >> $log
echo " "
echo "\t${rougegrasclignotant}Penser à vérifier et appliquer la configuration Apache et lancer l'api Tomcat""$reset"

}
#####################################################
## Deploiement Tomcat
fct004(){

fct100

#PASSWORD=$($VAR01 --title "Mot de passe Sudo" --passwordbox "Entrez votre mot de passe Sudo" 10 60 3>&1 1>&2 2>&3)
VAR05=$($VAR01 --title "Adresse IP" --inputbox "Entrez l'adresse IP ou le nom du Srv" 10 60 3>&1 1>&2 2>&3)
#VAR06=$($VAR01 --title "User" --inputbox "Entrez le nom d'utilisateur" 10 60 3>&1 1>&2 2>&3)
#VAR09=$($VAR01 --title "Password" --passwordbox "Entrez le mot de passe utilisateur" 10 60 3>&1 1>&2 2>&3)
VAR08=$($VAR01 --title "Passroot" --passwordbox "Entrez le mot de passe root de connexion" 10 60 3>&1 1>&2 2>&3)
VAR07=$($VAR01 --title "Dossier" --inputbox "Entrez le nom de l'instance Tomcat" 10 60 3>&1 1>&2 2>&3)
#VAR11=$($VAR01 --title "Dossier" --inputbox "Entrez le server port Tomcat" 10 60 3>&1 1>&2 2>&3)
#VAR12=$($VAR01 --title "Dossier" --inputbox "Entrez le port AJP Tomcat" 10 60 3>&1 1>&2 2>&3)
VAR14=$($VAR01 --title "URL" --inputbox "Host souhaité dans l'URL" 10 60 3>&1 1>&2 2>&3)
VAR15=$($VAR01 --title "Java" --inputbox "Version du JDK" 10 60 3>&1 1>&2 2>&3)

if $VAR01 --title "Récapitulatif" --yesno "Type de déploiement : $versionint " 8 78; then
echo "Type de déploiement "$versionint" validé" >> $log
else
echo "Type de déploiement "$versionint" refusé" >> $log
 fct008
fi

if $VAR01 --title "Récapitulatif" --yesno "Adresse ou Nom du serveur : $VAR05 " 8 78; then
echo "Adresse ou Nom du serveur "$VAR05" validé" >> $log
else
echo "Adresse ou Nom du serveur "$VAR05" refusé" >> $log
 fct008
fi

if $VAR01 --title "Récapitulatif" --yesno "Instance Tomcat : $VAR07 " 8 78; then
echo "Instance Tomcat "$VAR07" validée" >> $log
else
echo "Instance Tomcat "$VAR07" refusée" >> $log
 fct008
fi

if $VAR01 --title "Récapitulatif" --yesno "URL : $VAR14 " 8 78; then
echo "URL "$VAR14" validée" >> $log
else
echo "URL "$VAR14" refusée" >> $log
 fct008
fi

if $VAR01 --title "Récapitulatif" --yesno "Version du JDK : $VAR15 " 8 78; then
echo "Version du JDK "$VAR15" validée" >> $log
else
echo "Version du JDK "$VAR15" refusée" >> $log
 fct008
fi

#####################################################
#Préparation locale de la configuration
clear
rm -rf $log
export SSHPASS=$VAR08
echo "${turquoisegras}Test d'accès au serveur" $VAR05 "$reset"
echo "Test d'accès au serveur" $VAR05 >> $log
#IP="8.8.8.8" # Replace with the IP address you want to ping
COUNT=1 # Number of ping attempts
 
if ping -c $COUNT $VAR05 > /dev/null 2>&1; then
  echo "\t${vertgras}Le serveur "$VAR05" est bien accessible.""$reset"
  echo "\tLe serveur "$VAR05" est bien accessible." >> $log
else
  echo "\t${rougegrasclignotant}Attention ! Le serveur "$VAR05" ne répond pas.""$reset"
  echo "\tAttention ! Le serveur '$VAR05' ne répond pas." >> $log
fct008
fi

echo "${turquoisegras}Echange des cles avec le serveur distant""$reset"
echo "Echange des cles avec le serveur distant" >> $log
ssh-copy-id root@$VAR05 >> $log 2>&1

echo "${turquoisegras}Création des dossiers de travail""$reset"
echo "Création des dossiers de travail" >> $log
mkdir -p ./temp >> $log 2>&1
mkdir -p ./temp/$VAR07/$VAR07 >> $log 2>&1
mkdir -p ./temp/$VAR07/apache2 >> $log 2>&1
mkdir -p ./temp/$VAR07/java >> $log 2>&1
mkdir -p ./temp/$VAR07/java/$VAR15 >> $log 2>&1
mkdir -p ./temp/$VAR07/init.d >> $log 2>&1
mkdir -p ./temp/$VAR07/logrotate.d >> $log 2>&1

mkdir ./temp-sites >> $log 2>&1
chmod 777 ./temp-sites >> $log 2>&1
rm -rf ./temp-sites/* >> $log 2>&1

mkdir ./temp-java >> $log 2>&1
chmod 777 ./temp-java >> $log 2>&1
rm -rf ./temp-java/* >> $log 2>&1

echo "${turquoisegras}Synchronisation du dossier home "$VAR07 "$reset"
echo "Synchronisation du dossier home "$VAR07 >> $log
rsync -r $tomcat ./temp/$VAR07/$VAR07 >> $log 2>&1
rsync -r $apache2 ./temp/$VAR07/apache2 >> $log 2>&1
rsync -r $demarrage ./temp/$VAR07/init.d >> $log 2>&1
rsync -r $rotation ./temp/$VAR07/logrotate.d >> $log 2>&1

echo "${turquoisegras}Configuration Java""$reset"
echo "Configuration Java" >> $log
varjava='java-'$VAR07
echo "\t${jaunegras}-Création du lien dynamique "$varjava "$reset"
echo "\t-Création du lien dynamique "$varjava >> $log
cd ./temp/$VAR07/java/ >> $log 2>&1
ln -s $VAR15 $varjava >> $log 2>&1
cd ..
cd ..
cd ..

echo "${turquoisegras}Fin de la configuration Java""$reset"
echo "Fin de la configuration Java" >> $log

# Configuration des scripts ./temp/$VAR07/$VAR07/tomcat/bin/*.sh
file001=./temp/$VAR07/$VAR07/tomcat/bin/* 
echo "\t${jaunegras}-Configuration des fichiers "$file001 "$reset"
echo "\t-Configuration des fichiers "$file001 >> $log
sed -i 's|XXX|'"$VAR07"'|g' $file001 >> $log 2>&1

#Création d'un dossier temporaire pour le nommage du fichier conf Apache -- Dossier de récupération des conf existantes
echo "${turquoisegras}Configuration du serveur Apache""$reset"
echo "Configuration du serveur Apache" >> $log
#Connexion au serveur Apache et récupération des fichiers conf Apache existants
echo "\t${jaunegras}-Récupération des fichiers conf existants sur le serveur Apache" $VAR05 "$reset"
echo "\t-Récupération des fichiers conf existants sur le serveur Apache" $VAR05 >> $log
sshpass -e scp root@$VAR05:/etc/apache2/sites-available/* ./temp-sites/ >> $log 2>&1

## Boucle de test pour déterminer le nommage du fichier conf
echo "\t${jaunegras}-Analyse des noms des fichiers""$reset"
echo "\t-Analyse des noms des fichiers" >> $log
i=1
var=00$i

ls ./temp-sites/$var*.conf 2>&1 > /dev/null >> $log 2>&1

status=$?

while [ $status -eq 0 ];
do
#echo $status
i=$(( i + 1 ))
var=00$i
ls ./temp-sites/$var*.conf 2>&1 > /dev/null >> $log 2>&1
status=$?
#echo $status
done

echo "\t${jaunegras}-Création du fichier conf" $var-$VAR07".conf Apache""$reset"
echo "\t-Création du fichier conf" $var-$VAR07".conf Apache" >> $log
mv ./temp/$VAR07/apache2/sites-available/001-default.conf ./temp/$VAR07/apache2/sites-available/$var-$VAR07.conf >> $log 2>&1

# Configuration du fichier conf Apache 
echo "\t${jaunegras}-Configuration du fichier" $var-$VAR07".conf Apache""$reset"
echo "\t-Configuration du fichier" $var-$VAR07".conf Apache" >> $log
sed -i 's|XXX|'"$VAR07"'|g' ./temp/$VAR07/apache2/sites-available/* >> $log 2>&1
sed -i 's|YYY|'"$VAR14"'|g' ./temp/$VAR07/apache2/sites-available/* >> $log 2>&1
sed -i 's|ZZZ|'"$versionint"'|g' ./temp/$VAR07/apache2/sites-available/* >> $log 2>&1

echo "\t${jaunegras}-Création du lien dynamique vers "$var-$VAR07".conf""$reset"
echo "\t-Création du lien dynamique vers "$var-$VAR07".conf" >> $log
cd ./temp/$VAR07/apache2/sites-enabled/ >> $log 2>&1
ln -s ../sites-available/$var-$VAR07.conf $var-$VAR07.conf >> $log 2>&1
cd ..
cd ..
cd ..
cd ..
  

echo "${turquoisegras}Fin de la configuration Apache""$reset"
echo "Fin de la configuration Apache" >> $log

echo "${turquoisegras}Configuration Logrotate""$reset"
echo "Configuration Logrotate" >> $log
sed -i 's|XXX|'"$VAR07"'|g' ./temp/$VAR07/logrotate.d/* >> $log 2>&1
mv ./temp/$VAR07/logrotate.d/logrotate ./temp/$VAR07/logrotate.d/$VAR07 >> $log 2>&1

echo "${turquoisegras}Configuration Init.d""$reset"
echo "Configuration Init.d" >> $log
sed -i 's|XXX|'"$VAR07"'|g' ./temp/$VAR07/init.d/*
mv ./temp/$VAR07/init.d/demarrageAPI.sh ./temp/$VAR07/init.d/$VAR07.sh >> $log 2>&1
chmod +x ./temp/$VAR07/init.d/$VAR07.sh >> $log 2>&1

echo "${turquoisegras}Transfert de la configuration vers le serveur de destination "$VAR05 "$reset"
echo "Transfert de la configuration vers le serveur de destination "$VAR05 >> $log
echo "\t${jaunegras}-Creation de l'instance""$reset"
echo "\t-Creation de l'instance" >> $log
sshpass -e ssh root@$VAR05 useradd -s /bin/bash -m $VAR07 >> $log 2>&1
echo "\t${jaunegras}-Transfert de l'arborescence "$VAR07 "$reset"
echo "\t-Transfert de l'arborescence "$VAR07 >> $log
sshpass -e rsync ./temp/$VAR07/$VAR07/* root@$VAR05:/home/$VAR07/ -av --progress -e ssh >> $log 2>&1
echo "\t${jaunegras}-Transfert de l'arborescence Apache2""$reset"
echo "\t-Transfert de l'arborescence Apache2" >> $log
sshpass -e rsync ./temp/$VAR07/apache2/* root@$VAR05:/etc/apache2/ -av --progress -e ssh >> $log 2>&1
echo "\t${jaunegras}-Transfert du lien Java""$reset"
echo "\t-Transfert du lien Java" >> $log
sshpass -e rsync ./temp/$VAR07/java/$varjava root@$VAR05:/usr/java/ -av --progress -e ssh >> $log 2>&1
echo "\t${jaunegras}-Transfert du script Init.d""$reset"
echo "\t-Transfert du script Init.d" >> $log
sshpass -e rsync ./temp/$VAR07/init.d/* root@$VAR05:/etc/init.d/ -av --progress -e ssh >> $log 2>&1
echo "\t${jaunegras}-Transfert du script Logrotate""$reset"
echo "\t-Transfert du script Logrotate" >> $log
sshpass -e rsync ./temp/$VAR07/logrotate.d/* root@$VAR05:/etc/logrotate/ -av --progress -e ssh >> $log 2>&1
echo "\t${jaunegras}-Modification des droits dans le dossier Home" $VAR07 "$reset"
echo "\t-Modification des droits dans le dossier Home" $VAR07 >> $log
sshpass -e ssh root@$VAR05 'chown -R' $VAR07: /home/$VAR07/ >> $log 2>&1


# Nettoyage de l'installation
rm -rf ./temp-sites >> $log 2>&1
rm -rf ./temp-java >> $log 2>&1
rm -rf ./temp >> $log 2>&1
echo "${vertgras}----------------------------------------------------------""$reset"
echo "${vertgras}  -----------------------------------------------------""$reset"
echo "${vertgras}    -------------------------------------------------""$reset"
echo "${vertgras}                Fin de la configuration""$reset"
echo "                Fin de la configuration" >> $log
echo " "
echo "${rougegrasclignotant}Penser à vérifier et appliquer la configuration Apache et lancer l'api Tomcat""$reset"
echo "\t\t${rougegrasclignotant}Penser à configurer Apache sur le Proxy""$reset"

}
############################################################
fct100(){
OPTION=$(whiptail --title "Deploiement" --menu "Type de déploiement ?" 15 60 6 \
"fct101" "Intégration" \
"fct102" "Recette" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
$OPTION
else
#    echo "vous avez annulé"
fct008
fi
}

###########################################################
fct101(){

export versionint="integration"
echo "Integration." >> $log 2>&1
}
###########################################################
fct102(){

export versionint="recette"
echo "Recette" >> $log 2>&1
}

###########################################################
fct008(){

echo "Sortie du script prématurée !" >> $log
exit $?

}
############################################################
if (whiptail --title "Deploiement" --yesno "Continuer ?" 8 78); then


OPTION=$(whiptail --title "Deploiement" --menu "Que souhaitez vous faire ?" 15 60 6 \
"fct003" "    Deploiement SpringBoot API Int" \
"fct004" "    Deploiement Tomcat Int" \
"fct008" "    Quitter le script" 3>&1 1>&2 2>&3)
 
 
exitstatus=$?
if [ $exitstatus = 0 ]; then
#    echo "Vous avez choisi la distribution : " $OPTION
$OPTION

else
fct008
fi

#########################################################

else
	echo "Fin."
exit $?
fi


