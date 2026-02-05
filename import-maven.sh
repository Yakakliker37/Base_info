#!/bin/bash

# Configuration
NEXUS_URL="http://172.31.252.37:8081/repository/groupeherve-releases/"
USER="admin"
PASS="c-y/CufqAw;fcP/H"
SOURCE_DIR="/mnt/sdb/groupeherve-releases"

cd "$SOURCE_DIR"

# On cherche tous les fichiers (sauf les index et les checksums que Nexus recalcule)
find . -type f -not -name "maven-metadata.xml*" -not -name "*.md5" -not -name "*.sha1" | while read -r file; do
    # On enlève le "./" au début du chemin
    target_path="${file#./}"
    
    echo "Envoi de : $target_path"
    
    # Envoi via CURL (très rapide en local)
curl -u "$USER:$PASS" --upload-file "$file" "$NEXUS_URL$target_path"
done