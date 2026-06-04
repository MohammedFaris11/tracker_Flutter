import '../../data/models/maintenance_category_model.dart';

abstract class IMaintenanceCategoryRepository {
  Stream<List<MaintenanceCategoryModel>> getCategories(String userId);
  Future<void> addCategory(MaintenanceCategoryModel category);
  Future<void> deleteCategory(String id, String userId);
}
