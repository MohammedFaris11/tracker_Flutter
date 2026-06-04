class MaintenanceEntity {
  final String id;
  final String vehicleId;
  final String vehicleName;
  final String categoryId;
  final String categoryName;
  final String description;
  final double amount;
  final DateTime date;
  final String userId;

  const MaintenanceEntity({
    required this.id,
    required this.vehicleId,
    required this.vehicleName,
    required this.categoryId,
    required this.categoryName,
    required this.description,
    required this.amount,
    required this.date,
    required this.userId,
  });
}
