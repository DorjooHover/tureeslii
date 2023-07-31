import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tureeslii/controllers/auth_controller.dart';
import 'package:tureeslii/controllers/main_controller.dart';
import 'package:tureeslii/model/models.dart';
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

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  clientId:
      '76220807252-1bv8ec6lunm0cl3o7ug2nr47qfurlllr.apps.googleusercontent.com',
  scopes: scopes,
);

class _LoginViewState extends State<LoginView> {
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false;
  handleSignIn() async {
    try {
      await _googleSignIn.signIn().then((value) => print(value));
      _googleSignIn.onCurrentUserChanged
          .listen((GoogleSignInAccount? account) async {
        // In mobile, being authenticated means being authorized...
        bool isAuthorized = account != null;
        // However, in the web...
        if (kIsWeb && account != null) {
          isAuthorized = await _googleSignIn.canAccessScopes(scopes);
        }
        print(account);

        setState(() {
          _currentUser = account;
          _isAuthorized = isAuthorized;
        });
        // if (isAuthorized) {
        //   unawaited(_handleGetContact(account!));
        // }
      });
      _googleSignIn.signInSilently();
    } catch (error) {
      print(error);
    }
  }

  String username = '';
  String passwordValue = '';

  final AuthController controller = Get.find();
  final mainController = Get.put(MainController());

  loginFunc() async {
    if (loginKey.currentState!.validate()) {
      // loginKey.currentState!.save();
      final user = await controller.login(username, passwordValue);
      if (user is User) {
        mainController.getUser(user);
        Get.toNamed(Routes.main);
      } else {
        Get.snackbar('Алдаа', user.toString());
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
                  obscureText: true,
                  maxLine: 1,
                  onChange: (p0) {
                    setState(() {
                      passwordValue = p0;
                    });
                  },
                  onSubmitted: (p0) {
                    loginFunc();
                  },
                ),
                space16,
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      debugPrint('asdf');
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

                    handleSignIn();
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
