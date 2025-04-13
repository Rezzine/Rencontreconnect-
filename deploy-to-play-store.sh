#!/bin/bash

# Script d'automatisation pour déployer directement sur Google Play Store
# Nécessite le CLI Google Play Developer et une configuration appropriée

echo "🚀 Démarrage du déploiement vers Google Play Store..."

# Vérifier les variables d'environnement requises
if [ -z "$ANDROID_KEYSTORE_PATH" ] || [ -z "$ANDROID_KEYSTORE_PASSWORD" ] || [ -z "$ANDROID_KEY_ALIAS" ] || [ -z "$ANDROID_KEY_PASSWORD" ]; then
  echo "❌ Erreur: Variables d'environnement manquantes pour la signature"
  echo "Veuillez définir les variables suivantes:"
  echo "- ANDROID_KEYSTORE_PATH: Chemin vers votre keystore"
  echo "- ANDROID_KEYSTORE_PASSWORD: Mot de passe du keystore"
  echo "- ANDROID_KEY_ALIAS: Alias de la clé"
  echo "- ANDROID_KEY_PASSWORD: Mot de passe de la clé"
  exit 1
fi

if [ -z "$PLAY_STORE_CREDENTIALS" ]; then
  echo "❌ Erreur: Fichier d'authentification Google Play manquant"
  echo "Veuillez définir la variable PLAY_STORE_CREDENTIALS pointant vers votre fichier JSON de compte de service"
  exit 1
fi

# Étape 1: Construction de l'application
echo "📦 Construction de l'application web..."
npm run build

# Étape 2: Synchronisation avec Capacitor
echo "🔄 Synchronisation avec Capacitor..."
npx cap sync android

# Étape 3: Mise à jour de la version (à adapter selon vos besoins)
echo "📝 Mise à jour de la version..."
VERSION_CODE=$(grep -o 'versionCode [0-9]*' android/app/build.gradle | awk '{print $2}')
NEW_VERSION_CODE=$((VERSION_CODE + 1))
VERSION_NAME=$(grep -o 'versionName "[^"]*"' android/app/build.gradle | cut -d'"' -f2)

echo "  Version actuelle: $VERSION_NAME (code: $VERSION_CODE)"
echo "  Nouvelle version: $VERSION_NAME (code: $NEW_VERSION_CODE)"

# Mise à jour du versionCode dans build.gradle
sed -i "s/versionCode $VERSION_CODE/versionCode $NEW_VERSION_CODE/g" android/app/build.gradle

# Étape 4: Construction du bundle AAB
echo "🔨 Construction du bundle Android..."
cd android
./gradlew bundle

# Vérification que le bundle a été créé avec succès
if [ ! -f "app/build/outputs/bundle/release/app-release.aab" ]; then
  echo "❌ Erreur: La construction du bundle a échoué"
  exit 1
fi

# Étape 5: Publication sur Google Play Store
echo "🚀 Publication sur Google Play Store..."
echo "  Utilisation du compte de service pour l'authentification..."

# Vérification de l'installation de l'outil Bundletool
if ! command -v bundletool &> /dev/null; then
  echo "⚠️ Bundletool n'est pas installé. Installation..."
  # Télécharger et installer bundletool (à adapter selon votre système)
  wget -q https://github.com/google/bundletool/releases/download/1.14.0/bundletool-all-1.14.0.jar -O /tmp/bundletool.jar
  echo "java -jar /tmp/bundletool.jar \$@" > /tmp/bundletool
  chmod +x /tmp/bundletool
  BUNDLETOOL="/tmp/bundletool"
else
  BUNDLETOOL="bundletool"
fi

# Publication avec le Google Play Developer API (à adapter selon votre configuration)
echo "  Téléchargement du bundle vers Google Play Console..."
java -jar /path/to/google-play-cli.jar upload \
  --credentials "$PLAY_STORE_CREDENTIALS" \
  --package "io.replit.datingapp" \
  --track "internal" \
  --bundle "app/build/outputs/bundle/release/app-release.aab" \
  --release-notes "fr-FR=Nouvelle version de l'application avec corrections de bugs et améliorations de performance."

# Retour au répertoire principal
cd ..

echo "✅ Processus de déploiement terminé!"
echo ""
echo "⚠️ Important: Ce script est fourni à titre indicatif et nécessite:"
echo "  1. L'outil Google Play Developer API CLI configuré"
echo "  2. Un compte de service avec les autorisations appropriées"
echo "  3. L'application déjà créée dans Google Play Console"
echo ""
echo "Consultez https://developers.google.com/android-publisher pour plus d'informations"