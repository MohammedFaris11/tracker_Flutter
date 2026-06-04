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

final selectedMonthProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month);
});

final expensesByTypeProvider = Provider<Map<String, double>>((ref) {
  final selectedMonth = ref.watch(selectedMonthProvider);
  final fuel = ref.watch(fuelEntriesProvider).value ?? [];
  final maint = ref.watch(maintenancesProvider).value ?? [];
  
  final filteredFuel = fuel.where((e) => e.date.year == selectedMonth.year && e.date.month == selectedMonth.month).toList();
  final filteredMaint = maint.where((e) => e.date.year == selectedMonth.year && e.date.month == selectedMonth.month).toList();
  
  return GetExpensesByTypeUseCase().call(filteredFuel, filteredMaint);
});

final fuelConsumptionByVehicleProvider = Provider<Map<String, double>>((ref) {
  final selectedMonth = ref.watch(selectedMonthProvider);
  final entries = ref.watch(fuelEntriesProvider).value ?? [];
  
  final filteredEntries = entries.where((e) => e.date.year == selectedMonth.year && e.date.month == selectedMonth.month).toList();
  return GetFuelConsumptionByVehicleUseCase().call(filteredEntries);
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
