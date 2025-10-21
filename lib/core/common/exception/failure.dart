// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String errorMessage;
  final Map<String, dynamic> errorResponse;
  final int errorCode;
  final StackTrace? stackTrace;

  const Failure({
    this.errorMessage = "General Failure",
    this.errorResponse = const {},
    this.errorCode = 0,
    this.stackTrace,
  });

  @override
  List<Object?> get props => [
    errorMessage,
    errorResponse,
    errorCode,
    stackTrace,
  ];
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.errorMessage = "Network Failure",
    super.errorResponse,
    super.errorCode = 504,
    super.stackTrace,
  });
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({
    super.errorMessage = "Timeout Failure",
    super.errorResponse,
    super.errorCode = 504,
    super.stackTrace,
  });
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.errorMessage = "Timeout Failure",
    super.errorResponse,
    super.errorCode = 504,
    super.stackTrace,
  });
}

class NoConnectionFailure extends Failure {
  const NoConnectionFailure({
    super.errorMessage = "Network Failure",
    super.errorResponse,
    super.errorCode = 504,
    super.stackTrace,
  });
}
