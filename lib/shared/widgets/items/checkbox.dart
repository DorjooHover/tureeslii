import 'package:flutter/material.dart';
import 'package:tureeslii/shared/constants/colors.dart';
import 'package:tureeslii/shared/constants/spacing.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox(
      {super.key, required this.value, required this.onChanged});
  final bool value;
  final void Function(bool?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        side: const BorderSide(color: spacerGray),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        value: value,
        onChanged: onChanged);
  }
}

class RowCheckBox extends StatelessWidget {
  const RowCheckBox(
      {super.key,
      required this.value,
      required this.onChanged,
      required this.text});
  final bool value;
  final void Function(bool?) onChanged;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 15,
                  offset: const Offset(0, 0), // changes position of shadow
                )
              ]),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomCheckBox(value: value, onChanged: onChanged),
              space8,
              Flexible(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    text,
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: black),
                  ),
                ),
              )
            ],
          )),
    );
    // return Row(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     // CustomCheckBox(value: value, onChanged: onChanged),

    //     space8,
    //     Text(
    //       text,
    //       style:
    //           Theme.of(context).textTheme.bodySmall!.copyWith(color: black),
    //     )
    //   ],
    // );
  }
}
