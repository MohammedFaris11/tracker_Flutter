import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/maintenance_category_model.dart';
import '../data/models/maintenance_model.dart';
import '../data/repositories/maintenance_category_repository.dart';
import '../data/repositories/maintenance_repository.dart';
import 'auth_provider.dart';

final maintenanceRepositoryProvider = Provider<MaintenanceRepository>((ref) {
  return MaintenanceRepository();
});

final maintenanceCategoryRepositoryProvider = Provider<MaintenanceCategoryRepository>((ref) {
  return MaintenanceCategoryRepository();
});

final maintenancesProvider = StreamProvider<List<MaintenanceModel>>((ref) {
  final userId = ref.watch(userIdProvider);
  if (userId == null) return Stream.value([]);
  return ref.watch(maintenanceRepositoryProvider).getMaintenances(userId);
});

final maintenanceCategoriesProvider = StreamProvider<List<MaintenanceCategoryModel>>((ref) {
  final userId = ref.watch(userIdProvider);
  if (userId == null) return Stream.value([]);
  return ref.watch(maintenanceCategoryRepositoryProvider).getCategories(userId);
});
