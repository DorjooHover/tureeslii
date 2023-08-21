import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tureeslii/controllers/main_controller.dart';
import 'package:tureeslii/controllers/notification_controller.dart';
import 'package:tureeslii/pages/no_data.dart';
import 'package:tureeslii/routes.dart';
import 'package:tureeslii/shared/index.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final controller = Get.put(NotificationController());
  final mainController = Get.put(MainController());
  @override
  void initState() {
    super.initState();
    if (mainController.user != null) {
      controller.getNotification();
    }
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: origin, vertical: 24),
      child: Obx(
        () => mainController.user != null
            ? controller.notification.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: origin),
                      child: NotificationCard(
                          dot: index % 4 != 0 ? true : false,
                          type: index % 5 == 0
                              ? 'success'
                              : index % 5 == 2
                                  ? 'warning'
                                  : index % 5 == 1
                                      ? 'info'
                                      : 'danger'),
                    ),
                    itemCount: controller.notification.length,
                  )
                : const Center(child: NoDataView())
            : Center(
                child: MainButton(
                onPressed: () {
                  Get.toNamed(Routes.login);
                },
                text: login,
              )),
      ),
    );
  }
}
