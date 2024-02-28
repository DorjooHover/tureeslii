import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/main_controller.dart';
import 'package:landlord/model/models.dart';
import 'package:landlord/shared/index.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PersonalView extends StatefulWidget {
  const PersonalView({super.key});

  @override
  State<PersonalView> createState() => _PersonalViewState();
}

class _PersonalViewState extends State<PersonalView> {
  bool info = true;
  bool product = true;
  final controller = Get.put(MainController());
  String lastNameValue = "",
      firstNameValue = "",
      phoneValue = "",
      companyNameValue = "",
      registerNumberValue = "";
  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      info = controller.user!.orderNotification ?? false;
      product = controller.user!.productAdsNotification ?? false;
      lastNameValue = controller.user!.lastname ?? '';
      firstNameValue = controller.user!.firstname ?? '';
      phoneValue = controller.user!.mobile ?? '';
      companyNameValue = controller.user!.companyName ?? '';
      registerNumberValue = controller.user!.companyRegistry ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGray,
      appBar: MainAppBar(
        back: true,
        logo: false,
        actions: [Container()],
        bgColor: bgGray,
        statusBarColor: bgGray,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: origin,
        ),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: medium),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  personInfo,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: black, fontWeight: FontWeight.w600),
                ),
                space36,
                space20,
                AdditionCard(
                    title: firstName,
                    child: Input(
                      value: lastNameValue,
                      onChange: (p0) {
                        setState(() {
                          lastNameValue = p0;
                        });
                      },
                      textInputAction: TextInputAction.next,
                    )),
                space24,
                AdditionCard(
                    title: name,
                    child: Input(
                      value: firstNameValue,
                      onChange: (p0) {
                        setState(() {
                          firstNameValue = p0;
                        });
                      },
                      textInputAction: TextInputAction.next,
                    )),
                space24,
                AdditionCard(
                    title: email,
                    child: Input(
                        value: controller.user!.email!,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            if (controller.user!.emailVerified != null &&
                                !controller.user!.emailVerified!) {
                              controller.sendEmailVerification();
                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.info(
                                    message: emailVerificationString),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(13),
                            child: Obx(
                              () => SvgPicture.asset(
                                controller.user!.emailVerified!
                                    ? iconVerified
                                    : iconNotVerified,
                              ),
                            ),
                          ),
                        ),
                        borderSide: BorderSide(
                          color: active,
                        ))),
                space24,
                AdditionCard(
                    title: phone,
                    child: Input(
                        value: phoneValue,
                        suffixIcon: GestureDetector(
                          onTap: () async {
                            if (controller.user!.mobileVerified != null &&
                                !controller.user!.mobileVerified!) {
                              await controller.getMobileVerification();

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertContainer(
                                    child: [
                                      Text(
                                        otpString,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: black),
                                      ),
                                      space20,
                                      OtpView(),
                                      space36,
                                      MainButton(
                                        onPressed: () async {
                                          if (!controller.otp.value
                                              .contains('-')) {
                                            final otp = await controller
                                                .sendMobileVerification();
                                            if (otp) {
                                              Navigator.pop(context);
                                              successVerified(context);
                                            }
                                          } else {
                                            Get.snackbar(
                                                'Алдаа', "Дутуу байна");
                                          }
                                        },
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: small, horizontal: 24),
                                        text: verify,
                                      ),
                                      space24,
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            againSend,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(color: orange),
                                          ),
                                        ),
                                      ),
                                      space36
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(13),
                            child: Obx(
                              () => SvgPicture.asset(
                                controller.user!.mobileVerified!
                                    ? iconVerified
                                    : iconNotVerified,
                              ),
                            ),
                          ),
                        ),
                        borderSide: BorderSide(
                          color: active,
                        ))),
                space24,
                AdditionCard(
                    title: companyName,
                    child: Input(
                      value: companyNameValue,
                      onChange: (p0) {
                        setState(() {
                          companyNameValue = p0;
                        });
                      },
                      textInputAction: TextInputAction.next,
                    )),
                space24,
                AdditionCard(
                    title: registerNumber,
                    child: Input(
                      value: registerNumberValue,
                      onChange: (p0) {
                        setState(() {
                          registerNumberValue = p0;
                        });
                      },
                      textInputAction: TextInputAction.next,
                    )),
                space24,
                AdditionCard(
                  title: password,
                  child: Input(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                      child: passwordVisible
                          ? Icon(Icons.draw)
                          : Icon(Icons.draw_rounded),
                    ),
                    maxLine: 1,
                    obscureText: passwordVisible,
                  ),
                ),
                space24,
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  activeColor: prime,
                  activeTrackColor: active,
                  title: Text(
                    infoByEmail,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: black,
                        ),
                  ),
                  value: info,
                  onChanged: (value) {
                    setState(() {
                      info = value;
                    });
                  },
                ),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  activeColor: prime,
                  activeTrackColor: active,
                  title: Text(
                    productByEmail,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: black,
                        ),
                  ),
                  value: product,
                  onChanged: (value) {
                    setState(() {
                      product = value;
                    });
                  },
                ),
                space36,
                MainButton(
                  onPressed: () async {
                    bool res = await controller.savePersonal(User(
                        firstname: firstNameValue,
                        lastname: lastNameValue,
                        mobile: phoneValue,
                        companyRegistry: registerNumberValue,
                        companyName: companyNameValue,
                        orderNotification: info,
                        productAdsNotification: product));
                    if (res) {
                      showTopSnackBar(
                        Overlay.of(context),
                        CustomSnackBar.success(message: Messages.success),
                      );
                    } else {
                      showTopSnackBar(
                        Overlay.of(context),
                        CustomSnackBar.info(message: Messages.incomplete),
                      );
                    }
                  },
                  text: request,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

successVerified(
  BuildContext context,
) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertContainer(
          child: [
            SvgPicture.asset(
              iconSuccess,
              width: 36,
              height: 36,
            ),
            space20,
            Text(
              verifiedPhone,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: black),
              textAlign: TextAlign.center,
            ),
            space64,
          ],
        );
      });
}
