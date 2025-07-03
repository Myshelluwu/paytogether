# 🔐 Configuración de APIs - PayTogether

Este documento explica cómo configurar las APIs necesarias para el proyecto PayTogether.

## 📋 APIs Requeridas

### 1. Firebase
- **Propósito**: Autenticación, base de datos y almacenamiento
- **Servicios**: Authentication, Realtime Database, Cloud Firestore
- **Configuración**: Necesitas crear un proyecto en [Firebase Console](https://console.firebase.google.com/)

### 2. Google Maps
- **Propósito**: Mostrar mapas y obtener ubicaciones
- **Servicios**: Maps SDK for Android, Geocoding API
- **Configuración**: Necesitas habilitar las APIs en [Google Cloud Console](https://console.cloud.google.com/)

## 🚀 Configuración Rápida

### Paso 1: Configurar Firebase

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Crea un nuevo proyecto o selecciona uno existente
3. Habilita Authentication, Realtime Database y Cloud Firestore
4. Agrega tu aplicación (Android, Web, Windows)
5. Copia las claves de configuración

### Paso 2: Configurar Google Maps

1. Ve a [Google Cloud Console](https://console.cloud.google.com/)
2. Crea un nuevo proyecto o selecciona el mismo de Firebase
3. Habilita las siguientes APIs:
   - Maps SDK for Android
   - Geocoding API
   - Places API (opcional)
4. Crea credenciales (API Key)
5. Restringe la API Key por seguridad

### Paso 3: Configurar Variables de Entorno

1. **Configurar APIs generales:**
   - Copia el archivo `apis.env.example` como `apis.env`
   - Copia el archivo `android/app/google-services.json.example` como `android/app/google-services.json`
   - Reemplaza los valores con tus claves reales

2. **Configurar Android específicamente:**
   - Copia el archivo `android/local.properties.example` como `android/local.properties`
   - Agrega tu Google Maps API Key para Android

3. **Configurar iOS específicamente:**
   - La configuración de Google Maps se maneja desde Flutter usando AppConfig
   - No es necesario configurar manualmente en iOS

```env
# Firebase
FIREBASE_WEB_API_KEY=tu_firebase_web_api_key
FIREBASE_ANDROID_API_KEY=tu_firebase_android_api_key
FIREBASE_PROJECT_ID=tu_firebase_project_id
FIREBASE_MESSAGING_SENDER_ID=tu_firebase_messaging_sender_id
FIREBASE_AUTH_DOMAIN=tu_firebase_auth_domain
FIREBASE_STORAGE_BUCKET=tu_firebase_storage_bucket
FIREBASE_WEB_APP_ID=tu_firebase_web_app_id
FIREBASE_ANDROID_APP_ID=tu_firebase_android_app_id
FIREBASE_WINDOWS_APP_ID=tu_firebase_windows_app_id

# Google Maps
GOOGLE_MAPS_API_KEY=tu_google_maps_api_key
```

## 🔒 Seguridad

### ⚠️ IMPORTANTE: Protección de Claves

- **NUNCA** subas el archivo `apis.env` a Git
- El archivo ya está en `.gitignore`
- Para producción, usa variables de entorno del servidor
- Restringe las API Keys en las consolas de Google y Firebase

### Restricciones Recomendadas

#### Firebase API Key
- Restringe por dominio de aplicación
- Limita a tu proyecto específico

#### Google Maps API Key
- Restringe por aplicación Android (SHA-1 fingerprint)
- Restringe por dominio para web
- Limita a las APIs específicas que uses

## 🛠️ Uso en el Código

### Acceder a las Variables

```dart
import 'package:paytogether/utils/app_config.dart';

// Obtener API Key de Google Maps
String mapsApiKey = AppConfig.googleMapsApiKey;

// Obtener configuración de Firebase
String firebaseProjectId = AppConfig.firebaseProjectId;
```

## 📱 Configuración por Plataforma

### Android
- La API Key se configura en `android/local.properties`
- Se usa automáticamente en `AndroidManifest.xml`
- El archivo está protegido en `.gitignore`

### iOS
- La API Key se configura en `apis.env`
- Se maneja desde Flutter usando `AppConfig`
- No requiere configuración manual en `AppDelegate.swift`

### Verificar Configuración

```dart
// Verificar si todas las APIs están configuradas
if (AppConfig.isConfigured) {
  print('✅ Todas las APIs están configuradas');
} else {
  print('❌ Faltan algunas configuraciones');
  AppConfig.debugInfo.forEach((key, value) => print('$key: $value'));
}
```

## 🐛 Solución de Problemas

### Error: "API Key not found"
- Verifica que el archivo `apis.env` existe
- Confirma que las claves están correctamente escritas
- Asegúrate de que no hay espacios extra

### Error: "Maps not loading"
- Verifica que la Google Maps API Key es válida
- Confirma que las APIs están habilitadas en Google Cloud Console
- Revisa las restricciones de la API Key

### Error: "Firebase connection failed"
- Verifica que las claves de Firebase son correctas
- Confirma que el proyecto está activo
- Revisa las reglas de seguridad de Firestore/Database

## 📞 Soporte

Si tienes problemas con la configuración:

1. Revisa los logs de la aplicación
2. Verifica la configuración con `AppConfig.debugInfo`
3. Confirma que las APIs están habilitadas en las consolas
4. Revisa las restricciones de las API Keys

---

**Nota**: Este archivo contiene información sensible. Mantén las claves seguras y no las compartas públicamente. 