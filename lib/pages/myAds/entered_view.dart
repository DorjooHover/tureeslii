import 'package:flutter/material.dart';
import 'package:landlord/shared/index.dart';

class EnteredView extends StatefulWidget {
  const EnteredView({super.key});

  @override
  State<EnteredView> createState() => _EnteredViewState();
}

class _EnteredViewState extends State<EnteredView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
