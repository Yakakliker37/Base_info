#!/bin/bash

# --- CONFIGURATION ---
# Remplace 'groupeherve-npm' par le nom exact de ton dépôt npm dans Nexus 3
REPO_NAME="groupeherve-npm"
NEXUS_REST_URL="http://localhost:8081/service/rest/v1/components?repository=$REPO_NAME"
USER="admin"
PASS="c-y/CufqAw;fcP/H"
# Le dossier où se trouvent tes fichiers @imdeo, etc.
SOURCE_DIR="/mnt/sdb/groupeherve-npm"

cd "$SOURCE_DIR" || { echo "Dossier source introuvable"; exit 1; }

echo "Démarrage de l'importation NPM vers $REPO_NAME..."

# On cherche tous les fichiers .tgz récursivement
find . -type f -name "*.tgz" | while read -r file; do
    
    echo "------------------------------------------------"
    echo "Traitement de : $file"
    
    # Envoi via l'API REST Components (format multipart)
    # On utilise -w pour récupérer le code HTTP
    response=$(curl -u "$USER:$PASS" -s -o /dev/null -w "%{http_code}" \
        -X POST "$NEXUS_REST_URL" \
        -H "accept: application/json" \
        -H "Content-Type: multipart/form-data" \
        -F "npm.asset=@$file")

    if [ "$response" == "204" ] || [ "$response" == "200" ]; then
        echo "SUCCÈS (Code $response) : Paquet importé."
        # Optionnel : rm "$file" si tu veux libérer de l'espace immédiatement
    else
        echo "ERREUR (Code $response) : Échec de l'import pour $file"
        # On affiche le détail de l'erreur si besoin
        curl -u "$USER:$PASS" -X POST "$NEXUS_REST_URL" \
             -H "accept: application/json" \
             -H "Content-Type: multipart/form-data" \
             -F "npm.asset=@$file"
    fi
done

echo "------------------------------------------------"
echo "Migration NPM terminée."