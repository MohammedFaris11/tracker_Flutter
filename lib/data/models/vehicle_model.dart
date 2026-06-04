import '../../domain/entities/vehicle_entity.dart';

class VehicleModel extends VehicleEntity {
  const VehicleModel({
    required super.id,
    required super.name,
    required super.brand,
    required super.licensePlate,
    required super.userId,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String,
      licensePlate: json['licensePlate'] as String,
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'licensePlate': licensePlate,
      'userId': userId,
    };
  }
}
