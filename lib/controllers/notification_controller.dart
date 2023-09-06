import 'package:get/get.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/provider/api_prodiver.dart';

class NotificationController extends GetxController {
  ApiRepository apiRepository = ApiRepository();

  final notification = <Notifications>[].obs;
  getNotification() async {
    final res = await apiRepository.getAllNotification();
    notification.value = res;
  }
}
