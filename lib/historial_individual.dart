import 'package:flutter/material.dart';

class HistorialDeudasScreen extends StatelessWidget {
  final String personName;
  final String currentUser = 'Tú'; // Nombre del usuario actual

  const HistorialDeudasScreen({super.key, required this.personName});

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo
    final List<Map<String, dynamic>> transactions = [
      {
        'fecha': '2024-03-20',
        'descripcion': 'Cena en restaurante',
        'monto': 150.0,
        'pagadoPor': 'Tú',
        'deuda': 75.0,
      },
      {
        'fecha': '2024-03-18',
        'descripcion': 'Cine',
        'monto': 80.0,
        'pagadoPor': personName,
        'deuda': -40.0,
      },
      {
        'fecha': '2024-03-15',
        'descripcion': 'Supermercado',
        'monto': 200.0,
        'pagadoPor': 'Tú',
        'deuda': 100.0,
      },
    ];

    // Calcular balance total
    final double balanceTotal =
        transactions.fold(0, (sum, item) => sum + item['deuda']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Historial con $personName'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddTransactionDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Resumen de balance
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: balanceTotal > 0
                  ? Colors.green.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1),
              border: Border(
                bottom: BorderSide(
                  color: balanceTotal > 0
                      ? Colors.green.withOpacity(0.3)
                      : Colors.red.withOpacity(0.3),
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  balanceTotal > 0 ? Icons.arrow_upward : Icons.arrow_downward,
                  color: balanceTotal > 0 ? Colors.green : Colors.red,
                  size: 30,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        balanceTotal > 0
                            ? '$personName te debe'
                            : 'Le debes a $personName',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '\$${balanceTotal.abs().toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: balanceTotal > 0 ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Lista de transacciones
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                final isPositive = transaction['deuda'] > 0;

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isPositive
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      child: Icon(
                        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                        color: isPositive ? Colors.green : Colors.red,
                      ),
                    ),
                    title: Text(transaction['descripcion']),
                    subtitle: Text(
                      '${transaction['fecha']} • ${transaction['pagadoPor']} ${transaction['pagadoPor'] == 'Tú' ? 'pagaste' : 'pagó'}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: Text(
                      '\$${transaction['deuda'].abs().toStringAsFixed(2)}',
                      style: TextStyle(
                        color: isPositive ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () => _showTransactionDetails(context, transaction),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddTransactionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nueva transacción'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Monto total',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Pagado por',
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(
                    value: currentUser,
                    child: Text(currentUser),
                  ),
                  DropdownMenuItem(
                    value: personName,
                    child: Text(personName),
                  ),
                ],
                onChanged: (value) {},
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text('Cancelar', style: TextStyle(color: Colors.black)),
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica para guardar transacción
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Guardar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showTransactionDetails(
      BuildContext context, Map<String, dynamic> transaction) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detalles de la transacción'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Descripción: ${transaction['descripcion']}'),
            const SizedBox(height: 8),
            Text('Fecha: ${transaction['fecha']}'),
            const SizedBox(height: 8),
            Text('Monto total: \$${transaction['monto']}'),
            const SizedBox(height: 8),
            Text('Pagado por: ${transaction['pagadoPor']}'),
            const SizedBox(height: 8),
            Text(
              'Tu parte: \$${transaction['deuda'].abs()}',
              style: TextStyle(
                color: transaction['deuda'] > 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
