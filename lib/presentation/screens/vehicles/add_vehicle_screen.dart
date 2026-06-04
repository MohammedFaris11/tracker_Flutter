import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/vehicle_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/vehicle_provider.dart';

class AddVehicleScreen extends ConsumerStatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  ConsumerState<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends ConsumerState<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _plateController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _plateController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final userId = ref.read(userIdProvider);
      final vehicle = VehicleModel(
        id: const Uuid().v4(),
        name: _nameController.text,
        brand: _brandController.text,
        licensePlate: _plateController.text,
        userId: userId!,
      );

      await ref.read(vehicleRepositoryProvider).addVehicle(vehicle);
      if (mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un véhicule')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nom (ex: Ma Peugeot)'),
              validator: (v) => v?.isEmpty ?? true ? 'Champ requis' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _brandController,
              decoration: const InputDecoration(labelText: 'Marque'),
              validator: (v) => v?.isEmpty ?? true ? 'Champ requis' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _plateController,
              decoration: const InputDecoration(labelText: 'Plaque d\'immatriculation'),
              validator: (v) => v?.isEmpty ?? true ? 'Champ requis' : null,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
