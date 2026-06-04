import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_constants.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/fuel_entry_provider.dart';

class FuelEntryListScreen extends ConsumerWidget {
  const FuelEntryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(fuelEntriesProvider);
    final userId = ref.watch(userIdProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Historique des pleins')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.addFuelEntry),
        child: const Icon(Icons.add),
      ),
      body: entriesAsync.when(
        data: (entries) {
          if (entries.isEmpty) {
            return const Center(child: Text('Aucun plein enregistré.'));
          }
          final sorted = List.from(entries)..sort((a, b) => b.date.compareTo(a.date));
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sorted.length,
            itemBuilder: (context, index) {
              final e = sorted[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.ev_station, color: Colors.blue),
                  title: Text('${e.liters} L • ${e.amount} €'),
                  subtitle: Text('${e.vehicleName} • ${DateFormat('dd/MM/yyyy').format(e.date)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.grey),
                    onPressed: () => ref.read(fuelEntryRepositoryProvider).deleteFuelEntry(e.id, userId!),
                  ),
                ),
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
