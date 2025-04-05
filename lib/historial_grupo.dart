import 'package:flutter/material.dart';

class HistorialGrupoScreen extends StatelessWidget {
  final String groupName;

  const HistorialGrupoScreen({super.key, required this.groupName});

  @override
  Widget build(BuildContext context) {
    // Lista de ejemplo de compras grupales
    final List<Map<String, dynamic>> compras = [
      {
        'fecha': '2024-03-15',
        'descripcion': 'Cena en restaurante',
        'total': 1200.00,
        'pagadoPor': 'Kiki',
        'participantes': ['Kiki', 'Oddie', 'O\'Brien'],
        'detalles': 'Cena de celebración de cumpleaños'
      },
      {
        'fecha': '2024-03-10',
        'descripcion': 'Supermercado',
        'total': 850.50,
        'pagadoPor': 'Oddie',
        'participantes': ['Kiki', 'Oddie', 'O\'Brien'],
        'detalles': 'Compra semanal de víveres'
      },
      {
        'fecha': '2024-03-05',
        'descripcion': 'Gasolina',
        'total': 500.00,
        'pagadoPor': 'O\'Brien',
        'participantes': ['Kiki', 'Oddie', 'O\'Brien'],
        'detalles': 'Gasolina para el viaje'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Historial de $groupName',
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Resumen del grupo
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resumen de $groupName',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Total gastado: \$${compras.fold(0.0, (sum, item) => sum + item['total']).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Número de compras: ${compras.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Lista de compras
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: compras.length,
              itemBuilder: (context, index) {
                final compra = compras[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      compra['descripcion'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          'Fecha: ${compra['fecha']}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Pagado por: ${compra['pagadoPor']}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Total: \$${compra['total'].toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _showCompraDetails(context, compra),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCompraDialog(context),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCompraDetails(BuildContext context, Map<String, dynamic> compra) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(compra['descripcion']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fecha: ${compra['fecha']}'),
            const SizedBox(height: 8),
            Text('Pagado por: ${compra['pagadoPor']}'),
            const SizedBox(height: 8),
            Text('Total: \$${compra['total'].toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            Text('Participantes: ${compra['participantes'].join(', ')}'),
            const SizedBox(height: 8),
            Text('Detalles: ${compra['detalles']}'),
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

  void _showAddCompraDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar nueva compra'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Descripción',
                hintText: 'Ej: Cena en restaurante',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Total',
                hintText: 'Ej: 1200.00',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Pagado por',
                hintText: 'Ej: Kiki',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Detalles',
                hintText: 'Ej: Cena de celebración',
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Aquí iría la lógica para guardar la nueva compra
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
