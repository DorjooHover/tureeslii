import 'package:flutter/material.dart';
import 'package:landlord/shared/index.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: origin),
          child: Column(
            children: <Widget>[
              space64,
              Image.asset(imageError),
              space32,
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  errorPageText,
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
      ),
    );
  }
}
