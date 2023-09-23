import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:tureeslii/controllers/auth_controller.dart';
import 'package:tureeslii/controllers/main_controller.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/pages/pages.dart';
import 'package:tureeslii/routes.dart';
import 'package:tureeslii/shared/index.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

final loginKey = GlobalKey<FormState>();
const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

class _LoginViewState extends State<LoginView> {
  String username = '';
  String passwordValue = '';
  bool showPassword = true;
  final AuthController controller = Get.find();
  final mainController = Get.put(MainController());
  CustomSnackbar snackbar = CustomSnackbar();
  loginFunc() async {
    if (loginKey.currentState!.validate()) {
      // loginKey.currentState!.save();
      final user = await controller.login(username, passwordValue);
      print(user);
      if (user is User) {
        Get.toNamed(Routes.main);
        mainController.refreshUser();
      } else {
        snackbar.mainSnackbar(context,
            user.toString().replaceAll("Exception:", ""), SnackBarTypes.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                space8,
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
                      icon: Icon(!showPassword
                          ? Icons.visibility
                          : Icons.visibility_off)),
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
                  child: const Social(
                    text: facebook,
                    icon: Icon(
                      Icons.facebook,
                      color: Color(0xff125099),
                      size: 24,
                    ),
                  ),
                ),
                space20,
                MainButton(
                  color: Colors.white,
                  onPressed: () {
                    debugPrint('asdf');
                  },
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
