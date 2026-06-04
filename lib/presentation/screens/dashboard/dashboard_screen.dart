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

    final totalExpenses = expenses.values.fold<double>(0, (sum, val) => sum + val);

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Statistiques', style: Theme.of(context).textTheme.titleLarge),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () {
                        final current = ref.read(selectedMonthProvider);
                        ref.read(selectedMonthProvider.notifier).state = DateTime(current.year, current.month - 1);
                      },
                    ),
                    Text(
                      "${_getMonthName(ref.watch(selectedMonthProvider).month)} ${ref.watch(selectedMonthProvider).year}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () {
                        final current = ref.read(selectedMonthProvider);
                        ref.read(selectedMonthProvider.notifier).state = DateTime(current.year, current.month + 1);
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              color: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total des dépenses',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${totalExpenses.toStringAsFixed(2)} €',
                      style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Dépenses par catégorie', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 16),
                    ExpensesPieChart(data: expenses),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Consommation par véhicule (L)', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 16),
                    FuelConsumptionBarChart(data: consumption),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context.push(AppRoutes.addFuelEntry),
              icon: const Icon(Icons.local_gas_station),
              label: const Text('Ajouter un plein'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => context.push(AppRoutes.addMaintenance),
              icon: const Icon(Icons.build),
              label: const Text('Ajouter une maintenance'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
                foregroundColor: Theme.of(context).colorScheme.secondary,
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
      'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
    ];
    return months[month - 1];
  }
}
