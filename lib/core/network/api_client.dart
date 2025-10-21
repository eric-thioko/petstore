import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient({Dio? dio})
    : _dio = dio ?? Dio(BaseOptions(baseUrl: 'https://api.example.com')) {
    _dio.interceptors.addAll([
      // LogInterceptor(requestBody: true, responseBody: true),
      // InterceptorsWrapper(
      //   onRequest: (options, handler) {
      //     options.headers['Authorization'] = 'Bearer YOUR_ACCESS_TOKEN';
      //     return handler.next(options);
      //   },
      //   onResponse: (response, handler) {
      //     return handler.next(response);
      //   },
      //   onError: (DioException e, handler) {
      //     return handler.next(e);
      //   },
      // ),
    ]);
  }

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Object? data,
  }) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParams, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Object? data,
  }) async {
    try {
      return await _dio.post(
        endpoint,
        queryParameters: queryParams,
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> patch(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Object? data,
  }) async {
    try {
      return await _dio.patch(
        endpoint,
        queryParameters: queryParams,
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Object? data,
  }) async {
    try {
      return await _dio.put(endpoint, queryParameters: queryParams, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Object? data,
  }) async {
    try {
      return await _dio.delete(
        endpoint,
        queryParameters: queryParams,
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }
}
