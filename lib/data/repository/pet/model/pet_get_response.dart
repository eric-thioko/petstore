class PetGetResponse {
    final double? id;
    final PetGetCategoryResponse? category;
    final String? name;
    final List<String>? photoUrls;
    final List<PetGetCategoryResponse>? tags;
    final String? status;

    PetGetResponse({
        this.id,
        this.category,
        this.name,
        this.photoUrls,
        this.tags,
        this.status,
    });

    factory PetGetResponse.fromJson(Map<String, dynamic> json) => PetGetResponse(
        id: json["id"]?.toDouble(),
        category: json["category"] != null
            ? PetGetCategoryResponse.fromJson(json["category"])
            : null,
        name: json["name"],
        photoUrls: json["photoUrls"] != null
            ? List<String>.from(json["photoUrls"].map((x) => x))
            : null,
        tags: json["tags"] != null
            ? List<PetGetCategoryResponse>.from(json["tags"].map((x) => PetGetCategoryResponse.fromJson(x)))
            : null,
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category": category?.toJson(),
        "name": name,
        "photoUrls": photoUrls != null ? List<dynamic>.from(photoUrls!.map((x) => x)) : null,
        "tags": tags != null ? List<dynamic>.from(tags!.map((x) => x.toJson())) : null,
        "status": status,
    };
}

class PetGetCategoryResponse {
    final double? id;
    final String? name;

    PetGetCategoryResponse({
        this.id,
        this.name,
    });

    factory PetGetCategoryResponse.fromJson(Map<String, dynamic> json) => PetGetCategoryResponse(
        id: json["id"]?.toDouble(),
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
