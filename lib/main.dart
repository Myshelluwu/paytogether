import 'package:flutter/material.dart';
import 'package:paytogether/menu.dart';
import 'package:paytogether/persona.dart';
import 'package:paytogether/grupo.dart';
import 'package:paytogether/historial_individual.dart';
import 'package:paytogether/historial_grupo.dart';

void main() {
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
        '/menu': (context) => const Menu(),
        '/el-cantón': (context) => GroupScreen(groupName: 'El Cantón'),
        '/escuela': (context) => GroupScreen(groupName: 'Escuela'),
        '/amigos': (context) => GroupScreen(groupName: 'Amigos'),
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
                Navigator.pushReplacementNamed(context, '/menu');
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
