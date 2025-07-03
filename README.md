# 💰 PayTogether

**Una aplicación móvil para gestionar gastos compartidos y deudas entre amigos, familiares y grupos.**

[![Flutter](https://img.shields.io/badge/Flutter-3.16.0-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.2.0-blue.svg)](https://dart.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-Enabled-green.svg)](https://firebase.google.com/)

## 📱 Descripción

PayTogether es una aplicación Flutter que facilita la gestión de gastos compartidos. Permite a los usuarios crear grupos, registrar gastos individuales y grupales, y mantener un seguimiento claro de las deudas entre participantes.

### ✨ Características Principales

- 🔐 **Autenticación segura** con Firebase Auth
- 👥 **Gestión de grupos** y círculos de amigos
- 💳 **Gastos individuales** y grupales
- 📊 **Gráficas de deudas** visuales
- 📍 **Ubicación de gastos** con mapas
- 📅 **Historial detallado** de transacciones
- 🎨 **Interfaz moderna** y fácil de usar

## 🚀 Instalación

### Prerrequisitos

- [Flutter](https://flutter.dev/docs/get-started/install) (versión 3.16.0 o superior)
- [Dart](https://dart.dev/get-dart) (versión 3.2.0 o superior)
- [Android Studio](https://developer.android.com/studio) o [VS Code](https://code.visualstudio.com/)
- Cuenta de [Firebase](https://firebase.google.com/)

### Pasos de instalación

1. **Clona el repositorio**
   ```bash
   git clone https://github.com/tu-usuario/paytogether.git
   cd paytogether
   ```

2. **Instala las dependencias**
   ```bash
   flutter pub get
   ```

3. **Configura las APIs** (ver [API_SETUP.md](API_SETUP.md)):
   - Copia `apis.env.example` como `apis.env`
   - Copia `android/app/google-services.json.example` como `android/app/google-services.json`
   - Copia `android/local.properties.example` como `android/local.properties`
   - Agrega tus claves de Firebase y Google Maps
   - Configura Firebase y Google Maps en sus respectivas consolas

4. **Ejecuta la aplicación**
   ```bash
   flutter run
   ```

## 📁 Estructura del Proyecto

```
lib/
├── main.dart                 # Punto de entrada de la aplicación
├── screens/                  # Pantallas de la aplicación
│   ├── auth/                # Autenticación
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   ├── main_menu.dart       # Menú principal
│   ├── splash_screen.dart   # Pantalla de carga
│   ├── person_screen.dart   # Perfil de persona
│   ├── group_screen.dart    # Perfil de grupo
│   ├── circulo.dart         # Gestión de círculos
│   ├── agregar_gasto.dart   # Agregar gastos
│   ├── grafica_deudas.dart  # Gráficas de deudas
│   ├── historial_individual.dart
│   ├── historial_grupo.dart
│   └── ...
├── services/                # Servicios
│   └── location_service.dart
├── widgets/                 # Widgets reutilizables
│   └── location_map_widget.dart
├── utils/                   # Utilidades
│   └── firebase_options.dart
└── models/                  # Modelos de datos
```

## 🛠️ Tecnologías Utilizadas

- **Frontend**: Flutter & Dart
- **Backend**: Firebase
  - Authentication
  - Firestore Database
  - Cloud Storage
- **Mapas**: Google Maps Flutter
- **Gráficas**: fl_chart
- **Ubicación**: geolocator, geocoding
- **Permisos**: permission_handler

## 📱 Funcionalidades

### 🔐 Autenticación
- Registro de usuarios
- Inicio de sesión
- Gestión de perfiles

### 👥 Gestión de Grupos
- Crear grupos personalizados
- Agregar miembros
- Administrar participantes

### 💰 Gestión de Gastos
- **Gastos Individuales**: Deudas entre dos personas
- **Gastos Grupales**: Gastos compartidos entre múltiples personas
- **División equitativa** de gastos
- **Ubicación** de los gastos con mapas

### 📊 Visualización
- Gráficas de deudas por persona
- Historial detallado de transacciones
- Resúmenes mensuales

### 📍 Ubicación
- Obtener ubicación actual
- Seleccionar ubicación en mapa
- Guardar ubicación de gastos



## 🤝 Contribuir

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request


## 👨‍💻 Autor

**Michelle Sanchez**
- GitHub:  [Myshelluwu](https://github.com/Myshelluwu)
- LinkedIn: [Michelle Sánchez Barba](https://www.linkedin.com/in/myshell-sanchez/)