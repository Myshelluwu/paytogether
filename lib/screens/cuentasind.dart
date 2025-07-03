//cuentas individuales
import 'package:flutter/material.dart';

class CuentasIndividuales extends StatelessWidget {
  final String personName;
  const CuentasIndividuales({super.key, required this.personName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cuentas Individuales',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Sección de Personas
            _buildSection(
              context: context,
              title: "Historial",
              subtitle: "Elige una persona para ver sus cuentas",
              items: [
                const _GroupItem(name: 'Kiki', route: '/historial-kiki'),
                const _GroupItem(name: 'Oddie', route: '/historial-oddie'),
                const _GroupItem(name: 'O\'Brien', route: '/historial-obrien'),
              ],
              icon: Icons.person,
              color: Colors.green,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

Widget _buildGroupButton(
  BuildContext context,
  String name,
  IconData icon,
  Color color,
  String route,
) {
  return SizedBox(
    width: double.infinity,
    child: OutlinedButton(
      onPressed: () => Navigator.pushNamed(context, route),
      style: OutlinedButton.styleFrom(
        alignment: Alignment.centerLeft,
        backgroundColor: color.withOpacity(0.05),
        foregroundColor: color,
        side: BorderSide(color: color.withOpacity(0.3)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        minimumSize: const Size(double.infinity, 60),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(width: 16),
          Text(
            name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 24),
        ],
      ),
    ),
  );
}

Widget _buildSection({
  required BuildContext context,
  required String title,
  required String subtitle,
  required List<_GroupItem> items,
  required IconData icon,
  required Color color,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 4),
      Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      const SizedBox(height: 16),

      // Lista de elementos en columna
      Column(
        children: items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _buildGroupButton(
                  context,
                  item.name,
                  icon,
                  color,
                  item.route,
                ),
              ),
            )
            .toList(),
      ),
    ],
  );
}

class _GroupItem {
  final String name;
  final String route;

  const _GroupItem({required this.name, required this.route});
}
