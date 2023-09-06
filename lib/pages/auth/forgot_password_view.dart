import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tureeslii/controllers/auth_controller.dart';
import 'package:tureeslii/shared/index.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final editKey = GlobalKey<FormState>();
  final controller = Get.put(AuthController());
  String codeValue = "", emailValue = "", passwordValue = "";
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
                AdditionCard(
                    title: email,
                    child: Input(
                      textInputAction: TextInputAction.next,
                      onChange: (p0) {
                        setState(() {
                          emailValue = p0;
                        });
                      },
                    )),
                space24,
                MainButton(
                  onPressed: () {
                    controller.forgotPassword(emailValue);
                  },
                  text: 'Мартсан',
                  width: double.infinity,
                ),
                space32,
                AdditionCard(
                    title: password,
                    child: Input(
                      textInputAction: TextInputAction.done,
                      onChange: (p0) {
                        setState(() {
                          passwordValue = p0;
                        });
                      },
                    )),
                space24,
                AdditionCard(
                    title: 'code',
                    child: Input(
                      textInputAction: TextInputAction.done,
                      onChange: (p0) {
                        setState(() {
                          codeValue = p0;
                        });
                      },
                    )),
                space32,
                MainButton(
                  onPressed: () {
                    controller.forgotPasswordVerify(
                        passwordValue, codeValue, emailValue);
                  },
                  text: register,
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
