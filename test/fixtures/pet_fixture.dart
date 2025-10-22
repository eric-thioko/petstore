import 'package:petstore/data/repository/pet/model/pet_get_response.dart';
import 'package:petstore/domain/entity/category_entity.dart';
import 'package:petstore/domain/entity/pet/pet_entity.dart';
import 'package:petstore/domain/entity/tags_entity.dart';

class PetFixture {
  static PetEntity get testPet => const PetEntity(
        id: 1,
        name: 'Test Dog',
        category: CategoryEntity(id: 1, name: 'Dogs'),
        photoUrls: ['https://example.com/dog.jpg'],
        tags: [TagsEntity(id: 1, name: 'friendly')],
        status: 'available',
      );

  static PetEntity get testPet2 => const PetEntity(
        id: 2,
        name: 'Test Cat',
        category: CategoryEntity(id: 2, name: 'Cats'),
        photoUrls: ['https://example.com/cat.jpg'],
        tags: [TagsEntity(id: 2, name: 'cute')],
        status: 'available',
      );

  static List<PetEntity> get testPetList => [testPet, testPet2];

  static PetEntity get updatedPet => const PetEntity(
        id: 1,
        name: 'Updated Dog',
        category: CategoryEntity(id: 1, name: 'Dogs'),
        photoUrls: ['https://example.com/updated-dog.jpg'],
        tags: [
          TagsEntity(id: 1, name: 'friendly'),
          TagsEntity(id: 3, name: 'smart'),
        ],
        status: 'sold',
      );

  // Response objects for mocking data sources
  static PetGetResponse get testPetResponse => PetGetResponse(
        id: 1,
        name: 'Test Dog',
        category: PetGetCategoryResponse(id: 1, name: 'Dogs'),
        photoUrls: ['https://example.com/dog.jpg'],
        tags: [PetGetCategoryResponse(id: 1, name: 'friendly')],
        status: 'available',
      );

  static PetGetResponse get testPet2Response => PetGetResponse(
        id: 2,
        name: 'Test Cat',
        category: PetGetCategoryResponse(id: 2, name: 'Cats'),
        photoUrls: ['https://example.com/cat.jpg'],
        tags: [PetGetCategoryResponse(id: 2, name: 'cute')],
        status: 'available',
      );

  static List<PetGetResponse> get testPetResponseList => [
        testPetResponse,
        testPet2Response,
      ];
}
