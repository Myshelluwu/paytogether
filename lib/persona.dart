import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.account_balance_wallet,
              size: 100,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
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
              child: const Text('PayTogether'),
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
    // Datos de ejemplo
    final List<String> groups = ['El Cantón', 'Amigos'];
    final String email = '${personName.toLowerCase()}@example.com';
    final String phone = '+1 555-555-5555';

    return Scaffold(
      appBar: AppBar(
        title: Text(personName),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditPersonDialog(context, personName),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Encabezado de la persona
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                border: Border(
                  bottom: BorderSide(color: Colors.green.withOpacity(0.3)),
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person, size: 40),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          personName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Miembro de ${groups.length} grupos',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Sección de información de contacto
            _buildInfoSection(
              title: 'Información de contacto',
              icon: Icons.contact_page,
              items: [
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Teléfono'),
                  subtitle: Text(phone),
                  onTap: () => _callNumber(context, phone),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email'),
                  subtitle: Text(email),
                  onTap: () => _sendEmail(context, email),
                ),
                ListTile(
                  leading: const Icon(Icons.account_balance_wallet),
                  title: const Text('Historial de deudas'),
                  subtitle: const Text('Ver transacciones y saldos'),
                  onTap: () => Navigator.pushNamed(context,
                      '/historial-${personName.toLowerCase().replaceAll('\'', '')}'),
                ),
              ],
            ),

            // Sección de grupos
            _buildInfoSection(
              title: 'Grupos',
              icon: Icons.group,
              items: groups
                  .map((group) => ListTile(
                        leading: const Icon(Icons.group),
                        title: Text(group),
                        onTap: () => Navigator.pushNamed(context,
                            '/${group.toLowerCase().replaceAll(' ', '-')}'),
                      ))
                  .toList(),
            ),

            // Botón para eliminar persona
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: () => _showConfirmDeleteDialog(context),
                label: const Text('Eliminar persona'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required IconData icon,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Row(
            children: [
              Icon(icon, color: Colors.green),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ...items,
      ],
    );
  }

  void _showEditPersonDialog(BuildContext context, String currentName) {
    final TextEditingController nameController =
        TextEditingController(text: currentName);
    final TextEditingController emailController =
        TextEditingController(text: '${currentName.toLowerCase()}@example.com');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar persona'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.black),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica para guardar cambios
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text(
              'Guardar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar persona'),
        content: Text(
            '¿Estás seguro de que quieres eliminar a $personName de tu círculo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.black),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica para eliminar persona
              Navigator.pop(context); // Cerrar diálogo
              Navigator.pop(context); // Regresar a la pantalla anterior
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text(
              'Eliminar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _callNumber(BuildContext context, String phone) {
    // Implementa la lógica para llamar al número
  }

  void _sendEmail(BuildContext context, String email) {
    // Implementa la lógica para enviar un correo electrónico
  }
}
