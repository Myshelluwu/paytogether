import 'package:flutter/material.dart';
import 'package:paytogether/circulo.dart';
import 'package:paytogether/cuentasind.dart';
import 'package:paytogether/cuentasgru.dart';
import 'package:paytogether/agregar_gasto.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  // Componentes separados
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'PayTogether',
        style: TextStyle(
          color: Colors.green,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDebtCalculationSection(context),
          const SizedBox(height: 24),
          const Divider(),
          _buildDebtVisualizationSection(),
          const SizedBox(height: 16),
          const Divider(),
          _buildCircleButton(context),
        ],
      ),
    );
  }

  Widget _buildDebtCalculationSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cálculo de deudas',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildMenuButton(
                  context: context,
                  text: 'Cuentas Individuales',
                  icon: Icons.person_outline,
                  destination: const CuentasIndividuales(personName: 'Kiki'),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildMenuButton(
                  context: context,
                  text: 'Cuentas Grupales',
                  icon: Icons.group_outlined,
                  destination: const CuentasGrupales(groupName: 'El Cantón'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDebtVisualizationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Visualización de Deudas',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Icon(Icons.pie_chart_outline, size: 50, color: Colors.green),
                  SizedBox(height: 8),
                  Text(
                    'Gráfica de Deudas',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCircleButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () => _navigateTo(context, const Users()),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.green,
        side: const BorderSide(color: Colors.green),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        minimumSize: const Size(double.infinity, 48), // Ancho completo
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 20, color: Colors.green),
          SizedBox(width: 8),
          Text(
            'Mi Círculo',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _navigateTo(context, const AgregarGastoScreen()),
      tooltip: 'Añadir Gasto',
      shape: const CircleBorder(),
      backgroundColor: Colors.green,
      child: const Icon(Icons.add, color: Colors.white, size: 30),
    );
  }

  // Métodos reutilizables
  Widget _buildMenuButton({
    required BuildContext context,
    required String text,
    required IconData icon,
    required Widget destination,
  }) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => _navigateTo(context, destination),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.green,
          side: const BorderSide(color: Colors.green),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          minimumSize:
              const Size(double.infinity, 60), // Altura fija para ambos botones
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: Colors.green),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
