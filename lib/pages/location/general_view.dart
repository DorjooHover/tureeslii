import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/main_controller.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';

class GeneralView extends StatefulWidget {
  const GeneralView({super.key});

  @override
  State<GeneralView> createState() => _GeneralViewState();
}

class _GeneralViewState extends State<GeneralView> {
  final GlobalKey<ScaffoldState> generalKey = GlobalKey<ScaffoldState>();
  bool isDrawer = false;
  final controller = Get.put(MainController());

  bool isDay = false,
      isMonth = false,
      flatPrice = false,
      sokh = false,
      electronic = false,
      internet = false,
      bailMoney = false;

  String startRentDateValue = "2023/08/12";
  double rentPriceValue = 0.0, minimumRentDayValue = 0.0;

  String selectedContractCondition = contractConditionValues[0],
      selectedPaymentCondition = paymentConditionValues[0],
      selectedBailCondition = bailConditionValues[0],
      selectedCancelCondition = cancelConditionValues[0];
  void nextStep() {
    if (startRentDate != '' &&
        rentPriceValue > 0 &&
        minimumRentDayValue > 0 &&
        selectedBailCondition != '' &&
        selectedPaymentCondition != '' &&
        selectedContractCondition != '' &&
        selectedCancelCondition != '') {
      controller.createPost.value!.startDate = startRentDateValue;
      controller.createPost.value!.priceTerm = selectedContractCondition;
      controller.createPost.value!.cancelTerm = selectedCancelCondition;
      controller.createPost.value!.dailyRent = isDay;
      controller.createPost.value!.price = rentPriceValue;
      controller.createPost.value!.priceDaily = minimumRentDayValue;
      controller.createPost.value!.monthlyRent = isMonth;
      controller.createPost.value!.depositRequired = flatPrice;
      // controller.createPost.value!.depositRequired = sokh;
      if (electronic) {
        controller.createPost.value!.priceIncluded?.add('electric');
      }
      if (internet) {
        controller.createPost.value!.priceIncluded?.add('internet');
      }
      controller.createPost.value!.paymentTerm = selectedPaymentCondition;
      // controller.createPost.value!. = selectedPaymentCondition ;
      controller.createPost.value!.depositTerm = selectedPaymentCondition;
      // controller.createPost.value!.depositRequired = sokh;
      controller.nextStep();
      Get.toNamed(Routes.condition);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: bgGray,
            key: generalKey,
            appBar: MainAppBar(
              back: true,
              logo: false,
              center: Text(
                general,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              actions: [Container()],
              bgColor: bgGray,
              statusBarColor: bgGray,
              child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  iconSave,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: origin),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 80),
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 63,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MenuContainer(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        AdditionCard(title: startRentDate, child: Input()),
                        space24,
                        AdditionCard(
                            mark: true,
                            title: contractCondition,
                            child: DropDown(
                              list: contractConditionValues,
                              value: selectedContractCondition,
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    selectedContractCondition = value;
                                  });
                                }
                              },
                            )),
                        space24,
                        AdditionCard(
                            mark: true,
                            title: cancelCondition,
                            child: DropDown(
                              list: cancelConditionValues,
                              value: selectedCancelCondition,
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    selectedCancelCondition = value;
                                  });
                                }
                              },
                            )),
                      ],
                    )),
                    space40,
                    MenuContainer(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            canDay,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: black, fontWeight: FontWeight.bold),
                          ),
                          value: isDay,
                          onChanged: (value) {
                            setState(() {
                              isDay = value;
                            });
                          },
                        ),
                        space24,
                        AdditionCard(
                            title: rentPrice,
                            child: Input(
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onChange: (p0) {
                                setState(() {
                                  rentPriceValue = double.parse(p0);
                                });
                              },
                            )),
                        space24,
                        AdditionCard(
                            title: minimumRentDay,
                            child: Input(
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onChange: (p0) {
                                setState(() {
                                  rentPriceValue = double.parse(p0);
                                });
                              },
                            )),
                      ],
                    )),
                    space40,
                    MenuContainer(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            canMonth,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: black, fontWeight: FontWeight.bold),
                          ),
                          value: isMonth,
                          onChanged: (value) {
                            setState(() {
                              isMonth = value;
                            });
                          },
                        ),
                        space24,
                        AdditionCard(
                            title: rentPrice,
                            child: Input(
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onChange: (p0) {
                                setState(() {
                                  rentPriceValue = double.parse(p0);
                                });
                              },
                            )),
                        space24,
                        AdditionCard(
                            title: minimumRentDay,
                            child: Input(
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onChange: (p0) {
                                setState(() {
                                  minimumRentDayValue = double.parse(p0);
                                });
                              },
                            )),
                      ],
                    )),
                    space40,
                    MenuContainer(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          inPayment,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: black, fontWeight: FontWeight.bold),
                        ),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.white,
                          activeTrackColor: active,
                          title: Text(
                            flatPriceStr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: black,
                                ),
                          ),
                          value: flatPrice,
                          onChanged: (value) {
                            setState(() {
                              flatPrice = value;
                            });
                          },
                        ),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.white,
                          activeTrackColor: active,
                          title: Text(
                            sokhStr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: black,
                                ),
                          ),
                          value: sokh,
                          onChanged: (value) {
                            setState(() {
                              sokh = value;
                            });
                          },
                        ),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.white,
                          activeTrackColor: active,
                          title: Text(
                            eletronicStr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: black,
                                ),
                          ),
                          value: electronic,
                          onChanged: (value) {
                            setState(() {
                              electronic = value;
                            });
                          },
                        ),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.white,
                          activeTrackColor: active,
                          title: Text(
                            internetStr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: black,
                                ),
                          ),
                          value: internet,
                          onChanged: (value) {
                            setState(() {
                              internet = value;
                            });
                          },
                        ),
                      ],
                    )),
                    space40,
                    MenuContainer(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AdditionCard(
                            title: paymentCondition,
                            child: DropDown(
                              list: paymentConditionValues,
                              value: selectedPaymentCondition,
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    selectedPaymentCondition = value;
                                  });
                                }
                              },
                            )),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.white,
                          activeTrackColor: active,
                          title: Text(
                            bailMoneyStr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: black,
                                ),
                          ),
                          value: bailMoney,
                          onChanged: (value) {
                            setState(() {
                              bailMoney = value;
                            });
                          },
                        ),
                        AdditionCard(
                            title: bailCondition,
                            child: DropDown(
                              list: bailConditionValues,
                              value: selectedBailCondition,
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    selectedBailCondition = value;
                                  });
                                }
                              },
                            )),
                      ],
                    )),
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
                        Get.toNamed(Routes.location);
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
                        nextStep();
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
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            right: !isDrawer ? 0 : MediaQuery.of(context).size.width * 0.75,
            curve: Curves.ease,
            bottom: MediaQuery.of(context).size.height * 0.25,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 1) {
                  generalKey.currentState!.openEndDrawer();
                  setState(() {
                    isDrawer = true;
                  });
                } else {
                  generalKey.currentState!.closeEndDrawer();
                  setState(() {
                    isDrawer = false;
                  });
                }
              },
              onTap: () {
                if (isDrawer) {
                  generalKey.currentState!.closeEndDrawer();
                  setState(() {
                    isDrawer = false;
                  });
                } else {
                  generalKey.currentState!.openEndDrawer();
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
                  (controller.currentStep.value + 1).toString(),
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
