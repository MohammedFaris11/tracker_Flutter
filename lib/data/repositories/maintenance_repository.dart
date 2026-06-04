import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/i_maintenance_repository.dart';
import '../models/maintenance_model.dart';

class MaintenanceRepository implements IMaintenanceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference _getMaintenancesRef(String userId) {
    return _firestore.collection('users').doc(userId).collection('maintenances');
  }

  @override
  Stream<List<MaintenanceModel>> getMaintenances(String userId) {
    return _getMaintenancesRef(userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return MaintenanceModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  @override
  Future<void> addMaintenance(MaintenanceModel maintenance) async {
    await _getMaintenancesRef(maintenance.userId).doc(maintenance.id).set(maintenance.toJson());
  }

  @override
  Future<void> deleteMaintenance(String id, String userId) async {
    await _getMaintenancesRef(userId).doc(id).delete();
  }
}
