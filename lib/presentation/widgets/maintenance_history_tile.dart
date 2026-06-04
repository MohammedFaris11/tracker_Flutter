import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/maintenance_model.dart';

class MaintenanceHistoryTile extends StatelessWidget {
  final MaintenanceModel maintenance;
  final VoidCallback? onDelete;

  const MaintenanceHistoryTile({
    super.key,
    required this.maintenance,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.orangeAccent,
          child: Icon(Icons.build, color: Colors.white),
        ),
        title: Text(maintenance.categoryName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(maintenance.vehicleName),
            Text(
              DateFormat('dd/MM/yyyy').format(maintenance.date),
              style: const TextStyle(fontSize: 12),
            ),
            if (maintenance.description.isNotEmpty)
              Text(
                maintenance.description,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${maintenance.amount.toStringAsFixed(2)} €',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
            if (onDelete != null)
              GestureDetector(
                onTap: onDelete,
                child: const Icon(Icons.delete, size: 20, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
