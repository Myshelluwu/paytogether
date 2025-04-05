import 'package:flutter/material.dart';

class HistorialDeudasScreen extends StatefulWidget {
  final String personName;
  final String currentUser = 'Tú';

  const HistorialDeudasScreen({super.key, required this.personName});

  @override
  State<HistorialDeudasScreen> createState() => _HistorialDeudasScreenState();
}

class _HistorialDeudasScreenState extends State<HistorialDeudasScreen> {
  DateTime _selectedDate = DateTime.now();
  late List<Map<String, dynamic>> _allTransactions;

  @override
  void initState() {
    super.initState();
    _allTransactions = [
      {
        'fecha': '2025-04-02',
        'descripcion': 'Cena en restaurante',
        'monto': 150.0,
        'pagadoPor': 'Tú',
        'deuda': 75.0,
      },
      {
        'fecha': '2025-03-18',
        'descripcion': 'Cine',
        'monto': 80.0,
        'pagadoPor': widget.personName,
        'deuda': -40.0,
      },
      {
        'fecha': '2025-03-15',
        'descripcion': 'Supermercado',
        'monto': 200.0,
        'pagadoPor': 'Tú',
        'deuda': 100.0,
      },
      {
        'fecha': '2025-02-20',
        'descripcion': 'Cena en restaurante',
        'monto': 150.0,
        'pagadoPor': 'Tú',
        'deuda': 75.0,
      },
      {
        'fecha': '2025-02-18',
        'descripcion': 'Cine',
        'monto': 80.0,
        'pagadoPor': widget.personName,
        'deuda': -40.0,
      },
      {
        'fecha': '2025-02-15',
        'descripcion': 'Supermercado',
        'monto': 200.0,
        'pagadoPor': 'Tú',
        'deuda': 100.0,
      },
    ];
  }

  List<Map<String, dynamic>> get _filteredTransactions {
    return _allTransactions.where((transaction) {
      final transactionDate = DateTime.parse(transaction['fecha']);
      return transactionDate.year == _selectedDate.year &&
          transactionDate.month == _selectedDate.month;
    }).toList();
  }

  double get _totalBalance {
    return _allTransactions.fold(0, (sum, item) => sum + item['deuda']);
  }

  @override
  Widget build(BuildContext context) {
    final transactions = _filteredTransactions;
    final balanceTotal = _totalBalance;

    return Scaffold(
      appBar: AppBar(
        title: Text('Historial con ${widget.personName}'),
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
                            ? '${widget.personName} te debe'
                            : 'Le debes a ${widget.personName}',
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
