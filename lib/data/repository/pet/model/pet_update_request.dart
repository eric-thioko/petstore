class PetUpdateRequest {
  final int id;
  final String name;
  final PetUpdateCategoryRequest category;
  final List<String> photoUrls;
  final List<PetUpdateTagsRequest> tags;
  final String status;

  PetUpdateRequest({
    required this.id,
    required this.name,
    required this.category,
    required this.photoUrls,
    required this.tags,
    required this.status,
  });

  factory PetUpdateRequest.fromJson(Map<String, dynamic> json) => PetUpdateRequest(
    id: json["id"],
    name: json["name"],
    category: PetUpdateCategoryRequest.fromJson(json["category"]),
    photoUrls: List<String>.from(json["photoUrls"].map((x) => x)),
    tags: List<PetUpdateTagsRequest>.from(
      json["tags"].map((x) => PetUpdateTagsRequest.fromJson(x)),
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

class PetUpdateCategoryRequest {
  final int id;
  final String name;

  PetUpdateCategoryRequest({required this.id, required this.name});

  factory PetUpdateCategoryRequest.fromJson(Map<String, dynamic> json) =>
      PetUpdateCategoryRequest(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class PetUpdateTagsRequest {
  final int id;
  final String name;

  PetUpdateTagsRequest({required this.id, required this.name});

  factory PetUpdateTagsRequest.fromJson(Map<String, dynamic> json) =>
      PetUpdateTagsRequest(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
