import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/auth_controller.dart';
import 'package:landlord/shared/index.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final editKey = GlobalKey<FormState>();
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgGray,
        appBar: const MainAppBar(
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
                        controller: controller.email,
                        textInputAction: TextInputAction.next,
                        onChange: (p0) {
                          controller.email.text = p0;
                        },
                      )),
                  space24,
                  MainButton(
                    onPressed: () {
                      controller.forgotPassword(context);
                    },
                    text: 'Мартсан',
                    width: double.infinity,
                  ),
                  space32,
                  AdditionCard(
                      title: password,
                      child: Input(
                        controller: controller.password,
                        textInputAction: TextInputAction.done,
                        onChange: (p0) {
                          controller.password.text = p0;
                        },
                      )),
                  space24,
                  AdditionCard(
                      title: 'code',
                      child: Input(
                        controller: controller.code,
                        textInputAction: TextInputAction.done,
                        onChange: (p0) {
                          controller.code.text = p0;
                        },
                      )),
                  space32,
                  MainButton(
                    onPressed: () {
                      controller.forgotPasswordVerify(context);
                    },
                    text: register,
                    width: double.infinity,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
