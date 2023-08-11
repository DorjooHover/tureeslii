import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';

class NotEnoughView extends StatefulWidget {
  const NotEnoughView({super.key});

  @override
  State<NotEnoughView> createState() => _NotEnoughViewState();
}

class _NotEnoughViewState extends State<NotEnoughView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.6 - 50,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: origin, vertical: 32),
                  child: NotEnoughCard(
                    onPress: (e) {},
                    selected: [1, 2, 3],
                    onTap: () {},
                    date: '2023.02.15',
                  ),
                ),
                Divider(
                  color: navGray,
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: origin, vertical: 32),
                  child: NotEnoughCard(
                    onPress: (e) {},
                    selected: [1, 2, 3],
                    onTap: () {},
                    date: '2023.02.15',
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).padding.bottom + 32,
            child: Align(
              alignment: Alignment.center,
              child: MainButton(
                onPressed: () {
                  Get.toNamed(Routes.location);
                },
                borderRadius: 100,
                child: Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Icon(Icons.add, color: prime)),
              ),
            ))
      ],
    );
  }
}
