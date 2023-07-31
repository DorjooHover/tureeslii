import 'package:flutter/material.dart';
import 'package:landlord/shared/index.dart';

class NotEnoughView extends StatefulWidget {
  const NotEnoughView({super.key});

  @override
  State<NotEnoughView> createState() => _NotEnoughViewState();
}

class _NotEnoughViewState extends State<NotEnoughView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: origin, vertical: 32),
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
            padding:
                const EdgeInsets.symmetric(horizontal: origin, vertical: 32),
            child: NotEnoughCard(
              onPress: (e) {},
              selected: [1, 2, 3],
              onTap: () {},
              date: '2023.02.15',
            ),
          ),
        ],
      ),
    );
  }
}
