// grupo.dart
import 'package:flutter/material.dart';

class Grupo extends StatelessWidget {
  const Grupo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mi círculo',
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
            // Sección de Grupos
            _buildSection(
              title: "Grupos",
              subtitle: "Administra tus grupos",
              items: const ["El Cantón", "Escuela", "Amigos"],
              icon: Icons.group
              ,
              color: Colors.blue,
              isColumn: true, // Nueva propiedad para controlar la disposición
            ),

            const SizedBox(height: 24),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Acción para crear nuevo grupo
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                ),
                icon: const Icon(Icons.add,
                color: Colors.white,),
                label: const Text('Crear nuevo grupo'),
              ),
            ),

            const SizedBox(height: 32),

            // Sección de Personas
            _buildSection(
              title: "Personas",
              subtitle: "Personas en mi círculo",
              items: const ["Kiki", "Oddie", "O'Brien"],
              icon: Icons.person,
              color: Colors.green,
              isColumn: true, // Nueva propiedad para controlar la disposición
            ),

            const SizedBox(height: 24),

            // Botón para agregar nueva persona
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Acción para agregar nueva persona
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                ),
                icon: const Icon(Icons.person_add, color: Colors.white,),
                label: const Text('Añadir persona'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String subtitle,
    required List<String> items,
    required IconData icon,
    required Color color,
    bool isColumn = false, // Nueva propiedad
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
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

        // Lista de elementos - ahora en columna si isColumn es true
        isColumn
            ? Column(
                children: items
                    .map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _buildItem(item, icon, color),
                        ))
                    .toList(),
              )
            : Wrap(
                spacing: 12,
                runSpacing: 12,
                children: items.map((item) => _buildItem(item, icon, color)).toList(),
              ),
      ],
    );
  }

  Widget _buildItem(String name, IconData icon, Color color) {
    return Container(
      width: double.infinity, // Ocupa todo el ancho disponible
      child: OutlinedButton(
        onPressed: () {},
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 12),
            Text(
              name,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}