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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Leyenda: ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.3),
                    border: Border.all(color: Colors.green),
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Te deben',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.3),
                    border: Border.all(color: Colors.red),
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Les debes',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: 1200,
                  minY: 0,
                  alignment: BarChartAlignment.spaceAround,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value >= deudas.length) return const SizedBox();
                          return Text(
                            deudas[value.toInt()].persona,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                        reservedSize: 50,
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
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
                          color: deuda.color.withOpacity(0.3),
                          width: 25,
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            width: 1,
                            color: deuda.color,
                          ),
                        ),
                      ],
                      showingTooltipIndicators: [0],
                    );
                  }).toList(),
                  extraLinesData: ExtraLinesData(
                    horizontalLines: deudas.asMap().entries.map((entry) {
                      final index = entry.key;
                      final deuda = entry.value;
                      return HorizontalLine(
                        y: index.toDouble(),
                        color: Colors.transparent,
                        label: HorizontalLineLabel(
                          show: true,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(right: 5),
                          style: TextStyle(
                            color: deuda.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          labelResolver: (line) =>
                              '\$${deuda.monto.abs().toStringAsFixed(0)}',
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Deuda {
  final String persona;
  final double monto;
  final Color color;

  Deuda(this.persona, this.monto, this.color);
}
