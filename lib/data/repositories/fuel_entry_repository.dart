import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/i_fuel_entry_repository.dart';
import '../models/fuel_entry_model.dart';

class FuelEntryRepository implements IFuelEntryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference _getEntriesRef(String userId) {
    return _firestore.collection('users').doc(userId).collection('fuel_entries');
  }

  @override
  Stream<List<FuelEntryModel>> getFuelEntries(String userId) {
    return _getEntriesRef(userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return FuelEntryModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  @override
  Future<void> addFuelEntry(FuelEntryModel entry) async {
    await _getEntriesRef(entry.userId).doc(entry.id).set(entry.toJson());
  }

  @override
  Future<void> deleteFuelEntry(String id, String userId) async {
    await _getEntriesRef(userId).doc(id).delete();
  }
}
