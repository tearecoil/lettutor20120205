import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioService {
  late Dio _dio;
  static final DioService _singleton = DioService._internal();

  factory DioService() {
    return _singleton;
  }

  DioService._internal() {
    initializeDio();
  }

  Future<void> initializeDio() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://sandbox.api.lettutor.com',
        connectTimeout: const Duration(seconds: 3000),
        receiveTimeout: const Duration(seconds: 3000),
        contentType: 'application/json',
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Do something before request is sent
          final prefs = await SharedPreferences.getInstance();
          String? accessToken = prefs.getString('access_token');
          if (accessToken != null) {
            options.headers['Authorization'] = "Bearer $accessToken";
          }
          return handler.next(options); // continue
        },
        onResponse: (response, handler) => handler.next(response),
        // ...
      ),
    );
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
  }) async {
    return _dio.get(
      url,
      data: data,
      queryParameters: params,
    );
  }

  Future<Response> post(
    String url, {
    dynamic data,
    String? contentType,
  }) async {
    return _dio.post(
      url,
      data: data,
      options: Options(
        contentType: contentType,
      ),
    );
  }

  Future<Response> put(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    return _dio.put(
      url,
      data: data,
    );
  }

  Future<Response> delete(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    return _dio.delete(
      url,
      data: data,
    );
  }
}
