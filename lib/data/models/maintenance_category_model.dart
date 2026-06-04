import '../../domain/entities/maintenance_category_entity.dart';

class MaintenanceCategoryModel extends MaintenanceCategoryEntity {
  const MaintenanceCategoryModel({
    required super.id,
    required super.name,
    required super.userId,
  });

  factory MaintenanceCategoryModel.fromJson(Map<String, dynamic> json) {
    return MaintenanceCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'userId': userId,
    };
  }
}
