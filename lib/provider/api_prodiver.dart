import 'package:dio/dio.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/provider/dio_provider.dart';

class ApiRepository {
  ApiRepository({required this.apiProvider});

  final DioProvider apiProvider;
  // auth
  getUser() async {
    try {
      final response = await apiProvider.get('/auth/user');
      return User.fromJson(response['data']);
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<User> login(String username, String password) async {
    try {
      final data = {"username": username, "password": password};
      print(data);
      final res = await apiProvider.post('/auth/login', data: data);
      print(res);
      return User.fromJson(res['data']);
    } on DioException catch (e) {
      if (e.response!.statusCode == 401 && e.response?.data['message'] != "") {
        throw Exception('Нэвтрэх нэр эсвэл нууц үг буруу байна');
      }
      if (e.response!.statusCode == 401) {
        throw Exception('Та Нэвтрэх нэр, нууц үгээ оруулна уу');
      }
      print(e.response);
      rethrow;
    }
  }

  Future<bool> register(String email, String password, String mobile,
      String firstname, String lastname) async {
    try {
      final data = {
        "password": password,
        "isCreator": true,
        "mobile": mobile,
        "firstname": firstname,
        "lastname": lastname,
        "email": email
      };
      await apiProvider.post('/auth/register', data: data);

      return true;
    } on DioException catch (e) {
      return false;
    }
  }

  Future<bool> sendEmailVerifyCode() async {
    try {
      await apiProvider.get('/auth/requestVerifyCode');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> verifyEmailCode(String code) async {
    try {
      final data = {"code": code};
      final res = await apiProvider.post('/auth/verifyEmail', data: data);
      return res['success'];
    } on DioException catch (e) {
      throw Exception("Алдаа гарлаа");
    }
  }

  // posts
  Future<List<Post>> getAllPosts(int? skip, int? take, SortData? sortData,
      List<FilterData>? filterData) async {
    try {
      final data = {
        "skip": skip ?? 0,
        "take": take ?? 12,
        "sortData": sortData ?? {},
        "filterData": filterData ?? [],
      };
      final response = await apiProvider.post('/posts/getPosts', data: data);
      return (response['data'] as List).map((e) => Post.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.response?.data["success"] == false) {
        throw Exception("Дахии оролдоно уу");
      } else {
        throw Exception("Алдаа гарлаа");
      }
    }
  }

  getSavedPosts() async {
    try {
      final response = await apiProvider.get(
        '/posts/getSavedPosts',
      );
      return (response['data'] as List).map((e) => Post.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.response?.data["success"] == false) {
        throw Exception("Дахии оролдоно уу");
      } else {
        throw Exception("Алдаа гарлаа");
      }
    }
  }

  saveBookmark(int postId) async {
    try {
      final data = {"postId": postId};
      final response =
          await apiProvider.post('/posts/saveBookmark', data: data);
      return true;
    } on DioException catch (e) {
      print(e.response);
      if (e.response?.data["success"] == false) {
        throw Exception("Дахии оролдоно уу");
      } else {
        throw Exception("Алдаа гарлаа");
      }
    }
  }

  removeBookmark(int postId) async {
    try {
      final response = await apiProvider.delete(
        '/posts/removeBookmark/$postId',
      );
      return true;
    } on DioException catch (e) {
      if (e.response?.data["success"] == false) {
        throw Exception("Дахии оролдоно уу");
      } else {
        throw Exception("Алдаа гарлаа");
      }
    }
  }

  Future<void> rentRequest(int postId, String startDate, int duration) async {
    try {
      final data = {
        "postId": postId,
        "startDate": startDate,
        "duration": duration,
      };
      final response = await apiProvider.post('/posts/rentRequest', data: data);
      return response;
    } on DioException catch (e) {
      throw Exception("Алдаа гарлаа");
    }
  }

  getOwnPosts(int? skip, int? take, SortData? sortData,
      List<FilterData>? filterData) async {
    try {
      final data = {
        "skip": skip ?? 0,
        "take": take ?? 12,
        "sortData": sortData ?? {},
        "filterData": filterData ?? [],
      };
      final response = await apiProvider.post('/posts/getOwnPosts', data: data);
      return (response as List).map((e) => Post.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.response?.data["success"] == false) {
        throw Exception("Дахии оролдоно уу");
      } else {
        throw Exception("Алдаа гарлаа");
      }
    }
  }

// notification
  Future<List<Notifications>> getAllNotification() async {
    try {
      final response = await apiProvider.get('/notification');

      return (response as List).map((e) => Notifications.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception("Алдаа гарлаа");
    }
  }

  // users
  Future<void> changePassword(String password, String newPassword) async {
    try {
      final data = {'oldPassword': password, 'password': newPassword};
      return await apiProvider.put('/user/password', data: data);
    } on DioException catch (e) {
      throw Exception("Алдаа гарлаа");
    }
  }
}
