import 'package:flutter/material.dart';
import 'package:landlord/shared/index.dart';

class Page404View extends StatelessWidget {
  const Page404View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        currentIndex: 4,
        height: 246,
        back: true,
        bgColor: bgGray,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            space64,
            Image.asset(image404),
            space32,
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                page404Text,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
