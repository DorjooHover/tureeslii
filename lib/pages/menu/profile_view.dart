import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tureeslii/routes.dart';
import 'package:tureeslii/shared/index.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool info = true;
  bool product = false;
  String sex = male;
  String workStatus = working;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: origin, vertical: large),
            child: Column(
              children: [
                _mainContact(context),
                space45,
                MenuContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        settings.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: profileTitle,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      space16,
                      SwitchListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          infoByEmail,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: black),
                        ),
                        value: info,
                        onChanged: (value) {
                          setState(() {
                            info = value;
                          });
                        },
                      ),
                      space24,
                      SwitchListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          productByEmail,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: black),
                        ),
                        value: product,
                        onChanged: (value) {
                          setState(() {
                            info = value;
                          });
                        },
                      ),
                      space32,
                      Divider(
                        color: divider,
                        height: 1,
                        thickness: 1,
                      ),
                      space24,
                      MainIconButton(
                        text: logout,
                        color: black,
                        onPressed: () {},
                        back: true,
                        mainAxisAlignment: MainAxisAlignment.start,
                        child: SvgPicture.asset(iconLogout),
                      ),
                      space20,
                      MainIconButton(
                        text: deleteAccount,
                        color: red,
                        mainAxisAlignment: MainAxisAlignment.start,
                        back: true,
                        onPressed: () {},
                        child: SvgPicture.asset(iconDeleteAccount),
                      )
                    ],
                  ),
                ),
                space45,
                MenuContainer(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          additionInfo.toUpperCase(),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: profileTitle,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SvgPicture.asset(iconArrowUp)
                      ],
                    ),
                    space13,
                    AdditionCard(title: birthday, child: Input()),
                    space24,
                    AdditionCard(
                        title: gender,
                        child: RowRadio(
                          groupValue: sex,
                          onChanged: (value) {
                            setState(() {
                              sex = value!;
                            });
                          },
                          list: [male, female],
                        )),
                    space24,
                    AdditionCard(title: family, child: Input()),
                    space24,
                    AdditionCard(
                        title: isWork,
                        child: RowRadio(
                          groupValue: workStatus,
                          onChanged: (value) {
                            setState(() {
                              workStatus = value!;
                            });
                          },
                          list: [working, studying],
                        )),
                    space24,
                    AdditionCard(title: whereWork, child: Input()),
                    space24,
                    AdditionCard(title: profession, child: Input()),
                    space24,
                    AdditionCard(
                        title: howRent,
                        child: DropDown(
                            list: ['exp1', 'exp2'],
                            value: '',
                            onChanged: (String? v) {})),
                    space24,
                    AdditionCard(title: incomeRent, child: Input()),
                    space24,
                    AdditionCard(
                        title: briefInformation,
                        child: Input(
                          maxLine: 3,
                          textInputType: TextInputType.multiline,
                          onChange: (p0) {},
                        )),
                    space24,
                    MainButton(
                      onPressed: () {
                        Get.snackbar(
                          '',
                          '',
                          margin: EdgeInsets.zero,
                          snackPosition: SnackPosition.BOTTOM,
                          maxWidth: MediaQuery.of(context).size.width,
                          backgroundColor: green,
                          animationDuration: const Duration(milliseconds: 300),
                          forwardAnimationCurve: Curves.easeOut,
                          borderRadius: 0,
                          messageText: Container(),
                          titleText: Row(
                            children: <Widget>[
                              SvgPicture.asset(iconSuccessWhite),
                              space13,
                              Text(
                                successSaved,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                        );
                      },
                      padding: const EdgeInsets.symmetric(
                          vertical: small, horizontal: 24),
                      text: save,
                    )
                  ],
                ))
              ],
            )),
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

_mainContact(BuildContext context) {
  return MenuContainer(
      child: Column(
    children: [
      ProfileCard(icon: false, value: name, title: 'Булганмөр Шинэцас'),
      space27,
      ProfileCard(
        icon: true,
        value: phone,
        title: '99162729',
        verified: true,
      ),
      space27,
      ProfileCard(
        icon: true,
        value: email,
        title: 'shineeBB8@gmail.com',
        verified: false,
        onPressed: () {
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
                    onPressed: () {
                      Navigator.pop(context);
                      successVerified(context);
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
        },
      ),
      space27,
      ProfileCard(
        icon: false,
        value: password,
        title: '**************',
        edit: true,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertContainer(
                child: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                  ),
                  AdditionCard(title: oldPassword, child: Input()),
                  space24,
                  AdditionCard(title: newPassword, child: Input()),
                  space24,
                  AdditionCard(title: newPassword, child: Input()),
                  space24,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MainButton(
                      onPressed: () {
                        Get.snackbar(
                          '',
                          '',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: green,
                          animationDuration: const Duration(milliseconds: 300),
                          forwardAnimationCurve: Curves.easeOut,
                          borderRadius: 0,
                          messageText: Container(),
                          titleText: Row(
                            children: <Widget>[
                              SvgPicture.asset(iconSuccessWhite),
                              space13,
                              Text(
                                successSaved,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                        );
                        Navigator.pop(context);
                      },
                      padding: const EdgeInsets.symmetric(
                          vertical: small, horizontal: 24),
                      text: save,
                    ),
                  ),
                  space16
                ],
              );
            },
          );
        },
      ),
      space27,
      Divider(color: divider, height: 1, thickness: 1),
      space16,
      MainIconButton(
        text: edit,
        onPressed: () {
          Get.toNamed(Routes.editProfile);
        },
        back: true,
        color: gray,
        child: SvgPicture.asset(iconEdit),
      )
    ],
  ));
}
