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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Simular carga de datos
      await Future.delayed(const Duration(seconds: 1));

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
    } catch (e) {
      // Manejar errores aquí
      print('Error al cargar transacciones: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Historial con ${widget.personName}')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
              SizedBox(height: 16),
              Text(
                'Cargando historial...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      );
    }

    final transactions = _filteredTransactions;
    final balanceTotal = _totalBalance;

    return Scaffold(
      appBar: AppBar(title: Text('Historial con ${widget.personName}')),
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
              border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
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
                    fontSize: 18,
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
            child: transactions.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.receipt_long, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'No hay transacciones en este mes',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      final isPositive = transaction['deuda'] > 0;

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isPositive
                                ? Colors.green.withOpacity(0.2)
                                : Colors.red.withOpacity(0.2),
                            child: Icon(
                              isPositive
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              color: isPositive ? Colors.green : Colors.red,
                            ),
                          ),
                          title: Text(
                            transaction['descripcion'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pagado por: ${transaction['pagadoPor']}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Fecha: ${_formatDate(transaction['fecha'])}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$${transaction['monto'].toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                isPositive
                                    ? '+${transaction['deuda'].toStringAsFixed(2)}'
                                    : transaction['deuda'].toStringAsFixed(2),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isPositive ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
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
    const months = [
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
      'Diciembre',
    ];
    return months[month - 1];
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
