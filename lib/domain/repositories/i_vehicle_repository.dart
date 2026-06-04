import '../../data/models/vehicle_model.dart';

abstract class IVehicleRepository {
  Stream<List<VehicleModel>> getVehicles(String userId);
  Future<void> addVehicle(VehicleModel vehicle);
  Future<void> deleteVehicle(String id, String userId);
}
