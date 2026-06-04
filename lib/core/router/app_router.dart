import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_constants.dart';
import '../../providers/auth_provider.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/dashboard/dashboard_screen.dart';
import '../../presentation/screens/vehicles/vehicle_list_screen.dart';
import '../../presentation/screens/vehicles/add_vehicle_screen.dart';
import '../../presentation/screens/fuel/fuel_entry_list_screen.dart';
import '../../presentation/screens/fuel/add_fuel_entry_screen.dart';
import '../../presentation/screens/maintenance/maintenance_list_screen.dart';
import '../../presentation/screens/maintenance/add_maintenance_screen.dart';
import '../../presentation/screens/categories/maintenance_category_list_screen.dart';
import '../../presentation/screens/categories/add_maintenance_category_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authAsync = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: _RouterNotifier(ref),
    redirect: (context, state) {
      if (authAsync.isLoading) return null;

      final isLoggedIn = authAsync.value ?? false;
      final isLoginPage = state.matchedLocation == AppRoutes.login;

      if (!isLoggedIn && !isLoginPage) return AppRoutes.login;
      if (isLoggedIn && isLoginPage) return AppRoutes.dashboard;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.vehicleList,
        builder: (context, state) => const VehicleListScreen(),
      ),
      GoRoute(
        path: AppRoutes.addVehicle,
        builder: (context, state) => const AddVehicleScreen(),
      ),
      GoRoute(
        path: AppRoutes.fuelEntryList,
        builder: (context, state) => const FuelEntryListScreen(),
      ),
      GoRoute(
        path: AppRoutes.addFuelEntry,
        builder: (context, state) => const AddFuelEntryScreen(),
      ),
      GoRoute(
        path: AppRoutes.maintenanceList,
        builder: (context, state) => const MaintenanceListScreen(),
      ),
      GoRoute(
        path: AppRoutes.addMaintenance,
        builder: (context, state) => const AddMaintenanceScreen(),
      ),
      GoRoute(
        path: AppRoutes.categoryList,
        builder: (context, state) => const MaintenanceCategoryListScreen(),
      ),
      GoRoute(
        path: AppRoutes.addCategory,
        builder: (context, state) => const AddMaintenanceCategoryScreen(),
      ),
    ],
  );
});

class _RouterNotifier extends ChangeNotifier {
  _RouterNotifier(Ref ref) {
    ref.listen(authStateProvider, (_, __) => notifyListeners());
  }
}
