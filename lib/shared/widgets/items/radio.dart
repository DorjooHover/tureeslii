import 'package:flutter/material.dart';
import 'package:tureeslii/shared/constants/colors.dart';

class RowRadio extends StatelessWidget {
  const RowRadio(
      {super.key,
      required this.groupValue,
      required this.onChanged,
      required this.list});
  final List<String> list;
  final String groupValue;
  final Function(String? value) onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: gray, width: 1)),
      child: Row(
        children: <Widget>[
          ...list
              .map((e) => Expanded(
                    child: GestureDetector(
                      onTap: () => onChanged(e),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: e,
                              groupValue: groupValue,
                              onChanged: onChanged),
                          Text(
                            e,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: black),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList()
        ],
      ),
    );
  }
}
