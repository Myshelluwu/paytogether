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

class GroupScreen extends StatelessWidget {
  final String groupName;

  const GroupScreen({super.key, required this.groupName});

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo
    final List<String> members = ['Kiki', 'Oddie', 'O\'Brien'];
    final double totalBalance = 1500.0;
    final int totalExpenses = 5;

    return Scaffold(
      appBar: AppBar(
        title: Text(groupName),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditGroupDialog(context, groupName),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Encabezado del grupo
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                border: Border(
                  bottom: BorderSide(color: Colors.blue.withOpacity(0.3)),
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.group, size: 40, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          groupName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$totalExpenses gastos • Balance: \$$totalBalance',
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

            // Sección de miembros
            _buildInfoSection(
              title: 'Miembros',
              icon: Icons.people,
              items: members
                  .map((member) => ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text(member),
                        subtitle: const Text('Miembro'),
                        onTap: () => Navigator.pushNamed(context,
                            '/${member.toLowerCase().replaceAll('\'', '')}'),
                      ))
                  .toList(),
            ),

            // Sección de gastos recientes
            _buildInfoSection(
              title: 'Gastos recientes',
              icon: Icons.receipt_long,
              items: [
                ListTile(
                  leading: const Icon(Icons.restaurant),
                  title: const Text('Cena'),
                  subtitle: const Text('Hace 2 días'),
                  trailing: const Text('\$150'),
                  onTap: () => _showExpenseDetails(context),
                ),
                ListTile(
                  leading: const Icon(Icons.movie),
                  title: const Text('Cine'),
                  subtitle: const Text('Hace 5 días'),
                  trailing: const Text('\$80'),
                  onTap: () => _showExpenseDetails(context),
                ),
              ],
            ),

            // Botón para eliminar grupo
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: () => _showConfirmDeleteDialog(context),
                icon: const Icon(Icons.delete),
                label: const Text('Eliminar grupo'),
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
              Icon(icon, color: Colors.blue),
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

  void _showEditGroupDialog(BuildContext context, String currentName) {
    final TextEditingController nameController =
        TextEditingController(text: currentName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar grupo'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del grupo',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica para guardar cambios
              Navigator.pop(context);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _showExpenseDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detalles del gasto'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Descripción: Cena'),
            SizedBox(height: 8),
            Text('Monto: \$150'),
            SizedBox(height: 8),
            Text('Fecha: 2024-03-20'),
            SizedBox(height: 8),
            Text('Pagado por: Kiki'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _showConfirmDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar grupo'),
        content:
            Text('¿Estás seguro de que quieres eliminar el grupo $groupName?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica para eliminar grupo
              Navigator.pop(context); // Cerrar diálogo
              Navigator.pop(context); // Regresar a la pantalla anterior
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}
