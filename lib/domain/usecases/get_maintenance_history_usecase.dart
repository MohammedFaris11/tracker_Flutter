import 'package:flutter/material.dart';
import '../../data/models/maintenance_model.dart';

class GetMaintenanceHistoryUseCase {
  List<MaintenanceModel> call({
    required List<MaintenanceModel> allMaintenances,
    String? vehicleId,
    DateTimeRange? range,
  }) {
    var filtered = allMaintenances;
    if (vehicleId != null) {
      filtered = filtered.where((m) => m.vehicleId == vehicleId).toList();
    }
    if (range != null) {
      filtered = filtered.where((m) =>
          m.date.isAfter(range.start) &&
          m.date.isBefore(range.end)).toList();
    }
    return filtered;
  }
}
