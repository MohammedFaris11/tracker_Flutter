import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/maintenance_model.dart';
import '../domain/usecases/get_expenses_by_type_usecase.dart';
import '../domain/usecases/get_fuel_consumption_by_vehicle_usecase.dart';
import '../domain/usecases/get_maintenance_history_usecase.dart';
import 'fuel_entry_provider.dart';
import 'maintenance_provider.dart';

final selectedVehicleIdProvider = StateProvider<String?>((ref) => null);
final dateRangeProvider = StateProvider<DateTimeRange?>((ref) => null);

final expensesByTypeProvider = Provider<Map<String, double>>((ref) {
  final fuel = ref.watch(fuelEntriesProvider).value ?? [];
  final maint = ref.watch(maintenancesProvider).value ?? [];
  return GetExpensesByTypeUseCase().call(fuel, maint);
});

final fuelConsumptionByVehicleProvider = Provider<Map<String, double>>((ref) {
  final entries = ref.watch(fuelEntriesProvider).value ?? [];
  return GetFuelConsumptionByVehicleUseCase().call(entries);
});

final filteredMaintenancesProvider = Provider<List<MaintenanceModel>>((ref) {
  final all = ref.watch(maintenancesProvider).value ?? [];
  final vehicleId = ref.watch(selectedVehicleIdProvider);
  final range = ref.watch(dateRangeProvider);
  return GetMaintenanceHistoryUseCase().call(
    allMaintenances: all,
    vehicleId: vehicleId,
    range: range,
  );
});
