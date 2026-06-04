import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/dashboard_provider.dart';
import '../../../providers/vehicle_provider.dart';
import '../../widgets/expenses_pie_chart.dart';
import '../../widgets/fuel_consumption_bar_chart.dart';
import '../../widgets/vehicle_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehiclesAsync = ref.watch(vehiclesProvider);
    final expenses = ref.watch(expensesByTypeProvider);
    final consumption = ref.watch(fuelConsumptionByVehicleProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FuelTrack Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authRepositoryProvider).logout(),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_gas_station, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text('FuelTrack', style: TextStyle(color: Colors.white, fontSize: 24)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.directions_car),
              title: const Text('Véhicules'),
              onTap: () {
                context.pop();
                context.push(AppRoutes.vehicleList);
              },
            ),
            ListTile(
              leading: const Icon(Icons.ev_station),
              title: const Text('Pleins Carburant'),
              onTap: () {
                context.pop();
                context.push(AppRoutes.fuelEntryList);
              },
            ),
            ListTile(
              leading: const Icon(Icons.build),
              title: const Text('Maintenances'),
              onTap: () {
                context.pop();
                context.push(AppRoutes.maintenanceList);
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Catégories Maintenance'),
              onTap: () {
                context.pop();
                context.push(AppRoutes.categoryList);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mes Véhicules', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            vehiclesAsync.when(
              data: (vehicles) {
                if (vehicles.isEmpty) {
                  return const Text('Aucun véhicule ajouté.');
                }
                return SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: vehicles.length,
                    itemBuilder: (context, index) {
                      final v = vehicles[index];
                      return Container(
                        width: 200,
                        margin: const EdgeInsets.only(right: 8),
                        child: VehicleCard(vehicle: v),
                      );
                    },
                  ),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (e, s) => Text('Erreur: $e'),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Dépenses', style: Theme.of(context).textTheme.titleMedium),
                      ExpensesPieChart(data: expenses),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Consommation (L)', style: Theme.of(context).textTheme.titleMedium),
                      FuelConsumptionBarChart(data: consumption),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context.push(AppRoutes.addFuelEntry),
              icon: const Icon(Icons.add),
              label: const Text('Ajouter un plein'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => context.push(AppRoutes.addMaintenance),
              icon: const Icon(Icons.add_road),
              label: const Text('Ajouter une maintenance'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade50, foregroundColor: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
