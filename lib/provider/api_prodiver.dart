import 'package:dio/dio.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/provider/dio_provider.dart';

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
      rethrow;
    }
  }

  Future<bool> register(
    String email,
    String password,
  ) async {
    try {
      final data = {"password": password, "isCreator": false, "email": email};
      await apiProvider.post('/auth/register', data: data);

      return true;
    } on DioException catch (e) {
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      final res =
          await apiProvider.post('/auth/forgotpwd', data: {"username": email});
      print(res);
      return true;
    } on DioException catch (e) {
      return false;
    }
  }

  Future<bool> verifyForgotPassword(
      String password, String code, String email) async {
    try {
      final data = {
        "password": password,
        "password_verify": code,
        "email_code": email
      };
      await apiProvider.post('/auth/changepwdforgot', data: data);
      return true;
    } on DioException catch (e) {
      return false;
    }
  }

  Future<bool> savePersonal(
      String lastname, String firstname, String phone) async {
    try {
      final data = {
        "lastname": lastname,
        "firstname": firstname,
        "phone": phone
      };

      final res = await apiProvider.put('/user', data: data);
      print(res);
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
      print(response);
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

  Future<ErrorHandler> rentRequest(
      int postId, int startDate, int duration) async {
    try {
      final data = {
        "postId": postId,
        "startDate": startDate,
        "duration": duration,
      };
      final response = await apiProvider.post('/posts/rentRequest', data: data);
      print(response);
      if (response['success']) {
        return ErrorHandler(success: true, message: 'Ажмилттай');
      }
      if (response['message'] == 'please_confirm_email') {
        return ErrorHandler(
            message: 'Имайл хаягаа баталгаажуулна уу.', success: false);
      }
      if (response['message'] == 'please_verify_mobile') {
        return ErrorHandler(
            message: 'Утасны дугаараа баталгаажуулна уу.', success: false);
      }
      if (response['message'] == 'start date error') {
        return ErrorHandler(
            message: 'Эхлэх огноо алдаатай байна.', success: false);
      }
      if (response['message'] == 'Энэ хугацаанд түрээслэх боломжгүй байна') {
        return ErrorHandler(
            message: 'Энэ хугацаанд түрээслэх боломжгүй байна.',
            success: false);
      }
      return ErrorHandler(message: 'Алдаа гарлаа', success: false);
    } on DioException catch (e) {
      throw Exception('Алдаа');
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
      print(response);
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

  Future<bool> updateUser(User user) async {
    try {
      final data = {
        "birthdate": user.birthdate,
        "gender": user.gender,
        "rentPersonCount": user.rentPersonCount,
        "job": user.job,
        "jobTitle": user.jobTitle,
        "profession": user.profession,
        "payType": user.payType,
        "incomeAmount": user.incomeAmount,
        "description": user.description,
      };
      await apiProvider.put('/user', data: data);
      return true;
    } on DioException catch (e) {
      return false;
    }
  }
}
