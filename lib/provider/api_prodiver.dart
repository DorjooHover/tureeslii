import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:landlord/model/models.dart';
import 'package:landlord/provider/dio_provider.dart';

class ApiRepository {
  ApiRepository({required this.apiProvider});

  final DioProvider apiProvider;

  // auth
  Future<ErrorHandler> getUser() async {
    try {
      final response = await apiProvider.get('/auth/user');
      return ErrorHandler(success: true, data: User.fromJson(response['data']));
    } on DioException catch (e) {
      return ErrorHandler(success: false, message: e.response?.data['message']);
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
      throw Exception(e.response?.data['message'] ?? 'Алдаа гарлаа');
    }
  }

  Future<bool> createPost(Post post, List<String> images) async {
    try {
      final data = {
        "postDate": post.postDate,
        "bedRoom": post.bedroom,
        "livingRoom": post.livingRoom,
        "kitchen": post.kitchen,
        "singleBed": post.singleBed,
        "doubleBed": post.doubleBed,
        "priceTerm": "MONTH",
        "price": post.price,
        "description": post.description,
        "plot": post.plot,
        "heating": post.heating,
        "waterSupply": post.waterSupply,
        "restroom": post.restroom,
        "images": images,
        "address": post.address,
        "lat": post.lat,
        "long": post.long,
        "city": post.city,
        "district": post.district,
        "state": post.state,
        "acceptedGender": post.acceptedGender,
        "acceptedTenants": post.acceptedTenants,
        "petAllowed": post.petAllowed,
        "petAllowed": post.smokingAllowed,
        "guestAllowed": post.guestAllowed,
        "balcony": post.balcony,
        "cancelTerm": post.cancelTerm,
        "dailyRent": post.dailyRent,
        "depositRequired": post.depositRequired,
        "depositTerm": post.depositTerm,
        "elevator": post.elevator,
        "floor": post.floor,
        "furnitures": post.furnitures,
        "hasFurniture": post.hasFurniture,
        "kitchenFurniture": post.kitchenFurniture,
        "livingProperty": post.livingProperty,
        "minDurationDaily": post.minDurationDaily,
        "minDurationMonthly": post.minDurationMonthly,
        "monthlyRent": post.monthlyRent,
        "postAttachments": images,
        "refrigerator": post.refrigerator,
        "stove": post.stove,
        "tvCable": post.tvCable,
        "washingMachine": post.washingMachine,
        "waterSupply": post.waterSupply,
        "wifi": post.wifi,
        "title": post.title,
      };
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

      final res = await apiProvider.put('/user', data: data);
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
