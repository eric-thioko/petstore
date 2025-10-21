class PetAddRequest {
  final int id;
  final String name;
  final PetAddCategoryRequest category;
  final List<String> photoUrls;
  final List<PetAddTagsRequest> tags;
  final String status;

  PetAddRequest({
    required this.id,
    required this.name,
    required this.category,
    required this.photoUrls,
    required this.tags,
    required this.status,
  });

  factory PetAddRequest.fromJson(Map<String, dynamic> json) => PetAddRequest(
    id: json["id"],
    name: json["name"],
    category: PetAddCategoryRequest.fromJson(json["category"]),
    photoUrls: List<String>.from(json["photoUrls"].map((x) => x)),
    tags: List<PetAddTagsRequest>.from(
      json["tags"].map((x) => PetAddTagsRequest.fromJson(x)),
    ),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "category": category.toJson(),
    "photoUrls": List<dynamic>.from(photoUrls.map((x) => x)),
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    "status": status,
  };
}

class PetAddCategoryRequest {
  final int id;
  final String name;

  PetAddCategoryRequest({required this.id, required this.name});

  factory PetAddCategoryRequest.fromJson(Map<String, dynamic> json) =>
      PetAddCategoryRequest(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class PetAddTagsRequest {
  final int id;
  final String name;

  PetAddTagsRequest({required this.id, required this.name});

  factory PetAddTagsRequest.fromJson(Map<String, dynamic> json) =>
      PetAddTagsRequest(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
