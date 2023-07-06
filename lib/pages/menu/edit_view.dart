import 'package:flutter/material.dart';
import 'package:landlord/shared/index.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});
  final editKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGray,
      appBar: MainAppBar(
        bgColor: bgGray,
        statusBarColor: bgGray,
        back: true,
        logo: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: origin, vertical: large),
          child: Form(
            key: editKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdditionCard(title: name, child: Input()),
                space24,
                AdditionCard(title: firstName, child: Input()),
                space24,
                AdditionCard(title: email, child: Input()),
                space24,
                AdditionCard(title: phone, child: Input()),
                space32,
                MainButton(
                  onPressed: () {},
                  text: save,
                  width: double.infinity,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
