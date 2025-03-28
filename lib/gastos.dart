import 'package:flutter/material.dart';

class Gastos extends StatelessWidget {
  const Gastos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Gastos',
            style: TextStyle(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Primero, añade participantes',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 6),
                Text(
                  'Necesitas añadir participantes antes de registrar gastos',
                  style: TextStyle(
                      fontSize: 14, color: Colors.grey, fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
              ]),
            ],
          ),
        ));
  }
}
