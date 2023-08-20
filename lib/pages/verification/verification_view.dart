import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:landlord/controllers/main_controller.dart';
import 'package:landlord/shared/index.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final verificationKey = GlobalKey<FormState>();
  String selectedBank = bankValues[0];
  String accountNumberValue = "";
  String accountNameValue = "";
  final ImagePicker picker = ImagePicker();
  final ImagePicker backPicker = ImagePicker();
  XFile? frontImage;
  XFile? backImage;
  bool loading = false;
  void selectImage(bool isFront) async {
    if (!loading) {
      final XFile? selectedImages = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      setState(() {
        loading = true;
      });
      if (selectedImages != null) {
        if (isFront) {
          setState(() {
            frontImage = selectedImages;
          });
        } else {
          setState(() {
            backImage = selectedImages;
          });
        }
      }
    }
    setState(() {
      loading = false;
    });
  }

  final controller = Get.put(MainController());
  @override
  void initState() {
    super.initState();
    if (controller.banks.isNotEmpty) {
      setState(() {
        selectedBank = controller.banks[0];
      });
    }
  }

  submit() async {
    if (frontImage != null || backImage != null) {
      await controller.sendVerificationUser(frontImage!, backImage!,
          selectedBank, accountNumberValue, accountNameValue);
      // if (res) {
      //   Get.snackbar(title, 'Амжилттай');
      // }
    }
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
        padding:
            const EdgeInsets.symmetric(horizontal: origin, vertical: medium),
        width: double.infinity,
        height: MediaQuery.of(context).size.height - 63,
        child: SingleChildScrollView(
          child: Form(
            key: verificationKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  verification,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: black, fontWeight: FontWeight.w600),
                ),
                space36,
                Row(
                  children: <Widget>[
                    Expanded(
                        child: AdditionCard(
                            title: front,
                            child: GestureDetector(
                              onTap: () {
                                selectImage(true);
                              },
                              child: Container(
                                width: double.infinity,
                                height: 96,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: divider),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: small),
                                alignment: Alignment.center,
                                child: frontImage != null
                                    ? Image.file(
                                        File(frontImage!.path),
                                        fit: BoxFit.cover,
                                      )
                                    : SvgPicture.asset(
                                        iconAddImage,
                                        width: 40,
                                      ),
                              ),
                            ))),
                    space16,
                    Expanded(
                        child: AdditionCard(
                            title: back,
                            child: GestureDetector(
                              onTap: () {
                                selectImage(false);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: divider),
                                ),
                                width: double.infinity,
                                height: 96,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: small),
                                child: backImage != null
                                    ? Image.file(
                                        File(backImage!.path),
                                        fit: BoxFit.cover,
                                      )
                                    : SvgPicture.asset(
                                        iconAddImage,
                                        width: 40,
                                      ),
                              ),
                            ))),
                  ],
                ),
                space16,
                Text(
                  yourId,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontStyle: FontStyle.italic, color: black),
                ),
                space24,
                AdditionCard(
                  title: bank,
                  child: DropDown(
                    list: controller.banks,
                    value: selectedBank,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedBank = value;
                        });
                      }
                    },
                  ),
                ),
                space24,
                AdditionCard(
                    title: accountNumber,
                    child: Input(
                      onChange: (p0) {
                        setState(() {
                          accountNumberValue = p0;
                        });
                      },
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                    )),
                space24,
                AdditionCard(
                    title: accountName,
                    child: Input(
                      onChange: (p0) {
                        setState(() {
                          accountNameValue = p0;
                        });
                      },
                      onSubmitted: ((p0) {
                        submit();
                      }),
                    )),
                space36,
                MainButton(
                  onPressed: () {
                    submit();
                  },
                  text: request,
                  width: double.infinity,
                ),
                space40
              ],
            ),
          ),
        ),
      ),
    );
  }
}
