import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/fuel_entry_model.dart';
import '../data/repositories/fuel_entry_repository.dart';
import 'auth_provider.dart';

final fuelEntryRepositoryProvider = Provider<FuelEntryRepository>((ref) {
  return FuelEntryRepository();
});

final fuelEntriesProvider = StreamProvider<List<FuelEntryModel>>((ref) {
  final userId = ref.watch(userIdProvider);
  if (userId == null) return Stream.value([]);
  return ref.watch(fuelEntryRepositoryProvider).getFuelEntries(userId);
});
