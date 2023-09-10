import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tureeslii/controllers/main_controller.dart';
import 'package:tureeslii/pages/no_data.dart';
import 'package:tureeslii/routes.dart';
import 'package:tureeslii/shared/index.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  bool loading = false;
  final controller = Get.put(MainController());

  void initState() {
    super.initState();
    if (controller.user != null) {
      getOrders();
    }
  }

  getOrders() async {
    setState(() {
      loading = true;
    });
    await controller.getOrders();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: origin),
      child: loading
          ? const CustomLoader()
          : Obx(() => controller.user != null
              ? controller.myRentRequest.isNotEmpty
                  ? ListView.builder(
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
                            child: OrderCard(
                              data: controller.myRentRequest[index],
                            )),
                      ),
                      itemCount: controller.myRentRequest.length,
                    )
                  : const Center(child: NoDataView())
              : Center(
                  child: MainButton(
                      onPressed: () {
                        Get.toNamed(Routes.login);
                      },
                      text: login),
                )),
    );
  }
}
