# Guide d'utilisation pour la publication sur Google Play

## Résumé du processus

Voici les étapes simplifiées pour publier votre application de rencontres sur le Google Play Store :

### Étape 1 : Préparation
- Téléchargez ce projet sur votre ordinateur
- Créez un compte développeur Google Play (25$)
- Installez les outils nécessaires (Android Studio, Java)

### Étape 2 : Configuration
- Exécutez le script `setup-android.sh` qui prépare automatiquement votre application
- Les icônes et images de démarrage sont déjà créées pour vous

### Étape 3 : Finalisation dans Android Studio
- Ouvrez le projet avec `npx cap open android`
- Créez une clé de signature avec `keytool` (une seule fois)
- Générez un bundle signé pour le Google Play Store

### Étape 4 : Publication
- Créez une fiche d'application sur Google Play Console
- Ajoutez les descriptions, captures d'écran et politique de confidentialité
- Téléchargez votre bundle ou APK signé
- Soumettez pour examen (délai de 1-7 jours)

## Points importants à retenir

- **Ne perdez jamais** votre fichier keystore - sans lui, vous ne pourrez pas mettre à jour votre application
- Les applications de rencontres ont des exigences strictes concernant la confidentialité et la modération
- La vérification Google peut prendre plusieurs jours, surtout pour une première soumission
- Une fois approuvée, votre application sera disponible pour des millions d'utilisateurs Android !

Pour des instructions détaillées, consultez le fichier `ANDROID_DEPLOYMENT.md`.