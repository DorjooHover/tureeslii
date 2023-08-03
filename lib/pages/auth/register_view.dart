import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tureeslii/controllers/auth_controller.dart';
import 'package:tureeslii/pages/pages.dart';
import 'package:tureeslii/routes.dart';
import 'package:tureeslii/shared/index.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);
  final AuthController controller = Get.find();
  final registerKey = GlobalKey<FormState>();
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
            key: registerKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      registered,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold, color: black),
                    ),
                    MainIconButton(
                      text: login,
                      onPressed: () {
                        Get.toNamed(Routes.auth);
                      },
                      forward: true,
                    ),
                  ],
                ),
                space64,
                MainButton(
                  color: const Color(0xff3A5B95),
                  onPressed: () {},
                  child: const Social(
                      icon: Icon(
                        Icons.facebook,
                        size: 24,
                      ),
                      color: Colors.white,
                      text: facebookRegister),
                ),
                space20,
                MainButton(
                  color: Colors.white,
                  onPressed: () {},
                  child: Social(
                      icon: SvgPicture.asset(
                        iconGmail,
                      ),
                      text: gmailRegister),
                ),
                space20,
                MainButton(
                  color: Colors.white,
                  onPressed: () {},
                  child: const Social(
                      icon: Icon(
                        Icons.apple,
                        color: Colors.black,
                        size: 24,
                      ),
                      text: appleRegister),
                ),
                space24,
                MainButton(
                  color: orange,
                  onPressed: () {
                    Get.to(
                        () => SignInView(
                              edit: false,
                            ),
                        transition: Transition.fade,
                        duration: const Duration(milliseconds: 300));
                  },
                  child: Social(
                      icon: SvgPicture.asset(
                        iconEmail,
                      ),
                      color: Colors.white,
                      text: emailRegister),
                ),
                space24,
                RichText(
                  text: TextSpan(
                    text: conditionStart,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontStyle: FontStyle.italic, color: black),
                    children: <TextSpan>[
                      TextSpan(
                          text: condition,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: orange,
                                  decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              try {
                                launchUrl(Uri.parse(conditionUrl));
                              } catch (e) {
                                print(e);
                              }
                            }),
                      const TextSpan(text: conditionEnd),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
