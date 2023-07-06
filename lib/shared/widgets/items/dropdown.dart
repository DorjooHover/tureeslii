import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:landlord/shared/constants/assets.dart';
import 'package:landlord/shared/constants/colors.dart';
import 'package:landlord/shared/constants/strings.dart';

class DropDown extends StatelessWidget {
  const DropDown(
      {super.key,
      required this.list,
      required this.value,
      this.icon,
      required this.onChanged});
  final String value;
  final List<String> list;
  final Widget? icon;
  final Function(String? value) onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: gray),
          borderRadius: BorderRadius.circular(5)),
      child: DropdownButton(
          isDense: true,
          icon: icon ?? SvgPicture.asset(iconArrowDown),
          iconEnabledColor: gray,
          isExpanded: true,
          dropdownColor: Colors.white,
          value: value == '' ? null : value,
          hint: Text(choose,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: labelGray)),
          underline: const SizedBox(),
          items: list.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: black),
              ),
            );
          }).toList(),
          onChanged: onChanged),
    );
  }
}
