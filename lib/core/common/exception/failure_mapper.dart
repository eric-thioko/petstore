import 'package:dio/dio.dart';
import 'package:petstore/core/common/exception/failure.dart';

Failure mapExceptionToFailure(Object exception, StackTrace stackTrace) {
  if (exception is DioException) {
    final data = exception.response?.data;
    final errorResponse =
        data is Map<String, dynamic>
            ? ErrorResponse.fromJson(data)
            : ErrorResponse(error: "Unknown error");
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutFailure(
          errorMessage: 'Request timeout, please try again.',
          errorCode: exception.response?.statusCode ?? 0,
          errorResponse: exception.response?.data,
          stackTrace: stackTrace,
        );
      case DioExceptionType.badResponse:
        if (exception.response?.statusCode == 401) {
          return UnauthorizedFailure(
            errorMessage:
                errorResponse.error ??
                'Unauthorized access. Please log in again.',
            errorCode: exception.response?.statusCode ?? 0,
            errorResponse: exception.response?.data,
            stackTrace: stackTrace,
          );
        }
        return NetworkFailure(
          errorMessage:
              errorResponse.error ??
              'Network error: ${exception.response?.statusMessage}',
          errorCode: exception.response?.statusCode ?? 0,
          errorResponse: exception.response?.data,
          stackTrace: stackTrace,
        );
      case DioExceptionType.connectionError:
        return NoConnectionFailure(errorMessage: 'No internet connection.');
      default:
        return Failure(
          errorCode: 0,
          errorMessage: "General Failure",
          errorResponse: {"error": exception.toString()},
          stackTrace: stackTrace,
        );
    }
  } else {
    return Failure(
      errorCode: 0,
      errorMessage: "General Failure",
      errorResponse: {"error": exception.toString()},
      stackTrace: stackTrace,
    );
  }
}

class ErrorResponse {
  final String? error;

  ErrorResponse({this.error});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      ErrorResponse(error: json["error"] ?? "");

  Map<String, dynamic> toJson() => {"error": error};
}
