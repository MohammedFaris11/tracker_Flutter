import '../../data/models/fuel_entry_model.dart';

class GetFuelConsumptionByVehicleUseCase {
  Map<String, double> call(List<FuelEntryModel> entries) {
    final Map<String, double> result = {};
    for (final e in entries) {
      result[e.vehicleName] = (result[e.vehicleName] ?? 0) + e.liters;
    }
    return result;
  }
}
