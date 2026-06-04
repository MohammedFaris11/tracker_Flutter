import '../../domain/entities/fuel_entry_entity.dart';

class FuelEntryModel extends FuelEntryEntity {
  const FuelEntryModel({
    required super.id,
    required super.vehicleId,
    required super.vehicleName,
    required super.liters,
    required super.amount,
    required super.date,
    required super.userId,
  });

  factory FuelEntryModel.fromJson(Map<String, dynamic> json) {
    return FuelEntryModel(
      id: json['id'] as String,
      vehicleId: json['vehicleId'] as String,
      vehicleName: json['vehicleName'] as String,
      liters: (json['liters'] as num).toDouble(),
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
      'liters': liters,
      'amount': amount,
      'date': date.toIso8601String(),
      'userId': userId,
    };
  }
}
