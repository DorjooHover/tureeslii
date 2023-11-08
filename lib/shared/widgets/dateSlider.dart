import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:landlord/shared/constants/colors.dart';
import 'package:landlord/shared/constants/spacing.dart';
import 'package:landlord/shared/constants/strings.dart';
import 'package:landlord/shared/functions/currency.dart';

class AnimatedDateSlider extends StatefulWidget {
  const AnimatedDateSlider(
      {super.key, required this.endDate, required this.startDate});
  final DateTime startDate;
  final DateTime endDate;

  @override
  State<AnimatedDateSlider> createState() => _AnimatedDateSliderState();
}

class _AnimatedDateSliderState extends State<AnimatedDateSlider> {
  bool active = false;
  @override


  void initState() {
    if (!mounted) {
      return;
    }
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        active = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int diff = widget.endDate.difference(widget.startDate).inDays;
    int currentDiff = DateTime.now().difference(widget.startDate).inDays;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 50),
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                dateFormat(widget.startDate),
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: black),
              ),
              Text(
                diff > 30 ? '${diff ~/ 30} сар' : '$diff хоног',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: black, fontWeight: FontWeight.bold),
              ),
              Text(
                dateFormat(widget.endDate),
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: black),
              ),
            ],
          ),
        ),
        AnimatedPositioned(
            left: 0,
            right: 0,
            duration: const Duration(seconds: 2),
            bottom: 26,
            child: Container(
              height: 4,
              color: active ? Color(0xfff0f0f0) : Colors.transparent,
            )),
        Positioned(
            left: 0,
            bottom: 24,
            child: Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                  color: orange, borderRadius: BorderRadius.circular(100)),
            )),
        AnimatedPositioned(
          width: !active
              ? 0
              : MediaQuery.of(context).size.width * (currentDiff / diff),
          height: 4,
          bottom: 26,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          child: ColoredBox(
            color: orange,
          ),
        ),
        AnimatedPositioned(
            left: !active
                ? 0
                : MediaQuery.of(context).size.width * (currentDiff / diff)-4.5,
            height: 9,
            width: 9,
            bottom: 24,
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            child: Container(
              decoration: BoxDecoration(
                  color: orange, borderRadius: BorderRadius.circular(100)),
            )),
   
        AnimatedPositioned(
            left: !active
                ? 0
                : MediaQuery.of(context).size.width * (currentDiff / diff) - ( MediaQuery.of(context).size.width * (currentDiff / diff) > 35  ?   (currentDiff / diff) > 0.8 ? 70 : 35 : MediaQuery.of(context).size.width * (currentDiff / diff)),
  
            bottom: 0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            child: Container(
              child: Text(dateFormat(DateTime.now()), style: Theme.of(context).textTheme.bodySmall!.copyWith(color: orange),),
            )
            ),
      ],
    );
  }
}
