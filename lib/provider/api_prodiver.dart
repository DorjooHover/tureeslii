import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:landlord/model/models.dart';
import 'package:landlord/shared/constants/enums.dart';
import 'package:landlord/shared/constants/strings.dart';

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

  Future<String> uploadFile(image) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse('https://tureeslii.mn/api/upload'));
      request.files
          .add(await http.MultipartFile.fromPath('image', image!.path));

      final res = await request.send();

      String resStr = await res.stream.bytesToString();

      return resStr;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? errorOccurred);
    }
  }

  Future<bool> createPost(Post post, List<String> images) async {
    try {
      final data = {
        // location
        "lat": post.lat,
        "long": post.long,
        "address": post.address,
        "apartment_no": post.apartmentNo,
        "door_no": post.doorNo,
        "city": post.city,
        "district": post.district,
        "state": post.state,
        "floor": post.floor,
// general
        "startDate": post.startDate,
        "cancelTerm": post.cancelTerm,
        "dailyRent": post.dailyRent,
        "price": post.price ?? 0,
        "priceDaily": post.priceDaily ?? 0,
        "minDurationDaily": post.minDurationDaily,
        "minDurationMonthly": post.minDurationMonthly,
        "monthlyRent": post.monthlyRent,
        "priceIncluded": post.priceIncluded ?? [],
        "priceTerm": post.priceTerm,
        "paymentTerm": post.paymentTerm,
        "depositRequired": post.depositRequired,
        "depositTerm": post.depositTerm,
        "elevator": post.elevator,
        "furnitures": post.furnitures ?? [],
        "balcony": post.balcony,
        "plot": post.plot!.toInt(),
        "heating": post.heating,
        "waterSupply": post.waterSupply,
        "hasFurniture": post.hasFurniture ?? false,
        "kitchenFurniture": post.kitchenFurniture,
        "stove": post.stove,
        "tvCable": post.tvCable,
        "washingMachine": post.washingMachine,
        "wifi": post.wifi,
        "title": post.title,
        // room
        "bedroom": post.bedroom,
        "livingRoom": post.livingRoom,
        "kitchen": post.kitchen,
        "singleBed": post.singleBed,
        "doubleBed": post.doubleBed,
        "description": "",

        "acceptedGender": post.acceptedGender,
        "acceptedTenants": post.acceptedTenants,
        "petAllowed": post.petAllowed,
        "guestAllowed": post.guestAllowed,
        "restroom": post.restroom,
        "livingProperty": post.livingProperty,
        "refrigerator": post.refrigerator,

        "smokingAllowed": post.smokingAllowed,
        "bathroom": post.bathroom,
        // images
        "postAttachments": images,

        "categoryId": post.category,
      };

      final res = await dio.post('/posts', data: data);

      return res.data['success'];
    } on DioException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updatePost(Post post, List<String> images) async {
    try {
      final data = {
        "id": post.id,
       // location
        "lat": post.lat,
        "long": post.long,
        "address": post.address,
        "apartment_no": post.apartmentNo,
        "door_no": post.doorNo,
        "city": post.city,
        "district": post.district,
        "state": post.state,
        "floor": post.floor,
// general
        "startDate": post.startDate,
        "cancelTerm": post.cancelTerm,
        "dailyRent": post.dailyRent,
        "price": post.price ?? 0,
        "priceDaily": post.priceDaily ?? 0,
        "minDurationDaily": post.minDurationDaily,
        "minDurationMonthly": post.minDurationMonthly,
        "monthlyRent": post.monthlyRent,
        "priceIncluded": post.priceIncluded ?? [],
        "priceTerm": post.priceTerm,
        "paymentTerm": post.paymentTerm,
        "depositRequired": post.depositRequired,
        "depositTerm": post.depositTerm,
        "elevator": post.elevator,
        "furnitures": post.furnitures ?? [],
        "balcony": post.balcony,
        "plot": post.plot!.toInt(),
        "heating": post.heating,
        "waterSupply": post.waterSupply,
        "hasFurniture": post.hasFurniture ?? false,
        "kitchenFurniture": post.kitchenFurniture,
        "stove": post.stove,
        "tvCable": post.tvCable,
        "washingMachine": post.washingMachine,
        "wifi": post.wifi,
        "title": post.title,
        // room
        "bedroom": post.bedroom,
        "livingRoom": post.livingRoom,
        "kitchen": post.kitchen,
        "singleBed": post.singleBed,
        "doubleBed": post.doubleBed,
        "description": "",

        "acceptedGender": post.acceptedGender,
        "acceptedTenants": post.acceptedTenants,
        "petAllowed": post.petAllowed,
        "guestAllowed": post.guestAllowed,
        "restroom": post.restroom,
        "livingProperty": post.livingProperty,
        "refrigerator": post.refrigerator,

        "smokingAllowed": post.smokingAllowed,
        "bathroom": post.bathroom,
        // images
        "postAttachments": images.isEmpty ? post.postAttachments : images,

        "categoryId": post.category,
      };

      final res = await dio.put('/posts', data: data);

      return res.data['success'];
    } on DioException catch (e) {
      print(e);
      return false;
    }
  }


  Future<ErrorHandler> deletePost(String id) async {
    try {
      final res = await dio.delete('/posts/$id') ;
     return  ErrorHandler.fromJson(res.data);
     
    } catch (e) {
return ErrorHandler(success: false);
    }
  }

  Future<User> login(String username, String password) async {
    try {
      final data = {"username": username, "password": password};
   
      final res = await dio.post('/auth/login', data: data);

      return User.fromJson(res.data['data']);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 && e.response?.data['message'] != "") {
        throw Exception('Нэвтрэх нэр эсвэл нууц үг буруу байна');
      }
      if (e.response?.statusCode == 401) {
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
      final res = await dio.post('/auth/forgotpwd', data: {"username": email});
 
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

  Future<bool> getMobileVerifyCode() async {
    try {
      final res = await dio.get(
        '/auth/requestVerifyCodeMobile',
      );
      return res.data['success'];
    } on DioException {
      throw Exception(errorOccurred);
    }
  }

  Future<bool> sendMobileVerifyCode(String code) async {
    final data = {'code': code};
    try {
      final res = await dio.post('/auth/verifyMobile', data: data);
      return res.data['success'];
    } on DioException {
      throw Exception(errorOccurred);
    }
  }

  Future<bool> verifyEmailCode(String code) async {
    try {
      final data = {"code": code};
      final res = await dio.post('/auth/verifyEmail', data: data);
      return res.data['success'];
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

      final res = await dio.post('/user/verificationRequest', data: data);

      return res.data['success'];
    } on DioException {
      throw Exception(errorOccurred);
    }
  }

// config
  Future<Config> getConfigById(String id) async {
    try {
      final response = await dio.get('/admin/config/$id');
      return Config.fromJson(response.data);
    } on DioException {
      throw Exception(errorOccurred);
    }
  }

  // cancel term
  Future<List<Cancelation>> getCancelation() async {
    try {
      final response = await dio.get('/cancelation/get');

      return (response.data['data'] as List)
          .map((e) => Cancelation.fromJson(e))
          .toList();
    } on DioException {
      rethrow;
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
      final response = await dio.post('/posts/getPosts', data: data);
      return (response.data['data'] as List)
          .map((e) => Post.fromJson(e))
          .toList();
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
      final response = await dio.get(
        '/posts/getSavedPosts',
      );
      return (response.data['data'] as List)
          .map((e) => Post.fromJson(e))
          .toList();
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

      await dio.post('/posts/saveBookmark', data: data);
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
      await dio.delete(
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
      final response = await dio.post('/posts/rentRequest', data: data);

      if (response.data['success']) {
        return ErrorHandler(success: true, message: 'Ажмилттай');
      }
      if (response.data['message'] == 'please_confirm_email') {
        return ErrorHandler(
            message: 'Имайл хаягаа баталгаажуулна уу.', success: false);
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
      return ErrorHandler(message: errorOccurred, success: false);
    } on DioException {
      throw Exception('Алдаа');
    }
  }

  Future<List<RentRequest>> getRentRequestById(int id) async {
    try {
      final response = await dio.get(
        '/rentreq/getByPost/$id',
      );

      return (response.data as List)
          .map((e) => RentRequest.fromJson(e))
          .toList();
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

      return (response.data['data'] as List)
          .map((e) => Post.fromJson(e))
          .toList();
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
      final response = await dio.get('/notification');

      return (response as List).map((e) => Notifications.fromJson(e)).toList();
    } on DioException {
      throw Exception(errorOccurred);
    }
  }

  // users
  Future<void> changePassword(String password, String newPassword) async {
    try {
      final data = {'oldPassword': password, 'password': newPassword};
      final res = await dio.put('/user/password', data: data);
      return res.data;
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
      await dio.put('/user', data: data);
      return true;
    } on DioException {
      return false;
    }
  }
}
