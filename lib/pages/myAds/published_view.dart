import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';

class PublishedView extends StatefulWidget {
  const PublishedView({super.key});

  @override
  State<PublishedView> createState() => _PublishedViewState();
}

class _PublishedViewState extends State<PublishedView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.6 - 50,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ...[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((e) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: origin, vertical: 32),
                        child: MyAdsCard(
                            onPressed: () {
                              Get.toNamed(Routes.rentRequest);
                            },
                            text:
                                '2 өрөө, гал тогоо тусдаа орон сууц урт хагацаагаар түрээслэнэ',
                            number: e + 1,
                            type: e % 2 == 0 ? 'rented' : null),
                      ),
                      e != 10
                          ? Divider(
                              color: navGray,
                              height: 2,
                            )
                          : space32
                    ],
                  );
                }).toList(),
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
