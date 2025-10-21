import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:petstore/core/router/routes.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';
import 'package:petstore/presentation/home/cubit/home_cubit.dart';

class PetCard extends StatelessWidget {
  final PetEntity pet;
  final VoidCallback onDeletePressed;

  const PetCard({
    super.key,
    required this.pet,
    required this.onDeletePressed,
  });

  Future<void> _handleEdit(BuildContext context) async {
    await context.push(Routes.updatePet, extra: pet);
    if (context.mounted) {
      context.read<HomeCubit>().getPet();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: _buildLeadingImage(),
        title: Text(
          pet.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: _buildSubtitle(),
        trailing: _buildActions(context),
        isThreeLine: true,
      ),
    );
  }

  Widget _buildLeadingImage() {
    if (pet.photoUrls.isEmpty) {
      return const Icon(Icons.pets, size: 40);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: pet.photoUrls.first,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
        errorWidget: (_, __, ___) => const Icon(Icons.pets, size: 40),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Category: ${pet.category.name}'),
        Text('Status: ${pet.status}'),
        if (pet.tags.isNotEmpty) _buildTags(),
      ],
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 4,
      children: pet.tags
          .map(
            (tag) => Chip(
              label: Text(
                tag.name,
                style: const TextStyle(fontSize: 10),
              ),
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
            ),
          )
          .toList(),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          tooltip: 'Add to Cart',
          onPressed: () => context.read<HomeCubit>().addToCart(pet),
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          tooltip: 'Edit',
          onPressed: () => _handleEdit(context),
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          tooltip: 'Delete',
          onPressed: onDeletePressed,
        ),
      ],
    );
  }
}
