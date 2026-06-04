import '../../data/models/fuel_entry_model.dart';
import '../../data/models/maintenance_model.dart';

class GetExpensesByTypeUseCase {
  Map<String, double> call(List<FuelEntryModel> fuelEntries, List<MaintenanceModel> maintenances) {
    return {
      'gasoil': fuelEntries.fold(0.0, (s, e) => s + e.amount),
      'maintenance': maintenances.fold(0.0, (s, m) => s + m.amount),
    };
  }
}
