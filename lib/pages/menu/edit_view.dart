import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tureeslii/controllers/auth_controller.dart';
import 'package:tureeslii/controllers/main_controller.dart';
import 'package:tureeslii/shared/index.dart';

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
  void initState() {
    super.initState();
    if (widget.edit) {
      setState(() {
        lastNamValue = mainController.user!.lastname ?? "";
        firstNameValue = mainController.user!.firstname ?? "";
        phoneValue = mainController.user!.mobile ?? "";
      });
    }
  }

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
                                value: firstNameValue,
                                onChange: (p0) {
                                  setState(() {
                                    firstNameValue = p0;
                                  });
                                },
                              )),
                          space24,
                          AdditionCard(
                              title: lastname,
                              child: Input(
                                textInputAction: TextInputAction.next,
                                value: lastNamValue,
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
                                value: mainController.user!.email ?? "",
                                textInputAction: TextInputAction.next,
                                onChange: (p0) {},
                              )),
                          space24,
                          AdditionCard(
                              title: phone,
                              child: Input(
                                value: phoneValue,
                                textInputAction: TextInputAction.done,
                                onChange: (p0) {
                                  setState(() {
                                    phoneValue = p0;
                                  });
                                },
                                onSubmitted: (p0) async {
                                  bool res = await mainController.savePersonal(
                                      lastNamValue, firstNameValue, phoneValue);

                                  if (res) {
                                    Get.snackbar(
                                        'Амжилттай', "Амжилттай хадгаллаа");
                                  } else {
                                    Get.snackbar('Алдаа', "");
                                  }
                                  Navigator.of(context).pop();
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
                                      emailValue, passwordValue);
                                },
                              )),
                        ],
                      ),
                space32,
                MainButton(
                  onPressed: () async {
                    if (widget.edit) {
                      bool res = await mainController.savePersonal(
                          lastNamValue, firstNameValue, phoneValue);
                      if (res) {
                        Get.snackbar('Амжилттай', "Амжилттай хадгаллаа");
                      } else {
                        Get.snackbar('Алдаа', "");
                      }
                    } else {
                      controller.registerEmail(emailValue, passwordValue);
                    }
                    Navigator.of(context).pop();
                  },
                  text: widget.edit ? save : register,
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
