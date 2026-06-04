import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/i_vehicle_repository.dart';
import '../models/vehicle_model.dart';

class VehicleRepository implements IVehicleRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference _getVehiclesRef(String userId) {
    return _firestore.collection('users').doc(userId).collection('vehicles');
  }

  @override
  Stream<List<VehicleModel>> getVehicles(String userId) {
    return _getVehiclesRef(userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return VehicleModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  @override
  Future<void> addVehicle(VehicleModel vehicle) async {
    await _getVehiclesRef(vehicle.userId).doc(vehicle.id).set(vehicle.toJson());
  }

  @override
  Future<void> deleteVehicle(String id, String userId) async {
    await _getVehiclesRef(userId).doc(id).delete();
  }
}
