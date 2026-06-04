import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/maintenance_provider.dart';

class MaintenanceCategoryListScreen extends ConsumerWidget {
  const MaintenanceCategoryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(maintenanceCategoriesProvider);
    final userId = ref.watch(userIdProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Catégories de Maintenance')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.addCategory),
        child: const Icon(Icons.add),
      ),
      body: categoriesAsync.when(
        data: (categories) {
          if (categories.isEmpty) {
            return const Center(child: Text('Aucune catégorie.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final c = categories[index];
              return Card(
                child: ListTile(
                  title: Text(c.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.grey),
                    onPressed: () => ref.read(maintenanceCategoryRepositoryProvider).deleteCategory(c.id, userId!),
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
