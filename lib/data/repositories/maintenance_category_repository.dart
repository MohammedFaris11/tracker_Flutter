import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/i_maintenance_category_repository.dart';
import '../models/maintenance_category_model.dart';

class MaintenanceCategoryRepository implements IMaintenanceCategoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference _getCategoriesRef(String userId) {
    return _firestore.collection('users').doc(userId).collection('maintenance_categories');
  }

  @override
  Stream<List<MaintenanceCategoryModel>> getCategories(String userId) {
    return _getCategoriesRef(userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return MaintenanceCategoryModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  @override
  Future<void> addCategory(MaintenanceCategoryModel category) async {
    await _getCategoriesRef(category.userId).doc(category.id).set(category.toJson());
  }

  @override
  Future<void> deleteCategory(String id, String userId) async {
    await _getCategoriesRef(userId).doc(id).delete();
  }
}
