import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/provider/api_prodiver.dart';
import 'package:tureeslii/shared/index.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<Notifications> notifications = [];
  final api = Get.find<ApiRepository>();
  @override
  void initState() {
    super.initState();
    getNotification();
  }

  getNotification() async {
    List<Notifications> res = await api.getAllNotification();
    setState(() {
      notifications = res;
    });
    if (mounted) {
      setState(() {
        notifications = [];
      });
    }
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: origin),
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
        itemCount: notifications.length,
      ),
    );
  }
}
