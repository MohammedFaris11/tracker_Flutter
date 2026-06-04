import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/fuel_entry_model.dart';
import '../../../data/models/vehicle_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/fuel_entry_provider.dart';
import '../../../providers/vehicle_provider.dart';

class AddFuelEntryScreen extends ConsumerStatefulWidget {
  const AddFuelEntryScreen({super.key});

  @override
  ConsumerState<AddFuelEntryScreen> createState() => _AddFuelEntryScreenState();
}

class _AddFuelEntryScreenState extends ConsumerState<AddFuelEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _litersController = TextEditingController();
  final _amountController = TextEditingController();
  VehicleModel? _selectedVehicle;
  DateTime _selectedDate = DateTime.now();

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  void dispose() {
    _litersController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedVehicle != null) {
      final userId = ref.read(userIdProvider);
      final entry = FuelEntryModel(
        id: const Uuid().v4(),
        vehicleId: _selectedVehicle!.id,
        vehicleName: _selectedVehicle!.name,
        liters: double.parse(_litersController.text),
        amount: double.parse(_amountController.text),
        date: _selectedDate,
        userId: userId!,
      );

      // Fire and forget
      ref.read(fuelEntryRepositoryProvider).addFuelEntry(entry);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Plein enregistré !'), backgroundColor: Colors.green),
        );
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vehiclesAsync = ref.watch(vehiclesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un plein')),
      body: vehiclesAsync.when(
        data: (vehicles) {
          if (vehicles.isEmpty) {
            return const Center(child: Text('Veuillez ajouter un véhicule d\'abord.'));
          }
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
                TextFormField(
                  controller: _litersController,
                  decoration: const InputDecoration(labelText: 'Litres', suffixText: 'L'),
                  keyboardType: TextInputType.number,
                  validator: (v) => v?.isEmpty ?? true ? 'Champ requis' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _amountController,
                  decoration: const InputDecoration(labelText: 'Montant', suffixText: '€'),
                  keyboardType: TextInputType.number,
                  validator: (v) => v?.isEmpty ?? true ? 'Champ requis' : null,
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: _pickDate,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    child: Text(
                      "${_selectedDate.day.toString().padLeft(2, '0')}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.year}",
                    ),
                  ),
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
    );
  }
}
