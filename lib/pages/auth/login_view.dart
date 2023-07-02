import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tureeslii/controllers/auth_controller.dart';
import 'package:tureeslii/routes.dart';
import 'package:tureeslii/shared/index.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final AuthController controller = Get.find();
  final loginKey = GlobalKey<FormState>();
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
            key: loginKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  email,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: bodyText),
                ),
                space8,
                Input(
                  textInputAction: TextInputAction.next,
                ),
                space32,
                space8,
                Text(
                  password,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: bodyText),
                ),
                space8,
                Input(),
                space16,
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      forgotPassword,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: red),
                    ),
                  ),
                ),
                space24,
                MainButton(
                  onPressed: () {},
                  text: login,
                  width: double.infinity,
                ),
                space24,
                const MainSpacer(text: or),
                space24,
                MainButton(
                  color: Colors.white,
                  onPressed: () {},
                  child: Social(
                      icon: const Icon(
                        Icons.facebook,
                        color: Color(0xff125099),
                        size: 24,
                      ),
                      text: facebook),
                ),
                space20,
                MainButton(
                  color: Colors.white,
                  onPressed: () {},
                  child: Social(
                      icon: SvgPicture.asset(
                        iconGmail,
                      ),
                      text: gmail),
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
                      text: apple),
                ),
                space24,
                const MainSpacer(text: or),
                space24,
                MainIconButton(
                    text: register,
                    onPressed: () {
                      Get.toNamed(Routes.getRegisterRoute());
                    },
                    back: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
