import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/maintenance_category_model.dart';
import '../../../data/models/maintenance_model.dart';
import '../../../data/models/vehicle_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/maintenance_provider.dart';
import '../../../providers/vehicle_provider.dart';

class AddMaintenanceScreen extends ConsumerStatefulWidget {
  const AddMaintenanceScreen({super.key});

  @override
  ConsumerState<AddMaintenanceScreen> createState() => _AddMaintenanceScreenState();
}

class _AddMaintenanceScreenState extends ConsumerState<AddMaintenanceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  VehicleModel? _selectedVehicle;
  MaintenanceCategoryModel? _selectedCategory;

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate() && _selectedVehicle != null && _selectedCategory != null) {
      final userId = ref.read(userIdProvider);
      final maintenance = MaintenanceModel(
        id: const Uuid().v4(),
        vehicleId: _selectedVehicle!.id,
        vehicleName: _selectedVehicle!.name,
        categoryId: _selectedCategory!.id,
        categoryName: _selectedCategory!.name,
        description: _descriptionController.text,
        amount: double.parse(_amountController.text),
        date: DateTime.now(),
        userId: userId!,
      );

      await ref.read(maintenanceRepositoryProvider).addMaintenance(maintenance);
      if (mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final vehiclesAsync = ref.watch(vehiclesProvider);
    final categoriesAsync = ref.watch(maintenanceCategoriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter une maintenance')),
      body: vehiclesAsync.when(
        data: (vehicles) => categoriesAsync.when(
          data: (categories) {
            if (vehicles.isEmpty) return const Center(child: Text('Veuillez ajouter un véhicule d\'abord.'));
            if (categories.isEmpty) return const Center(child: Text('Veuillez ajouter une catégorie d\'abord.'));

            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  DropdownButtonFormField<VehicleModel>(
                    value: _selectedVehicle,
                    hint: const Text('Sélectionner un véhicule'),
                    items: vehicles.map((v) => DropdownMenuItem(value: v, child: Text(v.name))).toList(),
                    onChanged: (v) => setState(() => _selectedVehicle = v),
                    validator: (v) => v == null ? 'Champ requis' : null,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<MaintenanceCategoryModel>(
                    value: _selectedCategory,
                    hint: const Text('Sélectionner une catégorie'),
                    items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c.name))).toList(),
                    onChanged: (c) => setState(() => _selectedCategory = c),
                    validator: (v) => v == null ? 'Champ requis' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(labelText: 'Montant', suffixText: '€'),
                    keyboardType: TextInputType.number,
                    validator: (v) => v?.isEmpty ?? true ? 'Champ requis' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description (Optionnel)'),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Enregistrer'),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text('Erreur: $e')),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Erreur: $e')),
      ),
    );
  }
}
