import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/auth_controller.dart';
import 'package:landlord/controllers/main_controller.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key, this.edit = true});
  final bool edit;
  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final editKey = GlobalKey<FormState>();
  final controller = Get.put(AuthController());
  final mainController = Get.put(MainController());
  String passwordValue = "", emailValue = "";
  String lastNamValue = "", firstNameValue = "", phoneValue = "";
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
                widget.edit
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          AdditionCard(
                              title: name,
                              child: Input(
                                textInputAction: TextInputAction.next,
                                onChange: (p0) {
                                  setState(() {
                                    firstNameValue = p0;
                                  });
                                },
                              )),
                          space24,
                          AdditionCard(
                              title: firstName,
                              child: Input(
                                textInputAction: TextInputAction.next,
                                onChange: (p0) {
                                  setState(() {
                                    lastNamValue = p0;
                                  });
                                },
                              )),
                          space24,
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
                          AdditionCard(
                              title: phone,
                              child: Input(
                                textInputAction: TextInputAction.done,
                                onChange: (p0) {
                                  setState(() {
                                    phoneValue = p0;
                                  });
                                },
                                onSubmitted: (p0) {
                                  mainController.savePersonal(User(
                                      lastname: lastNamValue,
                                      firstname: firstNameValue,
                                      mobile: phoneValue));
                                },
                              ))
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
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
                          AdditionCard(
                              title: password,
                              child: Input(
                                onChange: (p0) {
                                  setState(() {
                                    passwordValue = p0;
                                  });
                                },
                                onSubmitted: (p0) {
                                  controller.registerEmail(
                                      emailValue, passwordValue, context);
                                },
                              )),
                        ],
                      ),
                space32,
                Obx(() => MainButton(
                      loading: controller.fetchLoading.value,
                      onPressed: () {
                        controller.registerEmail(
                            emailValue, passwordValue, context);
                      },
                      text: widget.edit ? save : register,
                      width: double.infinity,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
