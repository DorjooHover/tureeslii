import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/shared/constants/enums.dart';

class ApiRepository extends GetxService {
  final isProduction = const bool.fromEnvironment('dart.vm.product');
  var dio = createDio();
  static var storage = GetStorage();
  final token = storage.read(StorageKeys.token.name);
  static Dio createDio() {
    Dio dio = Dio(BaseOptions(
      baseUrl: 'https://tureeslii.mn/api',
    ));
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
    return dio;
  }

  // auth
  getUser() async {
    try {
      final response = await dio.get('/auth/user');
      return User.fromJson(response.data['data']);
    } on DioException {
      rethrow;
    }
  }

  Future<User> login(String username, String password) async {
    try {
      final data = {"username": username, "password": password};

      final res = await dio.post('/auth/login', data: data);
      return User.fromJson(res.data['data']);
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
      await dio.post('/auth/register', data: data);

      return true;
    } on DioException {
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      await dio.post('/auth/forgotpwd', data: {"username": email});

      return true;
    } on DioException {
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
      await dio.post('/auth/changepwdforgot', data: data);
      return true;
    } on DioException {
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

      await dio.put('/user', data: data);

      return true;
    } on DioException {
      return false;
    }
  }

  Future<bool> sendEmailVerifyCode() async {
    try {
      await dio.get('/auth/requestVerifyCode');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> verifyEmailCode(String code) async {
    try {
      final data = {"code": code};
      final res = await dio.post('/auth/verifyEmail', data: data);
      return res.data['success'];
    } on DioException {
      throw Exception("Алдаа гарлаа");
    }
  }

  Future<bool> getMobileVerifyCode() async {
    try {
      final res = await dio.get(
        '/auth/requestVerifyCodeMobile',
      );
      return res.data['success'];
    } on DioException {
      throw Exception("Алдаа гарлаа");
    }
  }

  Future<bool> sendMobileVerifyCode(String code) async {
    final data = {'code': code};
    try {
      final res = await dio.post('/auth/verifyMobile', data: data);
      return res.data['success'];
    } on DioException {
      throw Exception("Алдаа гарлаа");
    }
  }

  // category
  Future<List<Category>> getCategories() async {
    try {
      final response = await dio.get('/category');
      return (response.data['data'] as List)
          .map((e) => Category.fromJson(e))
          .toList();
    } on DioException {
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

      final response = await dio.post('/posts/getPosts', data: data);

      if (response.data['data'] != null) {
        return (response.data['data'] as List)
            .map((e) => Post.fromJson(e))
            .toList();
      } else {
        return [];
      }
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
      final response = await dio.get(
        '/posts/getSavedPosts',
      );

      return (response.data['data'] as List)
          .map((e) => Post.fromJson(e))
          .toList();
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

      await dio.post('/posts/saveBookmark', data: data);

      return true;
    } on DioException catch (e) {
      if (e.response?.data["success"] == false) {
        throw Exception("Дахии оролдоно уу");
      } else {
        throw Exception("Алдаа гарлаа");
      }
    }
  }

  removeBookmark(int postId) async {
    try {
      await dio.delete(
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
      int postId, String startDate, int duration, String type) async {
    try {
      final data = {
        "postId": postId,
        "startDate": startDate,
        "duration": duration,
        "type": type
      };
      final response = await dio.post('/posts/rentRequest', data: data);

      if (response.data['success']) {
        return ErrorHandler(success: true, message: 'Амжилттай');
      }
      if (response.data['message'] == 'please_confirm_email') {
        return ErrorHandler(
            message: 'Имайл хаягаа баталгаажуулна уу.', success: false);
      }
      if (response.data['message'] == 'please_verify_mobile') {
        return ErrorHandler(
            message: 'Утасны дугаараа баталгаажуулна уу.', success: false);
      }
      if (response.data['message'] == 'start date error') {
        return ErrorHandler(
            message: 'Эхлэх огноо алдаатай байна.', success: false);
      }
      if (response.data['message'] ==
          'Энэ хугацаанд түрээслэх боломжгүй байна') {
        return ErrorHandler(
            message: 'Энэ хугацаанд түрээслэх боломжгүй байна.',
            success: false);
      }
      if (response.data['message'] == 'please_fill_additional_infos') {
        return ErrorHandler(
            message: 'Таны мэдээлэл дутуу байна.', success: false);
      }
      return ErrorHandler(message: 'Алдаа гарлаа', success: false);
    } on DioException {
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
      final response = await dio.post('/posts/getOwnPosts', data: data);
      return (response as List).map((e) => Post.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.response?.data["success"] == false) {
        throw Exception("Дахии оролдоно уу");
      } else {
        throw Exception("Алдаа гарлаа");
      }
    }
  }

  Future<List<dynamic>> getPriceRange(FilterData filterData) async {
    try {
      final data = {
        "filterData": filterData,
      };
      final response = await dio.post('/posts/getPriceRange', data: data);
      List<dynamic> copy = response.data['data'];
      copy.sort((a, b) => a['price']!.compareTo(b['price']!));
      return copy;
    } on DioException {
      throw Exception("Алдаа гарлаа");
    }
  }

  // rent request
  Future<List<RentRequest>> getMyRentRequest(int? skip, int? take,
      SortData? sortData, List<FilterData>? filterData) async {
    try {
      final data = {
        "skip": skip ?? 0,
        "take": take ?? 10,
        "sortData": sortData ?? {},
        "filterData": filterData ?? [],
      };
      final response = await dio.post('/rentreq/myRentRequest', data: data);
      return (response.data['data'] as List)
          .map((e) => RentRequest.fromJson(e))
          .toList();
    } on DioException catch (e) {
      if (e.response?.data["success"] == false) {
        throw Exception("Дахин оролдоно уу");
      } else {
        throw Exception("Алдаа гарлаа");
      }
    }
  }

// notification
  Future<List<Notifications>> getAllNotification() async {
    try {
      final response = await dio.get('/notification');

      return (response as List).map((e) => Notifications.fromJson(e)).toList();
    } on DioException {
      throw Exception("Алдаа гарлаа");
    }
  }

  // users
  Future<void> changePassword(String password, String newPassword) async {
    try {
      final data = {'oldPassword': password, 'password': newPassword};
      final res = await dio.put('/user/password', data: data);
      return res.data;
    } on DioException {
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
        "orderNotification": user.orderNotification,
        "productAdsNotification": user.productAdsNotification
      };
      await dio.put('/user', data: data);
      return true;
    } on DioException {
      return false;
    }
  }
}
