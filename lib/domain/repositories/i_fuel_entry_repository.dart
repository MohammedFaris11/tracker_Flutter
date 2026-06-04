import '../../data/models/fuel_entry_model.dart';

abstract class IFuelEntryRepository {
  Stream<List<FuelEntryModel>> getFuelEntries(String userId);
  Future<void> addFuelEntry(FuelEntryModel entry);
  Future<void> deleteFuelEntry(String id, String userId);
}
