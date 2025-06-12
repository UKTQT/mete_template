import 'package:com_nectrom_metetemplate/core/base/general_interceptor.dart';
import 'package:com_nectrom_metetemplate/core/managers/environment_manager.dart';
import 'package:dio/dio.dart';

class BaseService {
  static final BaseService instance = BaseService();

  final Dio dioClient = Dio()..interceptors.add(GeneralInterceptor());
  final String baseUrl = EnvironmentManager.serverIp;

  Future<T?> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      final uri = '$baseUrl$path';
      final response = await dioClient.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      if (response.data != null) {
        return fromJson(response.data);
      } else {
        throw Exception('Boş veri döndü!');
      }
    } on DioException {
      rethrow;
    }
  }

  Future<T?> post<T>({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      final uri = '$baseUrl$path';
      final response = await dioClient.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      if (response.data != null) {
        return fromJson(response.data);
      } else {
        throw Exception('Boş veri döndü!');
      }
    } on DioException {
      rethrow;
    }
  }

  Future<T?> put<T>({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      final uri = '$baseUrl$path';
      final response = await dioClient.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      if (response.data != null) {
        return fromJson(response.data);
      } else {
        throw Exception('Boş veri döndü!');
      }
    } on DioException {
      rethrow;
    }
  }

  Future<T?> delete<T>({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      final uri = '$baseUrl$path';
      final response = await dioClient.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      if (response.data != null) {
        return fromJson(response.data);
      } else {
        throw Exception('Boş veri döndü!');
      }
    } on DioException {
      rethrow;
    }
  }

  Future<T?> patch<T>({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      final uri = '$baseUrl$path';
      final response = await dioClient.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      if (response.data != null) {
        return fromJson(response.data);
      } else {
        throw Exception('Boş veri döndü!');
      }
    } on DioException {
      rethrow;
    }
  }

  Future<T?> head<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      final uri = '$baseUrl$path';
      final response = await dioClient.head(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      if (response.data != null) {
        return fromJson(response.data);
      } else {
        throw Exception('Boş veri döndü!');
      }
    } on DioException {
      rethrow;
    }
  }
}
