import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensesPieChart extends StatelessWidget {
  final Map<String, double> data;

  const ExpensesPieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.values.every((v) => v == 0)) {
      return const Center(child: Text('Aucune donnée de dépense'));
    }

    return AspectRatio(
      aspectRatio: 1.3,
      child: PieChart(
        PieChartData(
          sectionsSpace: 0,
          centerSpaceRadius: 40,
          sections: [
            PieChartSectionData(
              color: Colors.blue,
              value: data['gasoil'] ?? 0,
              title: 'Gasoil\n${(data['gasoil'] ?? 0).toStringAsFixed(0)} €',
              radius: 65,
              titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
            ),
            PieChartSectionData(
              color: Colors.orange,
              value: data['maintenance'] ?? 0,
              title: 'Maint.\n${(data['maintenance'] ?? 0).toStringAsFixed(0)} €',
              radius: 65,
              titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
