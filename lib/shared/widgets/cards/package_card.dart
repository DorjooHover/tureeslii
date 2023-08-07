import 'package:flutter/material.dart';
import 'package:landlord/shared/index.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({super.key, required this.type, required this.onPress});
  final String type;
  final Function() onPress;
  @override
  Widget build(BuildContext context) {
    String typeString = 'Энгийн';
    String price = 'Үнэгүй';
    Color btnColor = prime;
    Color btnTextColor = Colors.white;
    Color color = Colors.white;
    Color textColor = black;
    Color centerColor = gray;
    Color endColor = black;
    int value = 0;
    Color titleColor = gray;
    switch (type) {
      case 'promo1':
        typeString = 'Promo I';
        price = '${currencyFormat(10000, false)}₮';
        btnColor = Colors.white;
        btnTextColor = black;
        centerColor = const Color(0xff924600);
        endColor = Colors.white;
        textColor = Colors.white;
        value = 14;
        color = orange;
        titleColor = orange;
        break;
      case 'promo2':
        typeString = 'Promo II';
        price = '${currencyFormat(5000, false)}₮';
        endColor = prime;
        textColor = prime;
        value = 7;
        titleColor = prime;
        break;
      default:
    }
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 25,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(origin),
                  color: color,
                ),
                child: Column(
                  children: <Widget>[
                    space16,
                    Text(
                      haveDaySpecial,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.bold, color: textColor),
                      textAlign: TextAlign.center,
                    ),
                    space24,
                    Text(
                      typeString,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold, color: centerColor),
                    ),
                    space16,
                    Text(
                      price,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold, color: endColor),
                    ),
                    space24,
                    MainButton(
                      onPressed: onPress,
                      text: choose,
                      borderRadius: 4,
                      color: btnColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      contentColor: btnTextColor,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: Offset(0, 10)),
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: Offset(0, 0)),
                      ]),
                  alignment: Alignment.center,
                  child: Text(
                    value.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: titleColor, fontSize: 24),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
