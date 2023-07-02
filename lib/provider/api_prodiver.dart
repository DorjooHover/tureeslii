import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/provider/dio_provider.dart';

class ApiRepository {
  ApiRepository({required this.apiProvider});

  final DioProvider apiProvider;
  Future<User> getUser() async {
    try {
      final response =
          await apiProvider.get('/user/me') as Map<String, dynamic>;

      return User.fromJson(response);
    } on Exception {
      rethrow;
    }
  }
  // Future<LoginResponse> login(String phone, String password) async {
  //   final data = {"phone": phone, "password": password};
  //   final res = await apiProvider.post('/auth/login', data: data);

  //   return LoginResponse.fromJson(res);
  // }

  // Future<List<Service>> servicesList() async {
  //   try {
  //     final response = await apiProvider.get('/service');
  //     final services =
  //         (response as List).map((e) => Service.fromJson(e)).toList();
  //     return services;
  //   } on Exception {
  //     rethrow;
  //   }
  // }
}
