import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          _buildUserProfileSection(),
          const SizedBox(height: 24),
          const Divider(),
          _buildDebtCalculationSection(context),
          const SizedBox(height: 24),
          const Divider(),
          _buildDebtVisualizationSection(context),
          const SizedBox(height: 16),
          const Divider(),
          _buildCircleButton(context),
        ],
      ),
    );
  }

  Widget _buildUserProfileSection() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = snapshot.data;
        if (user == null) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Usuario no autenticado',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          'Inicia sesión para ver tu perfil',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Obtener las iniciales del correo para el CircleAvatar
        String initials = '';
        if (user.email != null && user.email!.isNotEmpty) {
          final emailParts = user.email!.split('@')[0];
          if (emailParts.length >= 2) {
            initials = emailParts.substring(0, 2).toUpperCase();
          } else {
            initials = emailParts.toUpperCase();
          }
        }

        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.green,
                  child: Text(
                    initials,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.displayName ?? 'Usuario',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email ?? 'Sin correo',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    // Navegar a la pantalla de login
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
                  icon: const Icon(Icons.logout, color: Colors.red),
                  tooltip: 'Cerrar sesión',
                ),
              ],
            ),
          ),
        );
      },
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
              child: _buildMenuCard(
                context,
                'Cuentas Individuales',
                Icons.person,
                Colors.blue,
                () => Navigator.pushNamed(context, '/cuentasind'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildMenuCard(
                context,
                'Cuentas de Grupo',
                Icons.group,
                Colors.green,
                () => Navigator.pushNamed(context, '/cuentasgru'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDebtVisualizationSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Visualización de deudas',
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
              child: _buildMenuCard(
                context,
                'Gráfica de Deudas',
                Icons.bar_chart,
                Colors.orange,
                () => Navigator.pushNamed(context, '/grafica-deudas'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildMenuCard(
                context,
                'Historial Individual',
                Icons.history,
                Colors.purple,
                () => Navigator.pushNamed(context, '/historial-individual'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: _buildMenuCard(
                context,
                'Historial de Grupo',
                Icons.group_work,
                Colors.teal,
                () => Navigator.pushNamed(context, '/historial-grupo'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCircleButton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gestión de círculos',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 16),
        _buildMenuCard(
          context,
          'Mi Círculo',
          Icons.circle,
          Colors.indigo,
          () => Navigator.pushNamed(context, '/circulo'),
        ),
      ],
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.pushNamed(context, '/agregar-gasto');
      },
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      icon: const Icon(Icons.add),
      label: const Text(
        'Agregar Gasto',
        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      ),
    );
  }
}
