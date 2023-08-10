import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tureeslii/controllers/main_controller.dart';
import 'package:tureeslii/shared/constants/colors.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());
    return Form(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ...[0, 1, 2, 3, 4, 5].map((int i) {
          double size = MediaQuery.of(context).size.width - 120 - (60);
          return Container(
            width: size / 6,
            height: size / 6,
            alignment: Alignment.center,
            child: Obx(
              () => TextFormField(
                showCursor: false,
                onTap: () {
                  if (controller.otp.value[i] != '-') {
                    controller.otp.value =
                        controller.otp.value.replaceRange(i, i + 1, '-');
                  }
                },
                onChanged: (value) {
                  if (value.length == 1) {
                    controller.otp.value =
                        controller.otp.value.replaceRange(i, i + 1, value);
                    FocusScope.of(context).nextFocus();
                  }
                },
                initialValue: controller.otp.value[i],
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: black, fontWeight: FontWeight.w400, fontSize: 22),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: divider,
                      width: 1,
                    ),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(1),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    ));
  }
}
