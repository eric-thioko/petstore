import 'package:equatable/equatable.dart';
import 'package:petstore/core/common/exception/failure.dart';

enum GenericState {
  initial,
  loading,
  error,
  success;

  bool get isLoading => this == GenericState.loading;

  bool get isNotLoading => this != GenericState.loading;

  bool get isInitial => this == GenericState.initial;

  bool get isError => this == GenericState.error;

  bool get isSuccess => this == GenericState.success;
}

class GenericDataState<T> extends Equatable {
  final GenericState status;
  final T? data;
  final String? message;

  final Failure? failure;

  const GenericDataState._({
    required this.status,
    this.data,
    this.message = "",
    this.failure,
  });

  factory GenericDataState.success({T? data, String? message}) {
    return GenericDataState._(
      status: GenericState.success,
      data: data,
      message: message,
    );
  }

  factory GenericDataState.error({
    T? data,
    String? message,
    Failure? failure,
  }) {
    return GenericDataState._(
      status: GenericState.error,
      data: data,
      message: message,
      failure: failure,
    );
  }

  factory GenericDataState.loading({String? message}) {
    return GenericDataState._(
      status: GenericState.loading,
      message: message,
    );
  }


  factory GenericDataState.initial() {
    return const GenericDataState._(
      status: GenericState.initial,
    );
  }

  @override
  List<Object?> get props => [
        status,
        data,
        message,
        failure
      ];

  GenericDataState<T> copyWith({
    GenericState? status,
    T? data,
    String? message,
  }) {
    return GenericDataState._(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }
}
