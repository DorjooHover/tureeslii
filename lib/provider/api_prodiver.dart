import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:landlord/model/models.dart';
import 'package:landlord/provider/dio_provider.dart';
import 'package:landlord/shared/constants/strings.dart';

class ApiRepository {
  ApiRepository({required this.apiProvider});

  final DioProvider apiProvider;

  // auth
  getUser() async {
    try {
      final response = await apiProvider.get('/auth/user');
      print(response);
      return User.fromJson(response['data']);
    } on DioException {
      rethrow;
    }
  }

  Future<String> uploadFile(image) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse('https://tureeslii.mn/api/upload'));
      request.files
          .add(await http.MultipartFile.fromPath('image', image!.path));

      final res = await request.send();
      // print(res);
      String resStr = await res.stream.bytesToString();

      return resStr;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? errorOccurred);
    }
  }

  Future<bool> createPost(Post post, List<String> images) async {
    try {
      final data = {
        "lat": post.lat,
        "long": post.long,
        "address": post.address,
        "apartment_no": post.apartmentNo,
        "door_no": post.doorNo,
        "startDate": post.startDate,
        "priceIncluded": post.priceIncluded,
        "paymentTerm": post.paymentTerm,
        "bedRoom": post.bedroom,
        "livingRoom": post.livingRoom,
        "kitchen": post.kitchen,
        "singleBed": post.singleBed,
        "doubleBed": post.doubleBed,
        "priceTerm": post.priceTerm,
        "price": post.price,
        "description": post.description,
        "plot": post.plot,
        "heating": post.heating,
        "waterSupply": post.waterSupply,
        "restroom": post.restroom,
        "postAttachments": images,
        "city": post.city,
        "district": post.district,
        "state": post.state,
        "acceptedGender": post.acceptedGender,
        "acceptedTenants": post.acceptedTenants,
        "petAllowed": post.petAllowed,
        "guestAllowed": post.guestAllowed,
        "balcony": post.balcony,
        "cancelTerm": post.cancelTerm,
        "dailyRent": post.dailyRent,
        "depositRequired": post.depositRequired,
        "depositTerm": post.depositTerm,
        "elevator": post.elevator,
        "floor": post.floor,
        "furnitures": post.furnitures ?? [],
        "categoryId": post.category,
        "hasFurniture": post.hasFurniture ?? false,
        "kitchenFurniture": post.kitchenFurniture,
        "livingProperty": post.livingProperty,
        "minDurationDaily": post.minDurationDaily,
        "minDurationMonthly": post.minDurationMonthly,
        "monthlyRent": post.monthlyRent,
        "refrigerator": post.refrigerator,
        "stove": post.stove,
        "tvCable": post.tvCable,
        "washingMachine": post.washingMachine,
        "wifi": post.wifi,
        "title": post.title,
      };
      print(data);
      final res = await apiProvider.post('/posts', data: data);
      print(res);
      return true;
    } on DioException catch (e) {
      print(e);
      return false;
    }
  }

  Future<User> login(String username, String password) async {
    try {
      final data = {"username": username, "password": password};

      final res = await apiProvider.post('/auth/login', data: data);
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
    } on DioException {
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      final res =
          await apiProvider.post('/auth/forgotpwd', data: {"username": email});
      print(res);
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
      await apiProvider.post('/auth/changepwdforgot', data: data);
      return true;
    } on DioException {
      return false;
    }
  }

  Future<bool> savePersonal(User user) async {
    try {
      final data = {
        "lastname": user.lastname,
        "firstname": user.firstname,
        "mobile": user.mobile,
        "companyName": user.companyName,
        "companyRegistry": user.companyRegistry,
        "order_notification": user.orderNotification,
        "product_ads_notification": user.productAdsNotification,
        // "password": password
      };

      await apiProvider.put('/user', data: data);
      return true;
    } on DioException {
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

  Future<bool> getMobileVerifyCode() async {
    try {
      final res = await apiProvider.get(
        '/auth/requestVerifyCodeMobile',
      );
      return res['success'];
    } on DioException {
      throw Exception(errorOccurred);
    }
  }

  Future<bool> sendMobileVerifyCode(String code) async {
    final data = {'code': code};
    try {
      final res = await apiProvider.post('/auth/verifyMobile', data: data);
      return res['success'];
    } on DioException {
      throw Exception(errorOccurred);
    }
  }

  Future<bool> verifyEmailCode(String code) async {
    try {
      final data = {"code": code};
      final res = await apiProvider.post('/auth/verifyEmail', data: data);
      return res['success'];
    } on DioException {
      throw Exception(errorOccurred);
    }
  }

  // verification
  Future<bool> verificationUser(String frontCard, String backCard,
      String bankAccount, String bankName, String bankAccName) async {
    try {
      final data = {
        "front": frontCard,
        "back": backCard,
        "bankAccNo": bankAccount,
        "bankName": bankName,
        "bankAccName": bankAccName,
      };
      print(data);
      final res =
          await apiProvider.post('/user/verificationRequest', data: data);

      return res['success'];
    } on DioException {
      throw Exception(errorOccurred);
    }
  }

// config
  Future<Config> getConfigById(String id) async {
    try {
      final response = await apiProvider.get('/admin/config/$id');
      return Config.fromJson(response);
    } on DioException {
      throw Exception(errorOccurred);
    }
  }

  // cancel term
  Future<List<Cancelation>> getCancelation() async {
    try {
      final response = await apiProvider.get('/cancelation/get');
      return (response['data'] as List)
          .map((e) => Cancelation.fromJson(e))
          .toList();
    } on DioException {
      rethrow;
    }
  }

  // category
  Future<List<Category>> getCategories() async {
    try {
      final response = await apiProvider.get('/category');

      return (response['data'] as List)
          .map((e) => Category.fromJson(e))
          .toList();
    } on DioException {
      throw Exception(errorOccurred);
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
        throw Exception(tryAgain);
      } else {
        throw Exception(errorOccurred);
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
        throw Exception(tryAgain);
      } else {
        throw Exception(errorOccurred);
      }
    }
  }

  saveBookmark(int postId) async {
    try {
      final data = {"postId": postId};

      await apiProvider.post('/posts/saveBookmark', data: data);
      return true;
    } on DioException catch (e) {
      print(e.response);
      if (e.response?.data["success"] == false) {
        throw Exception(tryAgain);
      } else {
        throw Exception(errorOccurred);
      }
    }
  }

  removeBookmark(int postId) async {
    try {
      await apiProvider.delete(
        '/posts/removeBookmark/$postId',
      );
      return true;
    } on DioException catch (e) {
      if (e.response?.data["success"] == false) {
        throw Exception(tryAgain);
      } else {
        throw Exception(errorOccurred);
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
      if (response['message'] == 'start date error') {
        return ErrorHandler(
            message: 'Эхлэх огноо алдаатай байна.', success: false);
      }
      if (response['message'] == 'Энэ хугацаанд түрээслэх боломжгүй байна') {
        return ErrorHandler(
            message: 'Энэ хугацаанд түрээслэх боломжгүй байна.',
            success: false);
      }
      return ErrorHandler(message: errorOccurred, success: false);
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
      final response = await apiProvider.post('/posts/getOwnPosts', data: data);

      return (response['data'] as List).map((e) => Post.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.response?.data["success"] == false) {
        throw Exception(tryAgain);
      } else {
        throw Exception(errorOccurred);
      }
    }
  }

// notification
  Future<List<Notifications>> getAllNotification() async {
    try {
      final response = await apiProvider.get('/notification');

      return (response as List).map((e) => Notifications.fromJson(e)).toList();
    } on DioException {
      throw Exception(errorOccurred);
    }
  }

  // users
  Future<void> changePassword(String password, String newPassword) async {
    try {
      final data = {'oldPassword': password, 'password': newPassword};
      return await apiProvider.put('/user/password', data: data);
    } on DioException {
      throw Exception(errorOccurred);
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
    } on DioException {
      return false;
    }
  }
}
