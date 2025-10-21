import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';

class CartItem extends StatelessWidget {
  final PetEntity pet;
  final VoidCallback onDelete;

  const CartItem({
    super.key,
    required this.pet,
    required this.onDelete,
  });

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
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          tooltip: 'Remove from cart',
          onPressed: onDelete,
        ),
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
      ],
    );
  }
}
