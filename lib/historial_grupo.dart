import 'package:flutter/material.dart';

class HistorialGrupoScreen extends StatefulWidget {
  final String groupName;

  const HistorialGrupoScreen({super.key, required this.groupName});

  @override
  State<HistorialGrupoScreen> createState() => _HistorialGrupoScreenState();
}

class _HistorialGrupoScreenState extends State<HistorialGrupoScreen> {
  DateTime _selectedDate = DateTime.now();
  late List<Map<String, dynamic>> _allCompras;

  @override
  void initState() {
    super.initState();
    _allCompras = [
      {
        'fecha': '2025-04-02',
        'descripcion': 'Cena en restaurante',
        'total': 1200.00,
        'pagadoPor': 'Kiki',
        'participantes': ['Kiki', 'Oddie', 'O\'Brien'],
        'detalles': 'Cena de celebración de cumpleaños'
      },
      {
        'fecha': '2025-03-18',
        'descripcion': 'Supermercado',
        'total': 850.50,
        'pagadoPor': 'Oddie',
        'participantes': ['Kiki', 'Oddie', 'O\'Brien'],
        'detalles': 'Compra semanal de víveres'
      },
      {
        'fecha': '2025-03-15',
        'descripcion': 'Gasolina',
        'total': 500.00,
        'pagadoPor': 'O\'Brien',
        'participantes': ['Kiki', 'Oddie', 'O\'Brien'],
        'detalles': 'Gasolina para el viaje'
      },
      {
        'fecha': '2025-02-20',
        'descripcion': 'Cena en restaurante',
        'total': 1200.00,
        'pagadoPor': 'Kiki',
        'participantes': ['Kiki', 'Oddie', 'O\'Brien'],
        'detalles': 'Cena de celebración de cumpleaños'
      },
      {
        'fecha': '2025-02-18',
        'descripcion': 'Supermercado',
        'total': 850.50,
        'pagadoPor': 'Oddie',
        'participantes': ['Kiki', 'Oddie', 'O\'Brien'],
        'detalles': 'Compra semanal de víveres'
      },
      {
        'fecha': '2025-02-15',
        'descripcion': 'Gasolina',
        'total': 500.00,
        'pagadoPor': 'O\'Brien',
        'participantes': ['Kiki', 'Oddie', 'O\'Brien'],
        'detalles': 'Gasolina para el viaje'
      },
    ];
  }

  List<Map<String, dynamic>> get _filteredCompras {
    return _allCompras.where((compra) {
      final compraDate = DateTime.parse(compra['fecha']);
      return compraDate.year == _selectedDate.year &&
          compraDate.month == _selectedDate.month;
    }).toList();
  }

  double get _totalGastado {
    return _allCompras.fold(0.0, (sum, item) => sum + item['total']);
  }

  @override
  Widget build(BuildContext context) {
    final compras = _filteredCompras;
    final totalGastado = _totalGastado;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Historial de ${widget.groupName}',
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
                  'Resumen de ${widget.groupName}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Total gastado: \$${totalGastado.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Número de compras: ${_allCompras.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          // Selector de mes
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(
                        _selectedDate.year,
                        _selectedDate.month - 1,
                      );
                    });
                  },
                ),
                Text(
                  '${_getMonthName(_selectedDate.month)} ${_selectedDate.year}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(
                        _selectedDate.year,
                        _selectedDate.month + 1,
                      );
                    });
                  },
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
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre'
    ];
    return monthNames[month - 1];
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
}
