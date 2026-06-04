import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/vehicle_model.dart';
import '../data/repositories/vehicle_repository.dart';
import 'auth_provider.dart';

final vehicleRepositoryProvider = Provider<VehicleRepository>((ref) {
  return VehicleRepository();
});

final vehiclesProvider = StreamProvider<List<VehicleModel>>((ref) {
  final userId = ref.watch(userIdProvider);
  if (userId == null) return Stream.value([]);
  return ref.watch(vehicleRepositoryProvider).getVehicles(userId);
});
