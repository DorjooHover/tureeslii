import 'package:flutter/material.dart';
import 'package:landlord/shared/constants/colors.dart';

class LocationDrawerCard extends StatelessWidget {
  const LocationDrawerCard(
      {super.key,
      required this.text,
      required this.isSelected,
      required this.number});
  final String text;
  final int number;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: isSelected ? prime : bgGray,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: drawerGray, width: 1),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              border: Border.all(color: drawerGray),
              borderRadius: BorderRadius.circular(100),
            ),
            alignment: Alignment.center,
            child: Text(
              '$number',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: isSelected ? prime : black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 9),
          Flexible(
              child: FittedBox(
            fit: BoxFit.cover,
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: isSelected ? Colors.white : black,
                  fontWeight: FontWeight.bold),
            ),
          ))
        ],
      ),
    );
  }
}
