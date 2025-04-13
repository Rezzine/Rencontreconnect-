#!/bin/bash

# Script pour configurer Capacitor et l'application Android

echo "🚀 Configuration de l'application pour Android..."

# Installation des dépendances si nécessaire
# npm install

# Construction de l'application web
echo "📦 Construction de l'application web..."
npm run build

# Vérification de la configuration Capacitor
if [ ! -f "capacitor.config.ts" ]; then
  echo "⚠️ Fichier capacitor.config.ts non trouvé. Création..."
  # La configuration sera générée lors de l'initialisation
fi

# Initialisation de Capacitor si nécessaire
if [ ! -d "android" ]; then
  echo "🔧 Initialisation de Capacitor..."
  npx cap init DatingApp io.replit.datingapp --web-dir dist
fi

# Ajout de la plateforme Android
echo "📱 Ajout de la plateforme Android..."
npx cap add android

# Synchronisation des fichiers
echo "🔄 Synchronisation des fichiers avec Android..."
npx cap sync android

echo "✅ Configuration terminée. Vous pouvez maintenant ouvrir le projet dans Android Studio avec :"
echo "npx cap open android"
echo ""
echo "Pour générer les ressources d'application (icônes, splash screens), exécutez :"
echo "./generate-resources.sh"