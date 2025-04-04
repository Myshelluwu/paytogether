//usuarios.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Círculo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Users(),
        '/el-cantón': (context) => const GroupScreen(groupName: 'El Cantón'),
        '/escuela': (context) => const GroupScreen(groupName: 'Escuela'),
        '/amigos': (context) => const GroupScreen(groupName: 'Amigos'),
        '/kiki': (context) => const PersonScreen(personName: 'Kiki'),
        '/oddie': (context) => const PersonScreen(personName: 'Oddie'),
        '/obrien': (context) => const PersonScreen(personName: 'O\'Brien'),
      },
    );
  }
}

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mi círculo',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección de Grupos
            _buildSection(
              context: context,
              title: "Grupos",
              subtitle: "Administra tus grupos",
              items: const [
                _GroupItem(name: 'El Cantón', route: '/el-cantón'),
                _GroupItem(name: 'Escuela', route: '/escuela'),
                _GroupItem(name: 'Amigos', route: '/amigos'),
              ],
              icon: Icons.group,
              color: Colors.blue,
            ),

            const SizedBox(height: 24),

            Center(
              child: ElevatedButton.icon(
                onPressed: () => _showAddGroupDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                label: const Text('Crear nuevo grupo'),
              ),
            ),

            const SizedBox(height: 32),

            // Sección de Personas
            _buildSection(
              context: context,
              title: "Personas",
              subtitle: "Personas en mi círculo",
              items: const [
                _GroupItem(name: 'Kiki', route: '/kiki'),
                _GroupItem(name: 'Oddie', route: '/oddie'),
                _GroupItem(name: 'O\'Brien', route: '/obrien'),
              ],
              icon: Icons.person,
              color: Colors.green,
            ),

            const SizedBox(height: 24),

            // Botón para agregar nueva persona
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _showAddPersonDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                label: const Text('Añadir persona'),
              ),
            ),
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
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 16),

        // Lista de elementos en columna
        Column(
          children: items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildGroupButton(context, item.name, icon, color, item.route),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildGroupButton(BuildContext context, String name, IconData icon, Color color, String route) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => Navigator.pushNamed(context, route),
        style: OutlinedButton.styleFrom(
          alignment: Alignment.centerLeft,
          backgroundColor: color.withOpacity(0.05),
          foregroundColor: color,
          side: BorderSide(color: color.withOpacity(0.3)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 12),
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showAddGroupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nuevo grupo'),
        content: TextField(
          decoration: InputDecoration(
            labelText: 'Nombre del grupo',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica para añadir grupo
              Navigator.pop(context);
            },
            child: const Text('Crear'),
          ),
        ],
      ),
    );
  }

  void _showAddPersonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Añadir persona'),
        content: TextField(
          decoration: InputDecoration(
            labelText: 'Nombre de la persona',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica para añadir persona
              Navigator.pop(context);
            },
            child: const Text('Añadir'),
          ),
        ],
      ),
    );
  }
}

class _GroupItem {
  final String name;
  final String route;

  const _GroupItem({required this.name, required this.route});
}

class GroupScreen extends StatelessWidget {
  final String groupName;

  const GroupScreen({super.key, required this.groupName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.group, size: 60, color: Colors.blue),
            const SizedBox(height: 20),
            Text(
              'Pantalla del grupo: $groupName',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}

class PersonScreen extends StatelessWidget {
  final String personName;

  const PersonScreen({super.key, required this.personName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(personName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 60, color: Colors.green),
            const SizedBox(height: 20),
            Text(
              'Pantalla de: $personName',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}