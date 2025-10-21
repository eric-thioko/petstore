class PetDeleteRequest {
  final String header;
  final int petId;

  PetDeleteRequest({this.header = "special-key", required this.petId});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'header': header,
      'petId': petId,
    };
  }

  factory PetDeleteRequest.fromJson(Map<String, dynamic> map) {
    return PetDeleteRequest(
      header: map['header'] as String,
      petId: map['petId'] as int,
    );
  }
}
