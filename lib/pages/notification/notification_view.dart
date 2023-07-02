import 'package:flutter/material.dart';
import 'package:tureeslii/shared/index.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: ListView.builder(
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
        itemCount: 10,
      ),
    );
  }
}
