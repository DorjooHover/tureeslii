import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../shared/index.dart';

class DioProvider extends GetxService {
  final isProduction = const bool.fromEnvironment('dart.vm.product');
  var dio = Dio();
  final storage = GetStorage();
  @override
  void onInit() {
    dio.options.baseUrl =
        isProduction ? 'https://tureeslii.mn/api' : 'https://tureeslii.mn/api';

    dio.interceptors.addAll(
      [
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            // get token from storage
            final token = storage.read(StorageKeys.token.name);
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            } else {}
            return handler.next(options);
          },
        ),
        // RetryOnConnectionChangeInterceptor()
        // LogInterceptor(responseBody: true),
      ],
    );
    super.onInit();
  }

  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on Exception {
      rethrow;
    }
  }

  Future<dynamic> post(String path,
      {Map<String, dynamic>? data, Options? options}) async {
    try {
      final response = await dio.post(path, data: data, options: options);

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.put(path, data: data);
      return response.data;
    } on Exception {
      rethrow;
    }
  }

  Future<dynamic> patch(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.patch(path, data: data);
      return response.data;
    } on Exception {
      rethrow;
    }
  }

  Future<dynamic> delete(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.delete(path, data: data);
      return response.data;
    } on Exception {
      rethrow;
    }
  }
}
