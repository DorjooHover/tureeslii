import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: origin),
      child: ListView.builder(
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            if (index == 0) {
              Get.toNamed(Routes.acceptedOrder);
            }
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: OrderCard(type: index == 0 ? 'success' : 'warning')),
        ),
        itemCount: 10,
      ),
    );
  }
}
