import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/auth_controller.dart';
import 'package:landlord/controllers/main_controller.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/pages/auth/forgot_password_view.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginKey = GlobalKey<FormState>();
  final AuthController controller = Get.find();
  final mainController = Get.put(MainController());
  String username = "";
  String passwordValue = "";
  bool showPassword = true;
  // CustomSnackbar snackbar = CustomSnackbar();
  loginFunc() async {
    final user = await controller.login(username, passwordValue);

    if (user is User) {
      Get.toNamed(Routes.main);
      mainController.refreshUser();
    } else {
      // snackbar.mainSnackbar(context, user.toString(), SnackbarType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGray,
      appBar: MainAppBar(
        bgColor: bgGray,
        statusBarColor: bgGray,
        back: false,
        menu: false,
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
                  onChange: (p0) {
                    setState(() {
                      username = p0;
                    });
                  },
                ),
                space32,
                // space8,
                Text(
                  password,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: bodyText),
                ),
                space8,
                Input(
                  obscureText: showPassword,
                  maxLine: 1,
                  onChange: (p0) {
                    setState(() {
                      passwordValue = p0;
                    });
                  },
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: Icon(showPassword
                          ? Icons.visibility
                          : Icons.visibility_off)),
                  onSubmitted: (p0) {
                    loginFunc();
                  },
                ),
                space16,
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => ForgotPasswordView());
                    },
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
                  onPressed: () {
                    loginFunc();
                  },
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
                      Get.toNamed(Routes.register);
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
