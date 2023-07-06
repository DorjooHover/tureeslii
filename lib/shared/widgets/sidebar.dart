import 'package:flutter/widgets.dart';
import 'package:landlord/shared/index.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: red,
      width: 80,
      height: MediaQuery.of(context).size.height,
    );
  }
}
