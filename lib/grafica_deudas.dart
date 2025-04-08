import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraficaDeudasScreen extends StatelessWidget {
  const GraficaDeudasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo
    final List<Deuda> deudas = [
      Deuda('Kiki', 940.0, Colors.green),
      Deuda('Oddie', 523.0, Colors.green),
      Deuda('O\'Brien', -1158.0, Colors.red),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gráfica de Deudas',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[50],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLegendItem(Colors.green, 'Te deben'),
                    const SizedBox(width: 24),
                    _buildLegendItem(Colors.red, 'Les debes'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: BarChart(
                    BarChartData(
                      maxY: 1200,
                      minY: 0,
                      alignment: BarChartAlignment.spaceAround,
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        show: true,
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value >= deudas.length)
                                return const SizedBox();
                              final deuda = deudas[value.toInt()];
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '\$${deuda.monto.abs().toStringAsFixed(0)}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: deuda.color,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    deuda.persona,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              );
                            },
                            reservedSize: 50,
                          ),
                        ),
                      ),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: deudas.asMap().entries.map((entry) {
                        final index = entry.key;
                        final deuda = entry.value;
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: deuda.monto.abs(),
                              color: deuda.color.withOpacity(0.2),
                              width: 30,
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                width: 2,
                                color: deuda.color,
                              ),
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                toY: 1200,
                                color: Colors.grey[100],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color, width: 2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class Deuda {
  final String persona;
  final double monto;
  final Color color;

  Deuda(this.persona, this.monto, this.color);
}
