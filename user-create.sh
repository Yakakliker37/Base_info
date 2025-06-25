#!/bin/bash

cd / || exit
var25051201=$(whiptail --inputbox "Entrez le nom de l'environnement" 10 60 3>&1 1>&2 2>&3)								# Initialisation de la variable d'environnement 
fct104


##########################################################
# Fonction Création d'un utilisateur
fct104() {
	echo "$var25051201"																							# Affichage du nom de l'environnement
	useradd -s /bin/bash -m "$var25051201"																					# Commande de création de l'environnement
	passwd "$var25051201"																							# Définition du mot de passe de l'environnement
}

