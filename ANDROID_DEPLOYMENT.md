# Guide complet de déploiement sur Google Play

Ce guide détaillé vous explique comment publier votre application de rencontres sur Google Play Store, étape par étape.

## Prérequis

1. Un compte Google Play Developer (frais d'inscription uniques de 25$)
   - Inscrivez-vous sur [play.google.com/apps/publish](https://play.google.com/apps/publish)
   - Vous devrez fournir des informations personnelles et de paiement
2. Android Studio installé sur votre ordinateur
   - Téléchargez depuis [developer.android.com/studio](https://developer.android.com/studio)
3. JDK (Java Development Kit) version 11 ou plus récente
   - Téléchargez depuis [adoptium.net](https://adoptium.net/)

## Étapes de déploiement

### 1. Exportation et préparation de l'application

1. Téléchargez ce projet depuis Replit vers votre machine locale
   - Utilisez le bouton "Download as ZIP" ou clonez via Git
2. Sur votre machine locale, ouvrez un terminal et exécutez :
   ```bash
   # Installation des dépendances
   npm install
   
   # Exécution du script de configuration
   ./setup-android.sh
   ```
   Ce script automatise les étapes suivantes :
   - Construction de l'application web
   - Initialisation de Capacitor
   - Ajout de la plateforme Android
   - Synchronisation des fichiers

### 2. Génération des ressources pour Android

1. Installez l'outil de génération de ressources Capacitor :
   ```bash
   npm install -g capacitor-resources
   ```

2. Générez les icônes et écrans de démarrage à partir des fichiers SVG source :
   ```bash
   capacitor-resources
   ```
   
   Nous avons déjà préparé les ressources SVG dans :
   - `resources/android/icon.svg` - Pour l'icône de l'application
   - `resources/android/splash.svg` - Pour l'écran de démarrage

### 3. Configuration avancée dans Android Studio

1. Ouvrez le projet Android dans Android Studio :
   ```bash
   npx cap open android
   ```

2. Mettez à jour les informations de l'application :

   a. Dans le fichier `android/app/src/main/AndroidManifest.xml` :
   - Vérifiez que toutes les permissions nécessaires sont présentes
   - Assurez-vous que les activités et services sont correctement configurés
   
   b. Dans le fichier `android/app/build.gradle` :
   - Configurez la version de l'application (`versionCode` et `versionName`)
   - Définissez le SDK minimum et cible
   ```gradle
   android {
     defaultConfig {
       applicationId "io.replit.datingapp"
       minSdkVersion 21
       targetSdkVersion 33
       versionCode 1
       versionName "1.0.0"
     }
   }
   ```

3. Testez votre application sur un émulateur ou un appareil réel :
   - Créez un émulateur via AVD Manager dans Android Studio
   - Ou connectez un appareil Android réel via USB avec le débogage USB activé
   - Exécutez l'application en cliquant sur "Run"

### 4. Création et gestion du keystore pour signer l'application

La signature numérique est obligatoire pour les applications Android publiées sur Google Play.

1. Dans un terminal, générez votre keystore :
   ```bash
   keytool -genkey -v -keystore dating-app-key.keystore -alias dating-app -keyalg RSA -keysize 2048 -validity 10000
   ```

2. Vous devrez fournir des informations telles que :
   - Mot de passe du keystore
   - Nom et prénom
   - Nom de votre organisation
   - Ville, état/province, code pays

3. Déplacez le keystore dans un endroit sécurisé et faites-en des sauvegardes

   **⚠️ ATTENTION : Ce fichier keystore est CRITIQUE. Si vous le perdez, vous ne pourrez plus jamais mettre à jour votre application existante sur Google Play. Google n'offre aucune solution de récupération.**

### 5. Génération du bundle ou APK signé pour publication

Google Play préfère désormais le format Android App Bundle (AAB) au lieu des APK.

1. Dans Android Studio, allez dans `Build > Generate Signed Bundle/APK`

2. Sélectionnez "Android App Bundle" pour une distribution optimale sur Google Play
   
3. Suivez les instructions pour sélectionner votre keystore :
   - Chemin vers le fichier keystore
   - Mot de passe du keystore
   - Alias de la clé
   - Mot de passe de la clé

4. Choisissez la variante de build "release" et finalisez
   
5. Votre fichier AAB signé sera généré dans `android/app/build/outputs/bundle/release/`

### 6. Publication complète sur Google Play Console

1. Connectez-vous à la [Google Play Console](https://play.google.com/console)

2. Créez une nouvelle application :
   - Cliquez sur "Créer une application"
   - Choisissez la langue par défaut
   - Entrez le nom de l'application
   - Spécifiez s'il s'agit d'une application ou d'un jeu
   - Indiquez si elle est gratuite ou payante

3. Complétez la fiche Play Store (dans "Présence sur le Store") :
   
   a. Informations sur l'application :
   - Nom de l'application (jusqu'à 50 caractères)
   - Description courte (jusqu'à 80 caractères)
   - Description complète (jusqu'à 4000 caractères)
   
   b. Ressources graphiques :
   - Icône de l'application (512x512 px)
   - Image principale (1024x500 px)
   - Au moins 8 captures d'écran (format paysage ou portrait)
   - Vidéo promotionnelle (facultatif)
   
   c. Informations de contact et liens :
   - Email de contact
   - Site web
   - Politique de confidentialité (OBLIGATOIRE pour les applications de rencontres)

4. Classification du contenu :
   - Remplissez le questionnaire de classification
   - Les applications de rencontres ont généralement une classification 17+ ou 18+

5. Configuration de la publication :
   - Pays et régions de distribution
   - Spécifications de prix et monétisation

6. Téléchargez votre App Bundle ou APK signé :
   - Allez dans "Production > Créer une version"
   - Importez votre AAB ou APK
   - Indiquez les notes de version (ce qui est nouveau)

7. Vérification de publication :
   - Confirmez que vous respectez toutes les politiques
   - Soumettez pour examen par Google

### Directives spécifiques pour les applications de rencontres

Les applications de rencontres sont soumises à des contrôles plus stricts :

1. **Politique de confidentialité obligatoire** qui doit couvrir :
   - Quelles données personnelles sont collectées
   - Comment ces données sont utilisées et partagées
   - Comment les utilisateurs peuvent supprimer leurs données
   - Mesures de sécurité en place

2. **Contrôles de modération** :
   - Système de signalement des utilisateurs
   - Processus de vérification des profils
   - Mesures contre le harcèlement

3. **Restrictions d'âge** :
   - Vérification de l'âge
   - Classification appropriée (17+ ou 18+)

4. **Contenu et comportement** :
   - Directives claires sur le contenu acceptable
   - Termes de service explicites

## Maintenance et mises à jour

Pour mettre à jour votre application après publication :

1. Modifiez votre code et testez les changements
2. Augmentez le `versionCode` et `versionName` dans `android/app/build.gradle`
   ```gradle
   versionCode 2  // Incrémentez de 1 à chaque mise à jour
   versionName "1.0.1"  // Utilisez une convention de versionnage sémantique
   ```
3. Synchronisez les modifications avec Capacitor :
   ```bash
   npm run build && npx cap sync
   ```
4. Générez un nouvel App Bundle signé avec la MÊME clé que précédemment
5. Dans Google Play Console, créez une nouvelle version dans "Production"
6. Téléchargez le nouveau bundle et décrivez les changements dans les notes de version
7. Soumettez la mise à jour pour examen

## Suivi et analyse

Une fois votre application publiée, utilisez Google Play Console pour :

- Surveiller les installations et désinstallations
- Analyser les avis utilisateurs
- Suivre les rapports de plantage
- Optimiser la visibilité dans le Play Store

## Ressources supplémentaires

- [Documentation officielle de Capacitor](https://capacitorjs.com/docs/android)
- [Guide de qualité des applications Android](https://developer.android.com/docs/quality-guidelines)
- [Politiques du programme pour les développeurs](https://play.google.com/about/developer-content-policy/)
- [Centre d'aide Google Play Console](https://support.google.com/googleplay/android-developer/)