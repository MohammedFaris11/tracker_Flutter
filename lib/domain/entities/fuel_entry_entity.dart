class FuelEntryEntity {
  final String id;
  final String vehicleId;
  final String vehicleName;
  final double liters;
  final double amount;
  final DateTime date;
  final String userId;

  const FuelEntryEntity({
    required this.id,
    required this.vehicleId,
    required this.vehicleName,
    required this.liters,
    required this.amount,
    required this.date,
    required this.userId,
  });
}
