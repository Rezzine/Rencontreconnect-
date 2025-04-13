# Publication directe sur Google Play Store

Ce document explique comment publier votre application directement sur Google Play Store sans passer par toutes les étapes manuelles dans Android Studio et Google Play Console.

## Prérequis

1. Avoir créé votre application dans Google Play Console
2. Avoir un compte de service Google Play avec les permissions appropriées
3. Avoir généré un keystore pour signer votre application

## Configuration initiale (une seule fois)

### 1. Créer un compte de service

1. Connectez-vous à [Google Play Console](https://play.google.com/console)
2. Allez dans **Paramètres du compte > Accès par API > Comptes de service**
3. Cliquez sur **Créer un compte de service**
4. Suivez les instructions pour créer un compte de service dans Google Cloud Console
5. Attribuez le rôle **Administrateur des applications Play** au compte de service
6. Générez et téléchargez une clé JSON pour ce compte de service

### 2. Configurer les variables d'environnement

Ajoutez les variables suivantes à votre environnement (fichier `.env` ou variables d'environnement système) :

```bash
# Chemin vers votre fichier de clé JSON du compte de service
PLAY_STORE_CREDENTIALS=/chemin/vers/votre-compte-service.json

# Informations sur votre keystore
ANDROID_KEYSTORE_PATH=/chemin/vers/votre-keystore.keystore
ANDROID_KEYSTORE_PASSWORD=votre-mot-de-passe-keystore
ANDROID_KEY_ALIAS=alias-de-votre-clé
ANDROID_KEY_PASSWORD=mot-de-passe-de-votre-clé
```

### 3. Installer les outils nécessaires

```bash
# Installer le CLI Google Play Developer (exemple avec npm)
npm install -g google-play-cli

# Installer bundletool
wget https://github.com/google/bundletool/releases/download/1.14.0/bundletool-all-1.14.0.jar -O ~/bundletool.jar
echo 'alias bundletool="java -jar ~/bundletool.jar"' >> ~/.bashrc
source ~/.bashrc
```

## Publication automatisée

Maintenant que tout est configuré, vous pouvez utiliser le script `deploy-to-play-store.sh` pour publier directement :

```bash
./deploy-to-play-store.sh
```

Ce script va :
1. Construire votre application web
2. Synchroniser avec Capacitor
3. Incrémenter automatiquement le numéro de version
4. Générer un bundle AAB signé
5. Télécharger et publier le bundle sur Google Play Console

## Pistes de publication

Le script publie par défaut sur la piste "internal" (test interne). Les autres options sont :

- `internal` : Pour les testeurs internes (équipe de développement)
- `alpha` : Pour les testeurs fermés
- `beta` : Pour un public plus large de testeurs
- `production` : Pour tous les utilisateurs du Play Store

Pour modifier la piste, changez le paramètre `--track` dans le script.

## Notes importantes

- La première publication doit être faite manuellement via la Google Play Console
- Les mises à jour suivantes peuvent utiliser ce script automatisé
- Certaines informations comme les captures d'écran doivent être gérées via la console
- Assurez-vous que votre application respecte toutes les règles de Google Play avant la publication

## Dépannage

Si vous rencontrez des erreurs lors de la publication automatisée :

1. Vérifiez les journaux pour identifier l'erreur précise
2. Assurez-vous que les variables d'environnement sont correctement définies
3. Vérifiez que votre compte de service a les permissions nécessaires
4. Confirmez que l'application existe déjà dans Google Play Console
5. Vérifiez que la version que vous essayez de publier est supérieure à celle déjà publiée