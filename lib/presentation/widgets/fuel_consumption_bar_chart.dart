import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FuelConsumptionBarChart extends StatelessWidget {
  final Map<String, double> data;

  const FuelConsumptionBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('Aucune donnée de consommation'));
    }

    final entries = data.entries.toList();
    final maxValue = data.values.isEmpty ? 0.0 : data.values.reduce((a, b) => a > b ? a : b);
    
    double interval = 1.0;
    double maxY = 10.0;
    
    if (maxValue <= 0) {
      interval = 2.0;
      maxY = 10.0;
    } else if (maxValue < 1.0) {
      interval = 0.2;
      maxY = 1.0;
    } else {
      final steps = [1.0, 2.0, 5.0, 10.0, 20.0, 50.0, 100.0, 200.0, 500.0, 1000.0, 2000.0, 5000.0, 10000.0];
      if (maxValue > 50000) {
        interval = (maxValue / 5).ceilToDouble();
      } else {
        for (final step in steps) {
          if (step * 5 >= maxValue) {
            interval = step;
            break;
          }
        }
      }
      final calculatedMaxY = (maxValue / interval).ceil() * interval;
      if (calculatedMaxY == maxValue) {
        maxY = calculatedMaxY + interval;
      } else {
        maxY = calculatedMaxY;
      }
    }

    return AspectRatio(
      aspectRatio: 1.7,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: interval,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.blueGrey.withValues(alpha: 0.15),
              strokeWidth: 1,
              dashArray: [5, 5],
            ),
          ),
          barGroups: List.generate(entries.length, (index) {
            final colors = [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
              const Color(0xFFF59E0B), // Amber
              const Color(0xFFF43F5E), // Rose
              const Color(0xFF8B5CF6), // Violet
              const Color(0xFF0EA5E9), // Light Blue
              const Color(0xFF10B981), // Emerald
            ];
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: entries[index].value,
                  color: colors[index % colors.length],
                  width: 16,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                ),
              ],
            );
          }),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: interval,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                      textAlign: TextAlign.right,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < entries.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        entries[value.toInt()].key,
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        ),
      ),
    );
  }
}

