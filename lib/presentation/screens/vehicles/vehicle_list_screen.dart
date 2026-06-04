import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/vehicle_provider.dart';
import '../../widgets/vehicle_card.dart';

class VehicleListScreen extends ConsumerWidget {
  const VehicleListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehiclesAsync = ref.watch(vehiclesProvider);
    final userId = ref.watch(userIdProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mes Véhicules')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.addVehicle),
        child: const Icon(Icons.add),
      ),
      body: vehiclesAsync.when(
        data: (vehicles) {
          if (vehicles.isEmpty) {
            return const Center(child: Text('Aucun véhicule.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final v = vehicles[index];
              return VehicleCard(
                vehicle: v,
                onDelete: () {
                  ref.read(vehicleRepositoryProvider).deleteVehicle(v.id, userId!);
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Erreur: $e')),
      ),
    );
  }
}
