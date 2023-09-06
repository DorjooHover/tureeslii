// ignore_for_file: avoid_classes_with_only_static_members

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:tureeslii/provider/api_prodiver.dart';
import 'package:tureeslii/provider/dio_provider.dart';
import 'package:tureeslii/storage.dart';

class DenpendencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => LocalStorage().init());
    Get.put<DioProvider>(DioProvider());
    Get.put<ApiRepository>(ApiRepository(), permanent: true);
    Get.put<Connectivity>(Connectivity(), permanent: true);
    // Get.put<NotificationController>(NotificationController(), permanent: true);
  }
}
