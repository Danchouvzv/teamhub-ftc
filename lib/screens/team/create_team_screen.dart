import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class CreateTeamScreen extends StatefulWidget {
  const CreateTeamScreen({super.key});

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ftcNumberController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _schoolController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ftcNumberController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _schoolController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleCreate() {
    if (_formKey.currentState!.validate()) {
      // TODO: Create team
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Команда создана!')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать команду'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Team name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Название команды *',
                  prefixIcon: Icon(Icons.group),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите название команды';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // FTC number
              TextFormField(
                controller: _ftcNumberController,
                decoration: const InputDecoration(
                  labelText: 'Номер FTC',
                  prefixIcon: Icon(Icons.numbers),
                  helperText: 'Опционально',
                ),
              ),
              const SizedBox(height: 16),
              // Country
              TextFormField(
                controller: _countryController,
                decoration: const InputDecoration(
                  labelText: 'Страна *',
                  prefixIcon: Icon(Icons.public),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите страну';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // City
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'Город *',
                  prefixIcon: Icon(Icons.location_city),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите город';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // School
              TextFormField(
                controller: _schoolController,
                decoration: const InputDecoration(
                  labelText: 'Школа / Организация',
                  prefixIcon: Icon(Icons.school),
                  helperText: 'Опционально',
                ),
              ),
              const SizedBox(height: 16),
              // Description
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Описание команды',
                  prefixIcon: Icon(Icons.description),
                  helperText: 'Опционально',
                ),
              ),
              const SizedBox(height: 32),
              // Create button
              ElevatedButton(
                onPressed: _handleCreate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Создать команду',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

