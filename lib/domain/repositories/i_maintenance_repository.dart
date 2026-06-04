import '../../data/models/maintenance_model.dart';

abstract class IMaintenanceRepository {
  Stream<List<MaintenanceModel>> getMaintenances(String userId);
  Future<void> addMaintenance(MaintenanceModel maintenance);
  Future<void> deleteMaintenance(String id, String userId);
}
