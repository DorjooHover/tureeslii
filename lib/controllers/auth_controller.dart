import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:landlord/model/user.dart';
import 'package:landlord/provider/api_prodiver.dart';
import 'package:landlord/routes.dart';
import 'dart:developer' as dev;
import './splash_controller.dart' show SplashController;
import '../../../shared/index.dart';

class AuthController extends GetxController {
  ApiRepository apiRepository = ApiRepository();

  final storage = GetStorage();

  @override
  onInit() {
    super.onInit();
  }

  registerEmail(String email, String password) async {
    try {
      final res = await apiRepository.register(email, password);
      res.fold((l) => null, (r) => null);
    } catch (e) {
      dev.log(e.toString());
    }
  }

  forgotPassword(String email) async {
    try {
      final res = await apiRepository.forgotPassword(email);
      res.fold((l) => null, (r) => null);
    } catch (e) {
      dev.log(e.toString());
    }
  }

  forgotPasswordVerify(String password, String code, String email) async {
    try {
      final res =
          await apiRepository.verifyForgotPassword(password, code, email);
      res.fold((l) => null, (r) => null);
    } catch (e) {
      dev.log(e.toString());
    }
  }

  login(String username, String password) async {
    try {
      final res = await apiRepository.login(username, password);

      res.fold(
          (l) => null,
          (r) => {
                _saveTokens(r.accessToken ?? '')
                    .then((value) => Get.toNamed(Routes.main))
              });
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logout() async {
    await storage.remove(StorageKeys.token.name);

    Get.find<SplashController>().token.value = null;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _saveTokens(String token) async {
    await storage.write(StorageKeys.token.name, token);
    Get.find<SplashController>().token.value = token;
  }
}
