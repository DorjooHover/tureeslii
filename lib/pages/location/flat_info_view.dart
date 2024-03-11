import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/main_controller.dart';

import 'package:landlord/shared/index.dart';

class FlatInfoView extends StatefulWidget {
  const FlatInfoView({super.key});

  @override
  State<FlatInfoView> createState() => _FlatInfoViewState();
}

class _FlatInfoViewState extends State<FlatInfoView> {
  GlobalKey<ScaffoldState> flatInfoView = GlobalKey<ScaffoldState>();
  bool isDrawer = false;
  final controller = Get.put(MainController());

  int selectedHeating = 0, selectedWaterSupply = 0, selectedToilet = 0;
  int flatArea = 0;
  @override
  void initState() {
    super.initState();
    if (controller.createPost.value?.id != null) {
      setState(() {
        flatArea = controller.createPost.value!.plot?.round() ?? 0;
        selectedHeating = heatingValuesValue.indexOf(
            controller.createPost.value!.heating ?? heatingValuesValue[0]);
        selectedWaterSupply = waterSupplyValuesValue.indexOf(
            controller.createPost.value!.waterSupply ??
                waterSupplyValuesValue[0]);
        selectedToilet = toiletValuesValue.indexOf(
            controller.createPost.value!.restroom ?? toiletValuesValue[0]);
      });
    }
  }

  nextStep(bool edit) {
    bool success = true;
    String message = '';
    if (flatArea <= 0) {
      success = false;
      message = 'Талбайгаа оруулна уу';
    }

    controller.createPost.value!.plot = flatArea.toDouble();
    controller.createPost.value!.heating = heatingValuesValue[selectedHeating];
    controller.createPost.value!.waterSupply =
        waterSupplyValuesValue[selectedWaterSupply];
    controller.createPost.value!.restroom = toiletValuesValue[selectedToilet];
    edit
        ? controller.updatePost(context)
        : controller.nextStep(
            success,
            context,
            message,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: bgGray,
            key: flatInfoView,
            appBar: MainAppBar(
              back: true,
              logo: false,
              center: Text(
                flatInfo,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              onPressed: () => controller.prevStep(),
              actions: [Container()],
              bgColor: bgGray,
              statusBarColor: bgGray,
              child: IconButton(
                onPressed: () {
                  nextStep(true);
                },
                icon: SvgPicture.asset(
                  iconSave,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            body: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: origin),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 63,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom + 80),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MenuContainer(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            AdditionCard(
                                title: heating,
                                child: DropDown(
                                  list: heatingValues,
                                  value: heatingValues[selectedHeating],
                                  onChanged: (value) {
                                    if (value != null) {
                                      final i = heatingValues.indexOf(value);
                                      setState(() {
                                        selectedHeating = i;
                                      });
                                    }
                                  },
                                )),
                            space24,
                            AdditionCard(
                                title: waterSupple,
                                child: DropDown(
                                  list: waterSupplyValues,
                                  value: waterSupplyValues[selectedWaterSupply],
                                  onChanged: (value) {
                                    if (value != null) {
                                      final i =
                                          waterSupplyValues.indexOf(value);
                                      setState(() {
                                        selectedWaterSupply = i;
                                      });
                                    }
                                  },
                                )),
                            space24,
                            AdditionCard(
                                title: toilet,
                                child: DropDown(
                                  list: toiletValues,
                                  value: toiletValues[selectedToilet],
                                  onChanged: (value) {
                                    if (value != null) {
                                      final i = toiletValues.indexOf(value);
                                      setState(() {
                                        selectedToilet = i;
                                      });
                                    }
                                  },
                                )),
                            space24,
                            AdditionCard(
                                title: area,
                                child: Input(
                                  value: flatArea.toString(),
                                  textInputType: TextInputType.number,
                                  onSubmitted: (p0) {
                                    nextStep(false);
                                  },
                                  inputFormatter: onlyUnsignedNumbers(),
                                  onChange: (p0) {
                                    setState(() {
                                      flatArea = int.tryParse(p0) ?? 0;
                                    });
                                  },
                                )),
                          ],
                        )),
                        space40,
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: MediaQuery.of(context).padding.bottom,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: bgGray,
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
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
                                Icon(
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
                          GestureDetector(
                            onTap: () {
                              nextStep(false);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  next,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                space8,
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: prime,
                                  size: 24,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
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
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            right: !isDrawer ? 0 : MediaQuery.of(context).size.width * 0.75,
            curve: Curves.ease,
            bottom: MediaQuery.of(context).size.height * 0.25,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 1) {
                  flatInfoView.currentState!.openEndDrawer();
                  setState(() {
                    isDrawer = true;
                  });
                } else {
                  flatInfoView.currentState!.closeEndDrawer();
                  setState(() {
                    isDrawer = false;
                  });
                }
              },
              onTap: () {
                if (isDrawer) {
                  flatInfoView.currentState!.closeEndDrawer();
                  setState(() {
                    isDrawer = false;
                  });
                } else {
                  flatInfoView.currentState!.openEndDrawer();
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
                child: Obx(() => Text(
                  '${controller.currentStep.value + 1}',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: blue, fontWeight: FontWeight.bold),
                ),)
              ),
            ),
          )
        ],
      ),
    );
  }
}
