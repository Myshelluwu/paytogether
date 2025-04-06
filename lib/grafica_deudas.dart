import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraficaDeudasScreen extends StatelessWidget {
  const GraficaDeudasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo
    final List<Deuda> deudas = [
      Deuda('Kiki', 150.0, Colors.green),
      Deuda('Oddie', -75.0, Colors.red),
      Deuda('O\'Brien', 100.0, Colors.green),
    ];

    // Ordenar por valor absoluto y tomar las 3 mayores
    deudas.sort((a, b) => b.monto.abs().compareTo(a.monto.abs()));
    final topDeudas = deudas.take(3).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Top 3 Deudas',
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
            const Text(
              'Solo se visualizan las 3 personas con mayores deudas',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: topDeudas
                          .map((e) => e.monto.abs())
                          .reduce((a, b) => a > b ? a : b) *
                      1.2,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.grey[800],
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '\$${rod.toY.toStringAsFixed(2)}',
                          const TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              topDeudas[value.toInt()].persona,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: topDeudas.asMap().entries.map((entry) {
                    final index = entry.key;
                    final deuda = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: deuda.monto.abs(),
                          color: deuda.color,
                          width: 20,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Leyenda:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                const Text('Te deben'),
                const SizedBox(width: 16),
                Container(
                  width: 20,
                  height: 20,
                  color: Colors.red,
                ),
                const SizedBox(width: 8),
                const Text('Les debes'),
              ],
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
