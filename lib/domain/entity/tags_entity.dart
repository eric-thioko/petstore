import 'package:equatable/equatable.dart';

class TagsEntity extends Equatable {
  final int id;
  final String name;

  const TagsEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
