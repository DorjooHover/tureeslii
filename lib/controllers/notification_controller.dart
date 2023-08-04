import 'package:get/get.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/provider/api_prodiver.dart';

class NotificationController extends GetxController {
  final ApiRepository _apiRepository = Get.find();

  final notification = <Notifications>[].obs;
  getNotification() async {
    final res = await _apiRepository.getAllNotification();
    notification.value = res;
  }
}
