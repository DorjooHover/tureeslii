import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/auth_controller.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key, required this.isRegister, this.user});
  final bool isRegister;
  final User? user;
  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final editKey = GlobalKey<FormState>();

  String firstnameValue = "";
  String lastnameValue = "";
  String emailValue = "";
  String phoneValue = "";
  final AuthController controller = Get.find();
  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      setState(() {
        firstnameValue = widget.user!.firstname!;
        lastnameValue = widget.user!.lastname!;
        emailValue = widget.user!.email!;
        phoneValue = widget.user!.mobile!;
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
        actions: [Container()],
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
                    title: name,
                    child: Input(
                      onChange: (p0) {
                        setState(() {
                          lastnameValue = p0;
                        });
                      },
                    )),
                space24,
                AdditionCard(
                    title: firstName,
                    child: Input(
                      onChange: (p0) {
                        setState(() {
                          firstnameValue = p0;
                        });
                      },
                    )),
                space24,
                AdditionCard(
                    title: email,
                    child: Input(
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
                      onChange: (p0) {
                        setState(() {
                          phoneValue = p0;
                        });
                      },
                    )),
                space32,
                MainButton(
                  onPressed: () {
                    if (widget.isRegister) {
                      controller
                          .register(emailValue, phoneValue, firstnameValue,
                              lastnameValue, "")
                          .then((value) => Get.toNamed(Routes.auth));
                    } else {}
                  },
                  text: widget.isRegister ? register : save,
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
