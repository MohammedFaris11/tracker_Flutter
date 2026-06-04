import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/maintenance_category_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/maintenance_provider.dart';

class AddMaintenanceCategoryScreen extends ConsumerStatefulWidget {
  const AddMaintenanceCategoryScreen({super.key});

  @override
  ConsumerState<AddMaintenanceCategoryScreen> createState() => _AddMaintenanceCategoryScreenState();
}

class _AddMaintenanceCategoryScreenState extends ConsumerState<AddMaintenanceCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final userId = ref.read(userIdProvider);
      final category = MaintenanceCategoryModel(
        id: const Uuid().v4(),
        name: _nameController.text,
        userId: userId!,
      );

      await ref.read(maintenanceCategoryRepositoryProvider).addCategory(category);
      if (mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter une catégorie')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nom de la catégorie (ex: Vidange)'),
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
