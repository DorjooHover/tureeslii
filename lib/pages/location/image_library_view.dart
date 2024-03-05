import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:landlord/controllers/main_controller.dart';

import 'package:landlord/shared/index.dart';

class ImageLibraryView extends StatefulWidget {
  const ImageLibraryView({super.key});

  @override
  State<ImageLibraryView> createState() => _ImageLibraryViewState();
}

class _ImageLibraryViewState extends State<ImageLibraryView> {
  GlobalKey<ScaffoldState> imageLibraryKey = GlobalKey<ScaffoldState>();
  final ImagePicker picker = ImagePicker();

  void selectImages() async {
    final List<XFile> selectedImages = await picker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      controller.imageFiles.addAll(selectedImages);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  bool isDrawer = false;

  final controller = Get.put(MainController());

  choiceType() {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.transparent,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 10,
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: <Widget>[
                      PackageCard(
                          type: '',
                          onPress: () {
                            controller.createPost.value?.id == null
                                ? controller.createNewPost(context)
                                : controller.updatePost(context);
                          }),
                      space16,
                      PackageCard(type: 'promo1', onPress: () {}),
                      space16,
                      PackageCard(type: 'promo2', onPress: () {}),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: bgGray,
            key: imageLibraryKey,
            appBar: MainAppBar(
              back: true,
              logo: false,
              onPressed: () => controller.prevStep(),
              center: Text(
                imagesLibrary,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              actions: [Container()],
              bgColor: bgGray,
              statusBarColor: bgGray,
              child: IconButton(
                onPressed: () {
                  controller.updatePost(context);
                },
                icon: SvgPicture.asset(
                  iconSave,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: origin),
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 63,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    space40,
                    MenuContainer(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              selectImages();
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                images.isNotEmpty ? space20 : space32,
                                Icon(
                                  Icons.upload,
                                  size: images.isNotEmpty ? 24 : 44,
                                ),
                                images.isNotEmpty ? space10 : space16,
                                Text(
                                  addImage,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: black),
                                ),
                                Obx(() => controller.imageFiles.isNotEmpty
                                    ? space32
                                    : const SizedBox()),
                              ],
                            )),
                        Obx(() => controller.imageFiles.isNotEmpty
                            ? GridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 3,
                                padding: EdgeInsets.zero,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                children: controller.imageFiles
                                    .map(
                                      (e) => Stack(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            width: double.infinity,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              child: Image.file(
                                                File(e.path),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                controller.imageFiles.remove(e);
                                              },
                                              child: Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: red),
                                                child: const Icon(
                                                  Icons.delete,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                    .toList(),
                              )
                            : const SizedBox()),
                        Obx(() => controller
                                        .createPost.value!.postAttachments !=
                                    null &&
                                controller.createPost.value!.postAttachments!
                                    .isNotEmpty
                            ? GridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 3,
                                padding: EdgeInsets.zero,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                children: controller
                                    .createPost.value!.postAttachments!
                                    .map(
                                      (e) => Stack(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            width: double.infinity,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '$fileUrl${e.fileThumb}',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                controller.createPost.value!
                                                    .postAttachments!
                                                    .remove(e);
                                              },
                                              child: Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: red),
                                                child: const Icon(
                                                  Icons.delete,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                    .toList(),
                              )
                            : const SizedBox())
                      ],
                    )),
                    space20,
                    Text(
                      '* $imageRequireUnit',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    space4,
                    Text(
                      '* $imageRequireSize',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ),
            drawerScrimColor: Colors.transparent,
            endDrawer: LocationDrawer(selected: controller.verified),
            onEndDrawerChanged: (isOpened) {
              if (isOpened != isDrawer) {
                setState(() {
                  isDrawer = isOpened;
                });
              }
            },
          ),
          if (!isDrawer)
            Positioned(
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).padding.bottom + 80,
              child: Align(
                  alignment: Alignment.center,
                  child: Obx(() => MainButton(
                        onPressed: () {
                          controller.createNewPost(context);
                        },
                        borderRadius: 26,
                        disabled:
                            !images.isNotEmpty || controller.fetchLoading.value,
                        loading: controller.fetchLoading.value,
                        disabledColor: disableColor,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.white),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.add,
                                color: images.isNotEmpty ? prime : disableColor,
                                size: 20,
                              ),
                            ),
                            space20,
                            Obx(() => Text(
                                  controller.createPost.value?.id == null
                                      ? adAdd
                                      : adEdit,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white),
                                ))
                          ],
                        ),
                      ))),
            ),
          if (!isDrawer)
            Positioned(
                bottom: MediaQuery.of(context).padding.bottom,
                left: 0,
                right: 0,
                child: Container(
                  color: bgGray,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(
                      top: 18, right: 16, left: 16, bottom: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.prevStep();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Icon(
                              Icons.arrow_back_ios_rounded,
                              color: prime,
                              size: 24,
                            ),
                            space8,
                            Text(
                              prev,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            right: !isDrawer ? 0 : MediaQuery.of(context).size.width * 0.75,
            curve: Curves.ease,
            bottom: MediaQuery.of(context).size.height * 0.25,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 1) {
                  imageLibraryKey.currentState!.openEndDrawer();
                  setState(() {
                    isDrawer = true;
                  });
                } else {
                  imageLibraryKey.currentState!.closeEndDrawer();
                  setState(() {
                    isDrawer = false;
                  });
                }
              },
              onTap: () {
                if (isDrawer) {
                  imageLibraryKey.currentState!.closeEndDrawer();
                  setState(() {
                    isDrawer = false;
                  });
                } else {
                  imageLibraryKey.currentState!.openEndDrawer();
                  setState(() {
                    isDrawer = true;
                  });
                }
              },
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(imageTriangle), fit: BoxFit.contain)),
                height: 130,
                width: 48,
                padding: const EdgeInsets.only(left: 26),
                alignment: Alignment.center,
                child: Text(
                  '${controller.currentStep.value + 1}',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: blue, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
