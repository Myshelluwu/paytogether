//circulo.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<String> _groups = ['El Cantón', 'Escuela', 'Amigos'];
  List<String> _people = ['Kiki', 'Oddie', 'O\'Brien'];
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await _loadData();
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      print('Error al inicializar: $e');
    }
  }

  Future<void> _loadData() async {
    await _loadGroups();
    await _loadPeople();
  }

  Future<void> _loadGroups() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedGroups = prefs.getStringList('groups');
      if (savedGroups != null && savedGroups.isNotEmpty) {
        setState(() {
          _groups = savedGroups;
        });
      }
    } catch (e) {
      print('Error al cargar grupos: $e');
    }
  }

  Future<void> _loadPeople() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedPeople = prefs.getStringList('people');
      if (savedPeople != null && savedPeople.isNotEmpty) {
        setState(() {
          _people = savedPeople;
        });
      }
    } catch (e) {
      print('Error al cargar personas: $e');
    }
  }

  Future<void> _saveGroups() async {
    if (!_isInitialized) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('groups', _groups);
    } catch (e) {
      print('Error al guardar grupos: $e');
    }
  }

  Future<void> _savePeople() async {
    if (!_isInitialized) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('people', _people);
    } catch (e) {
      print('Error al guardar personas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return WillPopScope(
      onWillPop: () async {
        await _saveGroups();
        await _savePeople();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mi círculo',
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
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
                    .map(
                      (group) => _GroupItem(
                        name: group,
                        route: '/${group.toLowerCase().replaceAll(' ', '-')}',
                      ),
                    )
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
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
                    .map(
                      (person) => _GroupItem(
                        name: person,
                        route: '/${person.toLowerCase().replaceAll('\'', '')}',
                      ),
                    )
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  label: const Text('Añadir persona'),
                ),
              ),
            ],
          ),
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
        Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 16),
        ...items,
      ],
    );
  }

  void _showAddGroupDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Crear nuevo grupo'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Nombre del grupo',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  _groups.add(controller.text.trim());
                });
                _saveGroups();
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Crear', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showAddPersonDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Añadir persona'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Nombre de la persona',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  _people.add(controller.text.trim());
                });
                _savePeople();
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Añadir', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _GroupItem extends StatelessWidget {
  final String name;
  final String route;

  const _GroupItem({required this.name, required this.route});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.withOpacity(0.2),
          child: Text(
            name[0].toUpperCase(),
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
