import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/main_controller.dart';
import 'package:landlord/shared/index.dart';

class GeneralView extends StatefulWidget {
  const GeneralView({super.key});

  @override
  State<GeneralView> createState() => _GeneralViewState();
}

class _GeneralViewState extends State<GeneralView> {
  GlobalKey<ScaffoldState> generalKey = GlobalKey<ScaffoldState>();
  bool isDrawer = false;
  final controller = Get.put(MainController());

  bool isDay = false,
      isMonth = true,
      flatPrice = false,
      sokh = false,
      electronic = false,
      internet = false,
      bailMoney = false;

  String startRentDateValue = DateTime.now().toString().substring(0, 10);
  int rentPriceValue = 0;
  int rentPriceMonthValue = 0;
  int minimumRentDayValue = 1, minimumRentMonthValue = 1;
  String selectedContractCondition = contractConditionValues[0],
      selectedPaymentCondition = paymentConditionValues[0],
      selectedBailCondition = bailConditionValues[0];
  int selectedCancelCondition = 0;

  @override
  void initState() {
    super.initState();
    if (controller.cancelTerm.isNotEmpty) {
      selectedCancelCondition = controller.cancelTerm.first.id!;
    } else {
      controller.getCancellation();
    }
    if (controller.createPost.value?.id != null) {
      setState(() {
        isDay = controller.createPost.value!.dailyRent!;
        //  selectedCancelCondition =  int.tryParse(controller.createPost.value!.cancelTerm) ??  controller.cancelTerm.first.id!;
        startRentDateValue =
            controller.createPost.value!.startDate!.substring(0, 10);
        bailMoney = controller.createPost.value!.depositRequired!;
        isMonth = controller.createPost.value!.monthlyRent!;
        rentPriceMonthValue = controller.createPost.value!.price!.round();
        rentPriceValue = controller.createPost.value!.priceDaily!.round();
        minimumRentDayValue = controller.createPost.value!.minDurationDaily!;
        minimumRentMonthValue =
            controller.createPost.value!.minDurationMonthly!;

        final paymentCondIndex = paymentConditionValuesValue.indexWhere(
            (element) => element == controller.createPost.value?.paymentTerm);
        selectedPaymentCondition = paymentConditionValues[paymentCondIndex];
        final bailCondIndex = bailConditionValuesValue.indexWhere(
            (element) => element == controller.createPost.value?.depositTerm);
        selectedBailCondition = bailConditionValues[bailCondIndex];
        final contractCondIndex = contractConditionValuesValue.indexWhere(
            (element) => element == controller.createPost.value?.priceTerm);
        selectedContractCondition = contractConditionValues[contractCondIndex];
      });
    }
  }

  Future nextStep(bool edit) async {
    bool success = true;
    String message = '';
    if (!isDay && !isMonth) {
      success = false;
      message = chooseAnyOptionInRentType;
    }
    if (isDay && minimumRentDayValue > 30) {
      success = false;
      message = inDayCanNot30Day;
    }

    controller.createPost.value!.cancelTerm = selectedCancelCondition;
    controller.createPost.value!.startDate = startRentDateValue;
    controller.createPost.value!.depositRequired = bailMoney;
    controller.createPost.value!.monthlyRent = isMonth;
    controller.createPost.value!.dailyRent = isDay;
    final bailCondIndex = bailConditionValues
        .indexWhere((element) => element == selectedBailCondition);
    controller.createPost.value!.depositTerm =
        bailConditionValuesValue[bailCondIndex];
    final paymentCondIndex = paymentConditionValues
        .indexWhere((element) => element == selectedPaymentCondition);
    controller.createPost.value!.paymentTerm =
        paymentConditionValuesValue[paymentCondIndex];
    final contractCondIndex = contractConditionValues
        .indexWhere((element) => element == selectedContractCondition);
    controller.createPost.value!.priceTerm =
        contractConditionValuesValue[contractCondIndex];

    controller.createPost.value!.price = rentPriceMonthValue.toDouble();
    controller.createPost.value!.priceDaily = rentPriceValue.toDouble();
    controller.createPost.value!.minDurationDaily = minimumRentDayValue;
    controller.createPost.value!.minDurationMonthly = minimumRentMonthValue;

    if (electronic) {
      controller.createPost.value!.priceIncluded?.add('electric');
    }
    if (internet) {
      controller.createPost.value!.priceIncluded?.add('internet');
    }
    if (sokh) {
      controller.createPost.value!.priceIncluded?.add('cox');
    }
    if (flatPrice) {
      controller.createPost.value!.priceIncluded?.add('apartment_fees');
    }

    if (controller.createPost.value!.priceIncluded == null) {
      controller.createPost.value!.priceIncluded = [];
    }

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
              onPressed: () {
                controller.prevStep();
              },
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
                            AdditionCard(
                              title: startRentDate,
                              child: GestureDetector(
                                onTap: () async {
                                  final DateTime now = DateTime.now();
                                  final DateTime? selectedDate =
                                      await showDatePicker(
                                          context: context,
                                          initialDate: now,
                                          firstDate: DateTime(
                                              now.year, now.month, now.day),
                                          lastDate: DateTime(now.year + 10),
                                          builder: (context, child) {
                                            return DatePickerThemeWidget(
                                                child: child!);
                                          });
                                  if (selectedDate != null) {
                                    setState(() {
                                      startRentDateValue = selectedDate
                                          .toString()
                                          .substring(0, 10);
                                    });
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: black, width: 1),
                                  ),
                                  child: Text(
                                    startRentDateValue,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: black),
                                  ),
                                ),
                              ),
                            ),
                            if (isMonth) space24,
                            if (isMonth)
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
                                  value: controller.cancelTerm.isNotEmpty
                                      ? controller
                                          .cancelTerm[selectedCancelCondition]
                                          .name!
                                      : "",
                                  onChanged: (value) {
                                    if (value != null) {
                                      int i = controller.cancelTerm.indexWhere(
                                          (element) => element.name == value);
                                      setState(() {
                                        selectedCancelCondition = i;
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
                              activeColor: Colors.white,
                              activeTrackColor: active,
                              title: Text(
                                canDay,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: black,
                                        fontWeight: FontWeight.bold),
                              ),
                              value: isDay,
                              onChanged: (value) {
                                setState(() {
                                  isDay = value;
                                });
                              },
                            ),
                            if (isDay) space24,
                            if (isDay)
                              AdditionCard(
                                  title: rentPrice,
                                  child: Input(
                                    value: rentPriceValue.toString(),
                                    textInputType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    inputFormatter: onlyUnsignedNumbers(),
                                    onChange: (p0) {
                                      setState(() {
                                        rentPriceValue = int.tryParse(p0) ?? 0;
                                      });
                                    },
                                  )),
                            if (isDay) space24,
                            if (isDay)
                              AdditionCard(
                                  title: minimumRentDay,
                                  child: Input(
                                    value: minimumRentDayValue.toString(),
                                    textInputType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    inputFormatter: onlyUnsignedNumbers(),
                                    onChange: (p0) {
                                      setState(() {
                                        minimumRentDayValue =
                                            int.tryParse(p0) ?? 1;
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
                              activeColor: Colors.white,
                              activeTrackColor: active,
                              title: Text(
                                canMonth,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: black,
                                        fontWeight: FontWeight.bold),
                              ),
                              value: isMonth,
                              onChanged: (value) {
                                setState(() {
                                  isMonth = value;
                                });
                              },
                            ),
                            if (isMonth) space24,
                            if (isMonth)
                              AdditionCard(
                                  title: rentPrice,
                                  child: Input(
                                    value: rentPriceMonthValue.toString(),
                                    textInputType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    inputFormatter: onlyUnsignedNumbers(),
                                    onChange: (p0) {
                                      setState(() {
                                        rentPriceMonthValue =
                                            int.tryParse(p0) ?? 0;
                                      });
                                    },
                                  )),
                            if (isMonth) space24,
                            if (isMonth)
                              AdditionCard(
                                  title: minimumRentMonth,
                                  child: Input(
                                    value: minimumRentMonthValue.toString(),
                                    textInputType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    inputFormatter: onlyUnsignedNumbers(),
                                    onChange: (p0) {
                                      setState(() {
                                        minimumRentMonthValue =
                                            int.tryParse(p0) ?? 1;
                                      });
                                    },
                                  )),
                          ],
                        )),
                        if (isMonth) space40,
                        if (isMonth)
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
                                        color: black,
                                        fontWeight: FontWeight.bold),
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
                            if (bailMoney)
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
                Positioned(
                    bottom: MediaQuery.of(context).padding.bottom,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: bgGray,
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.prevStep();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 18, right: 16, left: 16, bottom: 32),
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
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              nextStep(false);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 18, right: 16, left: 16, bottom: 32),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    next,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  space8,
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: prime,
                                    size: 24,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                Positioned(
                    bottom: MediaQuery.of(context).padding.bottom,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: bgGray,
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.prevStep();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 18, right: 16, left: 16, bottom: 32),
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
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              nextStep(false);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 18, right: 16, left: 16, bottom: 32),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    next,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
                          image: AssetImage(imageTriangle),
                          fit: BoxFit.contain)),
                  height: 130,
                  width: 48,
                  padding: const EdgeInsets.only(left: 26),
                  alignment: Alignment.center,
                  child: Obx(
                    () => Text(
                      '${controller.currentStep.value + 1}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: blue, fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
