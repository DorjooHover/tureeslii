import 'package:flutter/material.dart';
import 'package:landlord/shared/constants/colors.dart';

class RowRadio extends StatelessWidget {
  const RowRadio(
      {super.key,
      required this.groupValue,
      required this.onChanged,
      this.border = const Border(
          bottom: BorderSide(color: gray, width: 1),
          left: BorderSide(color: gray, width: 1),
          top: BorderSide(color: gray, width: 1),
          right: BorderSide(color: gray, width: 1)),
      required this.list});
  final List<String> list;
  final String groupValue;
  final Border border;
  final Function(String? value) onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(5), border: border),
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
