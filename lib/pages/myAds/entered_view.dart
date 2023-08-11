import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';

class EnteredView extends StatefulWidget {
  const EnteredView({super.key});

  @override
  State<EnteredView> createState() => _EnteredViewState();
}

class _EnteredViewState extends State<EnteredView> {
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
                          type: e % 2 == 0 ? 'checking' : 'returned',
                          text:
                              '2 өрөө, гал тогоо тусдаа орон сууц урт хагацаагаар түрээслэнэ',
                          number: e + 1,
                        ),
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
