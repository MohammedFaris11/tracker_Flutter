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

    final sections = <PieChartSectionData>[];
    
    final gasoilValue = data['gasoil'] ?? 0;
    if (gasoilValue > 0) {
      sections.add(
        PieChartSectionData(
          color: Theme.of(context).colorScheme.primary,
          value: gasoilValue,
          title: 'Gasoil\n${gasoilValue.toStringAsFixed(0)} €',
          radius: 65,
          titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        ),
      );
    }

    final maintenanceValue = data['maintenance'] ?? 0;
    if (maintenanceValue > 0) {
      sections.add(
        PieChartSectionData(
          color: Theme.of(context).colorScheme.secondary,
          value: maintenanceValue,
          title: 'Maint.\n${maintenanceValue.toStringAsFixed(0)} €',
          radius: 65,
          titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 1.3,
      child: PieChart(
        PieChartData(
          sectionsSpace: 0,
          centerSpaceRadius: 40,
          sections: sections,
        ),
      ),
    );
  }
}

