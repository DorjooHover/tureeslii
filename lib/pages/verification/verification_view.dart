import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:landlord/controllers/main_controller.dart';
import 'package:landlord/shared/index.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final verificationKey = GlobalKey<FormState>();
  String? selectedBank;
  final ImagePicker picker = ImagePicker();
  final ImagePicker backPicker = ImagePicker();
  String? fImage;
  String? bImage;
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

  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  final controller = Get.put(MainController());
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await controller.getVerification();

    if (controller.banks.isNotEmpty) {
      setState(() {
        selectedBank = controller.banks[0];
      });
    }
    if (controller.verification.value != null) {
      int bankIndex = controller.banks
          .indexWhere((p0) => p0 == controller.verification.value!.bankName);
      accountNumberController.text =
          controller.verification.value!.bankAccNo ?? '';
      accountNameController.text =
          controller.verification.value!.bankAccName ?? '';
      setState(() {
        selectedBank = controller.banks[bankIndex];
        fImage = controller.verification.value!.front;
        bImage = controller.verification.value!.back;
      });
    }
  }

  submit() async {
    if (fImage == null && frontImage == null) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.info(message: "Урд талын зургаа оруулна уу."),
      );
      return;
    }

    if (bImage == null && backImage == null) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.info(message: "Ард талын зургаа оруулна уу."),
      );
      return;
    }
    if (accountNumberController.text == "") {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.info(message: "Дансны дугаараа оруулна уу."),
      );
      return;
    }
    if (accountNameController.text == "") {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.info(
            message: "Данс эзэмшигчийн нэрээ оруулна уу."),
      );
      return;
    }

    bool res = await controller.sendVerificationUser(
        frontImage,
        backImage,
        selectedBank!,
        accountNumberController.text,
        accountNameController.text);
    if (res) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(message: Messages.success),
      );
    } else {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.info(message: tryAgain),
      );

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
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: origin, vertical: medium),
            width: double.infinity,
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
                                    child: fImage != null
                                        ? frontImage == null
                                            ? CachedNetworkImage(
                                                imageUrl: "$fileUrl$fImage",
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
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
                                    child: bImage != null
                                        ? backImage == null
                                            ? CachedNetworkImage(
                                                imageUrl: "$fileUrl$bImage",
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
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
                        value: selectedBank ?? controller.banks[0],
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
                          controller: accountNumberController,
                          onChange: (p0) {
                            setState(() {
                              accountNumberController.text = p0;
                            });
                          },
                          inputFormatter: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number,
                        )),
                    space24,
                    AdditionCard(
                        title: accountName,
                        child: Input(
                          controller: accountNameController,
                          onChange: (p0) {
                            setState(() {
                              accountNameController.text = p0;
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
        ],
      ),
    );
  }
}
