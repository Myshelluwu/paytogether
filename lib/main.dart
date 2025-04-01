import 'package:flutter/material.dart';
import 'package:paytogether/menu.dart';

void main() {
  runApp(const PayTogetherApp()); // Nombre más descriptivo
}

class PayTogetherApp extends StatelessWidget {
  const PayTogetherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PayTogether', // Añadido para identificación en el switcher de apps
      theme: ThemeData(
        primarySwatch: Colors.green, // Color principal de la app
        fontFamily: 'Poppins', // Fuente global
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(), // Renombrado para claridad
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
                Navigator.pushReplacement( // Mejor que push para pantalla de inicio
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
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