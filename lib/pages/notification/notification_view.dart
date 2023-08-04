import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tureeslii/controllers/notification_controller.dart';
import 'package:tureeslii/shared/index.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final controller = Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    controller.getNotification();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Obx(
        () => ListView.builder(
          itemBuilder: (context, index) => Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: origin),
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
        ),
      ),
    );
  }
}
