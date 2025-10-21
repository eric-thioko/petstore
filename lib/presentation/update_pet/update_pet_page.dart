import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petstore/core/di/service_locator.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';
import 'package:petstore/domain/usecase/pet/pet_update.dart';
import 'package:petstore/presentation/update_pet/cubit/update_pet_cubit.dart';

class UpdatePetPage extends StatelessWidget {
  final PetEntity pet;

  const UpdatePetPage({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdatePetCubit(petUpdate: sl<PetUpdate>()),
      child: UpdatePetView(pet: pet),
    );
  }
}

class UpdatePetView extends StatefulWidget {
  final PetEntity pet;

  const UpdatePetView({super.key, required this.pet});

  @override
  State<UpdatePetView> createState() => _UpdatePetViewState();
}

class _UpdatePetViewState extends State<UpdatePetView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _categoryController;
  final _photoUrlController = TextEditingController();
  final _tagController = TextEditingController();

  late String _selectedStatus;
  late final List<String> _photoUrls;
  late final List<String> _tags;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.pet.name);
    _categoryController = TextEditingController(text: widget.pet.category.name);
    _selectedStatus = widget.pet.status;
    _photoUrls = List.from(widget.pet.photoUrls);
    _tags = widget.pet.tags.map((tag) => tag.name).toList();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _photoUrlController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  void _addPhotoUrl() {
    if (_photoUrlController.text.isNotEmpty) {
      setState(() {
        _photoUrls.add(_photoUrlController.text);
        _photoUrlController.clear();
      });
    }
  }

  void _addTag() {
    if (_tagController.text.isNotEmpty) {
      setState(() {
        _tags.add(_tagController.text);
        _tagController.clear();
      });
    }
  }

  void _removePhotoUrl(int index) {
    setState(() {
      _photoUrls.removeAt(index);
    });
  }

  void _removeTag(int index) {
    setState(() {
      _tags.removeAt(index);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<UpdatePetCubit>().updatePet(
            id: widget.pet.id,
            name: _nameController.text,
            categoryName: _categoryController.text,
            status: _selectedStatus,
            photoUrls: _photoUrls,
            tagNames: _tags,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Pet'),
      ),
      body: BlocConsumer<UpdatePetCubit, UpdatePetState>(
        listener: (context, state) {
          if (state.state.status.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Pet updated successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            context.pop();
          }

          if (state.state.status.isError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.state.failure?.errorMessage ?? 'Failed to update pet',
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.state.status.isLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pet Name
                  Text(
                    'Pet Name',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _nameController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: 'Enter pet name',
                    ),
                    enabled: !isLoading,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter pet name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Category
                  Text(
                    'Category',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _categoryController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: 'Enter category (e.g., Dog, Cat)',
                    ),
                    enabled: !isLoading,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter category';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Status
                  Text(
                    'Status',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedStatus,
                    decoration: const InputDecoration(
                      hintText: 'Select status',
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                    dropdownColor: Colors.white,
                    items: const [
                      DropdownMenuItem(
                        value: 'available',
                        child: Text(
                          'Available',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'pending',
                        child: Text(
                          'Pending',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'sold',
                        child: Text(
                          'Sold',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                    onChanged: isLoading
                        ? null
                        : (value) {
                            setState(() {
                              _selectedStatus = value!;
                            });
                          },
                  ),
                  const SizedBox(height: 24),

                  // Photo URLs Section
                  Text(
                    'Photo URLs',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _photoUrlController,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            hintText: 'Enter photo URL',
                          ),
                          enabled: !isLoading,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: isLoading ? null : _addPhotoUrl,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (_photoUrls.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      children: _photoUrls.asMap().entries.map((entry) {
                        return Chip(
                          label: Text('Photo ${entry.key + 1}'),
                          onDeleted: isLoading
                              ? null
                              : () => _removePhotoUrl(entry.key),
                        );
                      }).toList(),
                    ),
                  const SizedBox(height: 24),

                  // Tags Section
                  Text(
                    'Tags',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _tagController,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            hintText: 'Enter tag',
                          ),
                          enabled: !isLoading,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: isLoading ? null : _addTag,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (_tags.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      children: _tags.asMap().entries.map((entry) {
                        return Chip(
                          label: Text(entry.value),
                          onDeleted:
                              isLoading ? null : () => _removeTag(entry.key),
                        );
                      }).toList(),
                    ),
                  const SizedBox(height: 32),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submitForm,
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Update Pet'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
