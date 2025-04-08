//circulo.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    );
  }
}

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<String> _groups = ['El Cantón', 'Escuela', 'Amigos'];
  final List<String> _people = ['Kiki', 'Oddie', 'O\'Brien'];

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  Future<void> _loadGroups() async {
    final prefs = await SharedPreferences.getInstance();
    final savedGroups = prefs.getStringList('groups') ?? _groups;
    setState(() {
      _groups = savedGroups;
    });
  }

  Future<void> _saveGroups() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('groups', _groups);
  }

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
              items: _groups
                  .map((group) => _GroupItem(
                        name: group,
                        route: '/${group.toLowerCase().replaceAll(' ', '-')}',
                      ))
                  .toList(),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
              items: _people
                  .map((person) => _GroupItem(
                        name: person,
                        route: '/${person.toLowerCase().replaceAll('\'', '')}',
                      ))
                  .toList(),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
          children: items
              .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _buildGroupButton(
                        context, item.name, icon, color, item.route),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildGroupButton(BuildContext context, String name, IconData icon,
      Color color, String route) {
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
    final TextEditingController groupNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nuevo grupo'),
        content: TextField(
          controller: groupNameController,
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
            onPressed: () async {
              final newGroupName = groupNameController.text.trim();
              if (newGroupName.isNotEmpty) {
                setState(() {
                  _groups.add(newGroupName);
                  Navigator.pop(context); 
                });
                await _saveGroups();
                if (!mounted) return;
                Navigator.pop(context); // Cerrar el diálogo
                Navigator.pop(context); // Cerrar la ventana actual
                Navigator.pushNamed(
                  context,
                  '/${newGroupName.toLowerCase().replaceAll(' ', '-')}',
                  arguments: newGroupName,
                );
              }
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
