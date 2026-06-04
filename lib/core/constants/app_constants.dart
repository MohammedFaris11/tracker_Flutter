class AppConstants {
  static const String appName = 'FuelTrack';
  static const String demoEmail = 'driver@test.com';
  static const String demoPassword = '1234';
  
  // Hive Boxes
  static const String vehicleBox = 'vehicles';
  static const String fuelEntryBox = 'fuel_entries';
  static const String maintenanceBox = 'maintenances';
  static const String maintenanceCategoryBox = 'maintenance_categories';
  
  // Storage Keys
  static const String userIdKey = 'userId';
}

class AppRoutes {
  static const String login = '/login';
  static const String dashboard = '/';
  static const String vehicleList = '/vehicles';
  static const String addVehicle = '/vehicles/add';
  static const String fuelEntryList = '/fuel';
  static const String addFuelEntry = '/fuel/add';
  static const String maintenanceList = '/maintenance';
  static const String addMaintenance = '/maintenance/add';
  static const String categoryList = '/categories';
  static const String addCategory = '/categories/add';
}
