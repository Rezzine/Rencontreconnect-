import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'io.replit.datingapp',
  appName: 'Dating App',
  webDir: 'dist',
  server: {
    androidScheme: 'https'
  },
  android: {
    // Configuration spécifique à Android
    backgroundColor: '#FFFFFF',
    buildOptions: {
      // Options de compilation
      // Remarque: ces valeurs seront configurées lors du processus de build
    },
    // Configuration des permissions
    permissions: [
      "android.permission.INTERNET",
      "android.permission.ACCESS_NETWORK_STATE"
    ],
    // Configuration des couleurs de la barre de statut
    statusBarColor: '#E91E63',
    statusBarStyle: 'light',
    // Configurer l'orientation de l'écran
    orientation: 'portrait'
  },
  // Plugins additionnels
  plugins: {
    SplashScreen: {
      launchShowDuration: 3000,
      launchAutoHide: true,
      backgroundColor: "#FFFFFF",
      androidSplashResourceName: "splash",
      androidScaleType: "CENTER_CROP",
      showSpinner: true,
      androidSpinnerStyle: "large",
      spinnerColor: "#E91E63",
    },
  }
};

export default config;