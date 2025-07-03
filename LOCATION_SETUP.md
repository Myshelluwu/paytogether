# Configuración de Ubicación - PayTogether

## 🗺️ Configuración de Google Maps API

Para usar la funcionalidad de ubicación en PayTogether, necesitas configurar la API de Google Maps.

### 1. Obtener API Key de Google Maps

1. Ve a [Google Cloud Console](https://console.cloud.google.com/)
2. Crea un nuevo proyecto o selecciona uno existente
3. Habilita las siguientes APIs:
   - **Maps SDK for Android**
   - **Maps SDK for iOS**
   - **Geocoding API**
   - **Places API** (opcional, para búsqueda de lugares)

### 2. Crear API Key

1. En la consola de Google Cloud, ve a **APIs & Services** > **Credentials**
2. Haz clic en **+ CREATE CREDENTIALS** > **API Key**
3. Copia la API key generada

### 3. Configurar la API Key

#### Para Android:
1. Abre el archivo `android/app/src/main/AndroidManifest.xml`
2. Reemplaza `TU_API_KEY_AQUI` con tu API key real:
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="TU_API_KEY_REAL_AQUI" />
```

#### Para iOS:
1. Abre el archivo `ios/Runner/AppDelegate.swift`
2. Agrega la siguiente línea después de `import UIKit`:
```swift
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("TU_API_KEY_REAL_AQUI")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

### 4. Restricciones de API Key (Recomendado)

Para mayor seguridad, configura restricciones en tu API key:

1. En Google Cloud Console, ve a **APIs & Services** > **Credentials**
2. Haz clic en tu API key
3. En **Application restrictions**, selecciona **Android apps** y agrega tu package name
4. En **API restrictions**, selecciona las APIs que habilitaste

### 5. Instalar Dependencias

Ejecuta el siguiente comando para instalar las dependencias:

```bash
flutter pub get
```

## 🔧 Funcionalidades Implementadas

### ✅ Servicios de Ubicación
- **LocationService**: Maneja permisos y obtención de ubicación
- **Geocoding**: Convierte coordenadas a direcciones legibles
- **Google Maps**: Muestra mapas interactivos

### ✅ Widgets de Ubicación
- **LocationMapWidget**: Muestra ubicación en mapa
- **LocationPickerWidget**: Permite seleccionar ubicación en mapa

### ✅ Integración en Agregar Gasto
- Botón para obtener ubicación actual
- Selector de ubicación en mapa
- Visualización de ubicación seleccionada
- Almacenamiento de datos de ubicación

## 📱 Permisos Requeridos

La app solicitará automáticamente los siguientes permisos:

- **Ubicación precisa**: Para obtener coordenadas exactas
- **Ubicación aproximada**: Como respaldo
- **Internet**: Para cargar mapas y geocodificación

## 🚀 Uso

1. **Obtener ubicación actual**: Toca el botón "Ubicación actual"
2. **Seleccionar en mapa**: Toca "Seleccionar" para elegir ubicación manualmente
3. **Ver ubicación**: La ubicación se muestra en un mapa interactivo
4. **Eliminar ubicación**: Toca el ícono X para quitar la ubicación

## 🔒 Privacidad

- La ubicación solo se almacena localmente
- No se comparte con terceros
- El usuario puede eliminar la ubicación en cualquier momento

## 🐛 Solución de Problemas

### Error: "No se pudo obtener la ubicación"
- Verifica que los servicios de ubicación estén habilitados
- Asegúrate de haber otorgado permisos de ubicación
- Verifica tu conexión a internet

### Error: "API key no válida"
- Verifica que la API key esté correctamente configurada
- Asegúrate de que las APIs estén habilitadas
- Revisa las restricciones de la API key

### Mapa no se carga
- Verifica tu conexión a internet
- Asegúrate de que la API key tenga permisos para Maps SDK
- Revisa los logs de la consola para errores específicos 