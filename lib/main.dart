import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'utils/firebase_options.dart';
import 'utils/app_config.dart';
import 'screens/main_menu.dart';
import 'screens/group_screen.dart';
import 'screens/person_screen.dart';
import 'screens/historial_individual.dart';
import 'screens/historial_grupo.dart';
import 'screens/grafica_deudas.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/cuentasind.dart';
import 'screens/cuentasgru.dart';
import 'screens/circulo.dart';
import 'screens/agregar_gasto.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cargar variables de entorno
  await dotenv.load(fileName: "apis.env");

  // Inicializar Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Verificar configuración de APIs
  if (!AppConfig.isConfigured) {
    print('⚠️ Advertencia: Algunas APIs no están configuradas correctamente');
    AppConfig.debugInfo.forEach((key, value) => print('$key: $value'));
  }

  runApp(const PayTogetherApp());
}

class PayTogetherApp extends StatelessWidget {
  const PayTogetherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PayTogether',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Poppins', // Fuente global
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/menu': (context) => const Menu(),
        '/el-canton': (context) => const GroupScreen(groupName: 'El Cantón'),
        '/escuela': (context) => const GroupScreen(groupName: 'Escuela'),
        '/amigos': (context) => const GroupScreen(groupName: 'Amigos'),
        '/kiki': (context) => const PersonScreen(personName: 'Kiki'),
        '/oddie': (context) => const PersonScreen(personName: 'Oddie'),
        '/obrien': (context) => const PersonScreen(personName: 'O\'Brien'),
        '/historial-kiki': (context) =>
            const HistorialDeudasScreen(personName: 'Kiki'),
        '/historial-oddie': (context) =>
            const HistorialDeudasScreen(personName: 'Oddie'),
        '/historial-obrien': (context) =>
            const HistorialDeudasScreen(personName: 'O\'Brien'),
        '/historial-el-canton': (context) =>
            const HistorialGrupoScreen(groupName: 'El Cantón'),
        '/historial-amigos': (context) =>
            const HistorialGrupoScreen(groupName: 'Amigos'),
        '/historial-escuela': (context) =>
            const HistorialGrupoScreen(groupName: 'Escuela'),
        '/grafica-deudas': (context) => const GraficaDeudasScreen(),
        '/cuentasind': (context) =>
            const CuentasIndividuales(personName: 'Kiki'),
        '/cuentasgru': (context) =>
            const CuentasGrupales(groupName: 'El Cantón'),
        '/circulo': (context) => const Users(),
        '/agregar-gasto': (context) => const AgregarGastoScreen(),
        '/historial-individual': (context) =>
            const HistorialDeudasScreen(personName: 'Kiki'),
        '/historial-grupo': (context) =>
            const HistorialGrupoScreen(groupName: 'El Cantón'),
      },
      onGenerateRoute: (settings) {
        // Manejar rutas dinámicas para nuevos grupos
        if (settings.name != null && settings.name!.startsWith('/')) {
          final groupName = settings.name!.substring(1).replaceAll('-', ' ');
          return MaterialPageRoute(
            builder: (context) => GroupScreen(groupName: groupName),
          );
        }
        return null;
      },
      debugShowCheckedModeBanner: false, // Quita el banner de debug
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco profesional
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo/icono sugerido (puedes cambiarlo)
            const Icon(
              Icons.account_balance_wallet,
              size: 100,
              color: Colors.green,
            ),
            const SizedBox(height: 20), // Espaciado
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('PayTogether'), // Texto más descriptivo
            ),
          ],
        ),
      ),
    );
  }
}
