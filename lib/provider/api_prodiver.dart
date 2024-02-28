import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:landlord/model/models.dart';
import 'package:dartz/dartz.dart';
import 'package:landlord/shared/index.dart';
import 'dart:developer' as dev;

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
        // LogInterceptor(resBody: true),
      ],
    );
    return dio;
  }

  // auth
  EitherUser<User> getUser() async {
    try {
      final res = await dio.get('/auth/user');

      if (res.statusCode == 200) {
        return right(User.fromJson(res.data['data']));
      }
      return left(errorOccurred);
    } catch (e) {
      
      return left(errorOccurred);
    }
  }

  EitherText<String> uploadFile(image) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse('https://tureeslii.mn/api/upload'));
      request.files
          .add(await http.MultipartFile.fromPath('image', image!.path));

      final res = await request.send();

      String resStr = await res.stream.bytesToString();

      return right(resStr);
    } on DioException catch (e) {
      return left(e.response?.data['message'] ?? errorOccurred);
    }
  }

  EitherSuccess<bool> createPost(Post post, List<String> images) async {
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

      if (res.statusCode == 201) {
        return right(res.data['success']);
      }

      return left(tryAgain);
    } on DioException catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  EitherSuccess<bool> updatePost(Post post, List<String> images) async {
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

      if (res.statusCode == 201) {
        return right(res.data['success']);
      }

      return left(tryAgain);
    } on DioException catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  EitherHandler<ErrorHandler> deletePost(String id) async {
    try {
      final res = await dio.delete('/posts/$id');
      if (res.statusCode == 200) {
        return right(ErrorHandler.fromJson(res.data));
      }
      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  EitherUser<User> login(String username, String password) async {
    try {
      final data = {"username": username, "password": password};

      final res = await dio.post('/auth/login', data: data);
      if (res.statusCode == 201) {
        return right(User.fromJson(res.data['data']));
      }
      return left(tryAgain);
    } on DioException catch (e) {
      dev.log(e.toString());
      if (e.response?.statusCode == 401 && e.response?.data['message'] != "") {
        return left('Нэвтрэх нэр эсвэл нууц үг буруу байна');
      }
      if (e.response?.statusCode == 401) {
        return left('Та Нэвтрэх нэр, нууц үгээ оруулна уу');
      }
      return left(errorOccurred);
    }
  }

  EitherSuccess<bool> register(
    String email,
    String password,
  ) async {
    try {
      final data = {"password": password, "isCreator": false, "email": email};
      final res = await dio.post('/auth/register', data: data);
      if (res.statusCode == 201) {
        return right(true);
      }
      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  EitherSuccess<bool> forgotPassword(String email) async {
    try {
      final res = await dio.post('/auth/forgotpwd', data: {"username": email});
      if (res.statusCode == 201) {
        return right(true);
      }
      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  EitherSuccess<bool> verifyForgotPassword(
      String password, String code, String email) async {
    try {
      final data = {
        "password": password,
        "password_verify": code,
        "email_code": email
      };
      final res = await dio.post('/auth/changepwdforgot', data: data);
      if (res.statusCode == 201) {
        return right(true);
      }
      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  EitherSuccess<bool> savePersonal(User user) async {
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

      final res = await dio.put('/user', data: data);
      if (res.statusCode == 201) {
        return right(true);
      }
      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  EitherSuccess<bool> sendEmailVerifyCode() async {
    try {
      final res = await dio.get('/auth/requestVerifyCode');
      if (res.statusCode == 200) {
        return right(true);
      }
      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  EitherSuccess<bool> getMobileVerifyCode() async {
    try {
      final res = await dio.get(
        '/auth/requestVerifyCodeMobile',
      );
      if (res.statusCode == 200) {
        return right(res.data['success']);
      }
      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  EitherSuccess<bool> sendMobileVerifyCode(String code) async {
    final data = {'code': code};
    try {
      final res = await dio.post('/auth/verifyMobile', data: data);
      if (res.statusCode == 201) {
        return right(res.data['success']);
      }
      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  EitherSuccess<bool> verifyEmailCode(String code) async {
    try {
      final data = {"code": code};
      final res = await dio.post('/auth/verifyEmail', data: data);
      if (res.statusCode == 201) {
        return right(res.data['success']);
      }
      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  // verification
  EitherSuccess<bool> verificationUser(
      String frontCard,
      String backCard,
      String bankAccount,
      String bankName,
      String bankAccName,
      String? status,
      bool update, 

      ) async {
    try {
      final data = {
        "front": frontCard,
        "back": backCard,
        "bankAccNo": bankAccount,
        "bankName": bankName,
        "bankAccName": bankAccName,
        "status": status ?? "NEW"
      };
      print(update);
      final res;
      if (update) {
        res = await dio.put('/user/verifications', data: data);
      } else {
        res = await dio.post('/user/verificationRequest', data: data);
      }

      print(res);
      print(res.data);
      print(res.statusCode);
      if (res.statusCode == 201) {
        return right(res.data['success']);
      }
      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  EitherVerification<List<Verification>> getUserVerification() async {
    try {
      final res = await dio.get('/user/verificationRequest/user');
      if (res.statusCode == 200) {
        return right(Verification.fromJson(res.data['data']));
      }
      return left(tryAgain);
    } on DioException catch (e) {
      if (e.response?.data["success"] == false) {
        return left(tryAgain);
      } else {
        return left(errorOccurred);
      }
    }
  }

// config
  EitherConfig<Config> getConfigById(String id) async {
    try {
      final res = await dio.get('/admin/config/$id');
      if (res.statusCode == 200) {
        return right(Config.fromJson(res.data));
      }
      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  // cancel term
  EitherCancelations<List<Cancelation>> getCancelation() async {
    try {
      final res = await dio.get('/cancelation/get');

      if (res.statusCode == 200) {
        return right((res.data['data'] as List)
            .map((e) => Cancelation.fromJson(e))
            .toList());
      }
      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  // category
  EitherCategories<List<Category>> getCategories() async {
    try {
      final res = await dio.get('/category');

      if (res.statusCode == 200) {
        return right((res.data['data'] as List)
            .map((e) => Category.fromJson(e))
            .toList());
      }
      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }
  // posts

  EitherPosts<List<Post>> getAllPosts(int? skip, int? take, SortData? sortData,
      List<FilterData>? filterData) async {
    try {
      final data = {
        "skip": skip ?? 0,
        "take": take ?? 12,
        "sortData": sortData ?? {},
        "filterData": filterData ?? [],
      };
      final res = await dio.post('/posts/getPosts', data: data);
      if (res.statusCode == 201) {
        return right(
            (res.data['data'] as List).map((e) => Post.fromJson(e)).toList());
      }
      return left(tryAgain);
    } on DioException catch (e) {
      if (e.response?.data["success"] == false) {
        return left(tryAgain);
      } else {
        return left(errorOccurred);
      }
    }
  }

  EitherPosts<List<Post>> getSavedPosts() async {
    try {
      final res = await dio.get(
        '/posts/getSavedPosts',
      );
      if (res.statusCode == 200) {
        return right(
            (res.data['data'] as List).map((e) => Post.fromJson(e)).toList());
      }
      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  EitherSuccess<bool> saveBookmark(int postId) async {
    try {
      final data = {"postId": postId};

      final res = await dio.post('/posts/saveBookmark', data: data);
      if (res.statusCode == 201) {
        return right(true);
      }

      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  EitherSuccess<bool> removeBookmark(int postId) async {
    try {
      final res = await dio.delete(
        '/posts/removeBookmark/$postId',
      );
      if (res.statusCode == 200) {
        return right(true);
      }

      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  EitherHandler<ErrorHandler> rentRequest(
      int postId, int startDate, int duration) async {
    try {
      final data = {
        "postId": postId,
        "startDate": startDate,
        "duration": duration,
      };
      final res = await dio.post('/posts/rentRequest', data: data);
      if (res.statusCode != 201) {
        return left(tryAgain);
      }
      if (res.data['success']) {
        return right(ErrorHandler(success: true, message: 'Ажмилттай'));
      }
      if (res.data['message'] == 'please_confirm_email') {
        return right(ErrorHandler(
            message: 'Имайл хаягаа баталгаажуулна уу.', success: false));
      }
      if (res.data['message'] == 'start date error') {
        return right(ErrorHandler(
            message: 'Эхлэх огноо алдаатай байна.', success: false));
      }
      if (res.data['message'] == 'Энэ хугацаанд түрээслэх боломжгүй байна') {
        return right(ErrorHandler(
            message: 'Энэ хугацаанд түрээслэх боломжгүй байна.',
            success: false));
      }
      return right(ErrorHandler(message: errorOccurred, success: false));
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  EitherRentRequests<List<RentRequest>> getRentRequestById(int id) async {
    try {
      final res = await dio.get(
        '/rentreq/getByPost/$id',
      );
      if (res.statusCode == 200) {
        return right(
            (res.data as List).map((e) => RentRequest.fromJson(e)).toList());
      }
      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  EitherRentRequests<List<RentRequest>> pendingRentRequest(
      String status) async {
    final data = {"status": status};

    try {
      final res = await dio.post('/rentreq/pendingRentRequest', data: data);
      if (res.statusCode == 201) {
        return right((res.data['data'] as List)
            .map((e) => RentRequest.fromJson(e))
            .toList());
      }
      return left(tryAgain);
    } catch (e) {
      return left(errorOccurred);
    }
  }

  EitherPosts<List<Post>> getOwnPosts(int? skip, int? take, SortData? sortData,
      List<FilterData>? filterData) async {
    try {
      final data = {
        "skip": skip ?? 0,
        "take": take ?? 12,
        "sortData": sortData ?? {},
        "filterData": filterData ?? [],
      };
      final res = await dio.post('/posts/getOwnPosts', data: data);
      if (res.statusCode == 201) {
        return right(
            (res.data['data'] as List).map((e) => Post.fromJson(e)).toList());
      }
      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  EitherMap<Map<String, List>> getPostStats(String postId, String week) async {
    try {
      final data = {"postId": postId, "date": week};
      final res = await dio.post('/posts/getPostStats', data: data);

      if (res.statusCode == 201) {
        return right({
          "views": res.data['data']['views'] as List,
          "likes": (res.data['data']['likes'] as List),
        });
      }
      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  // my order
  EitherPosts<List<Post>> getMyOrders(int? skip, int? take, SortData? sortData,
      List<FilterData>? filterData) async {
    try {
      final data = {
        "skip": skip ?? 0,
        "take": take ?? 12,
        "sortData": sortData ?? {},
        "filterData": filterData ?? [],
      };
      final res = await dio.post('/posts/getOwnPosts', data: data);
      if (res.statusCode == 201) {
        return right(
            (res.data['data'] as List).map((e) => Post.fromJson(e)).toList());
      }

      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

// notification
  EitherNotifications<List<Notifications>> getAllNotification() async {
    try {
      final res = await dio.get('/notification');
      if (res.statusCode == 200) {
        return right(
            (res as List).map((e) => Notifications.fromJson(e)).toList());
      }
      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }

  // users
  // Future<void> changePassword(String password, String newPassword) async {
  //   try {
  //     final data = {'oldPassword': password, 'password': newPassword};
  //     final res = await dio.put('/user/password', data: data);
  //     return res.data;
  //   } on DioException {
  //     throw Exception(errorOccurred);
  //   }
  // }

  EitherSuccess<bool> updateUser(User user) async {
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
      final res = await dio.put('/user', data: data);
      if (res.statusCode == 201) {
        return right(true);
      }
      return left(tryAgain);
    } catch (e) {
      dev.log(e.toString());
      return left(errorOccurred);
    }
  }
}
