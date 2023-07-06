import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:landlord/shared/constants/colors.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          child: TextFormField(
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: black, fontWeight: FontWeight.w400),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 18),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
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
        Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          child: TextFormField(
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: black, fontWeight: FontWeight.w400),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 18),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
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
        Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          child: TextFormField(
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: black, fontWeight: FontWeight.w400),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 18),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
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
        Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          child: TextFormField(
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: black, fontWeight: FontWeight.w400),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 18),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
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
      ],
    ));
  }
}
