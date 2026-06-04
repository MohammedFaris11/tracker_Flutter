import '../../domain/entities/maintenance_entity.dart';

class MaintenanceModel extends MaintenanceEntity {
  const MaintenanceModel({
    required super.id,
    required super.vehicleId,
    required super.vehicleName,
    required super.categoryId,
    required super.categoryName,
    required super.description,
    required super.amount,
    required super.date,
    required super.userId,
  });

  factory MaintenanceModel.fromJson(Map<String, dynamic> json) {
    return MaintenanceModel(
      id: json['id'] as String,
      vehicleId: json['vehicleId'] as String,
      vehicleName: json['vehicleName'] as String,
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicleId': vehicleId,
      'vehicleName': vehicleName,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'userId': userId,
    };
  }
}
