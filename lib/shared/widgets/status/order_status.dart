import 'package:flutter/material.dart';
import 'package:tureeslii/shared/constants/colors.dart';
import 'package:tureeslii/shared/constants/strings.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({
    super.key,
    required this.type,
  });
  final String type;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.transparent;
    String text = '';
    switch (type) {
      case 'success':
        color = green;
        text = accepted;
        break;
      case 'UNPAID':
        color = warning;
        text = requested;
        break;
      case 'danger':
        color = red;
        text = denied;
        break;
      default:
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 9),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(11), color: color),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Colors.white),
      ),
    );
  }
}
