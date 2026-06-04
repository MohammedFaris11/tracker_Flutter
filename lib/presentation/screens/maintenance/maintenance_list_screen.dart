import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/dashboard_provider.dart';
import '../../../providers/maintenance_provider.dart';
import '../../../providers/vehicle_provider.dart';
import '../../widgets/maintenance_history_tile.dart';

class MaintenanceListScreen extends ConsumerWidget {
  const MaintenanceListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredMaintenances = ref.watch(filteredMaintenancesProvider);
    final vehiclesAsync = ref.watch(vehiclesProvider);
    final userId = ref.watch(userIdProvider);
    final selectedVehicleId = ref.watch(selectedVehicleIdProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Historique Maintenance')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.addMaintenance),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: vehiclesAsync.when(
              data: (vehicles) => DropdownButtonFormField<String?>(
                value: selectedVehicleId,
                decoration: const InputDecoration(labelText: 'Filtrer par véhicule'),
                items: [
                  const DropdownMenuItem(value: null, child: Text('Tous les véhicules')),
                  ...vehicles.map((v) => DropdownMenuItem(value: v.id, child: Text(v.name))),
                ],
                onChanged: (val) => ref.read(selectedVehicleIdProvider.notifier).state = val,
              ),
              loading: () => const LinearProgressIndicator(),
              error: (e, s) => const SizedBox.shrink(),
            ),
          ),
          Expanded(
            child: filteredMaintenances.isEmpty
                ? const Center(child: Text('Aucune maintenance trouvée.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredMaintenances.length,
                    itemBuilder: (context, index) {
                      final m = filteredMaintenances[index];
                      return MaintenanceHistoryTile(
                        maintenance: m,
                        onDelete: () => ref.read(maintenanceRepositoryProvider).deleteMaintenance(m.id, userId!),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
