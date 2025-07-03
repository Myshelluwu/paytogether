import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Clase para manejar la configuración de la aplicación
/// Centraliza el acceso a las variables de entorno
class AppConfig {
  // Firebase Configuration
  static String get firebaseWebApiKey =>
      dotenv.env['FIREBASE_WEB_API_KEY'] ?? '';

  static String get firebaseAndroidApiKey =>
      dotenv.env['FIREBASE_ANDROID_API_KEY'] ?? '';

  static String get firebaseProjectId =>
      dotenv.env['FIREBASE_PROJECT_ID'] ?? '';

  static String get firebaseMessagingSenderId =>
      dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '';

  static String get firebaseAuthDomain =>
      dotenv.env['FIREBASE_AUTH_DOMAIN'] ?? '';

  static String get firebaseStorageBucket =>
      dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '';

  static String get firebaseWebAppId => dotenv.env['FIREBASE_WEB_APP_ID'] ?? '';

  static String get firebaseAndroidAppId =>
      dotenv.env['FIREBASE_ANDROID_APP_ID'] ?? '';

  static String get firebaseWindowsAppId =>
      dotenv.env['FIREBASE_WINDOWS_APP_ID'] ?? '';

  // Google Maps Configuration
  static String get googleMapsApiKey => dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';

  /// Verifica si todas las variables de entorno necesarias están configuradas
  static bool get isConfigured {
    return firebaseWebApiKey.isNotEmpty &&
        firebaseAndroidApiKey.isNotEmpty &&
        firebaseProjectId.isNotEmpty &&
        googleMapsApiKey.isNotEmpty;
  }

  /// Retorna un mapa con todas las configuraciones para debugging
  static Map<String, String> get debugInfo {
    return {
      'firebase_web_api_key': firebaseWebApiKey.isNotEmpty
          ? '✅ Configurado'
          : '❌ Faltante',
      'firebase_android_api_key': firebaseAndroidApiKey.isNotEmpty
          ? '✅ Configurado'
          : '❌ Faltante',
      'firebase_project_id': firebaseProjectId.isNotEmpty
          ? '✅ Configurado'
          : '❌ Faltante',
      'google_maps_api_key': googleMapsApiKey.isNotEmpty
          ? '✅ Configurado'
          : '❌ Faltante',
    };
  }
}
