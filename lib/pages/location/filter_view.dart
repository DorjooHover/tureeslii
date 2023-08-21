import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tureeslii/controllers/main_controller.dart';
import 'package:tureeslii/model/error_handler.dart';
import 'package:tureeslii/shared/index.dart';

class FilterView extends StatefulWidget {
  const FilterView({
    super.key,
    required this.func,
  });
  final Function(List<FilterData>) func;

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  bool collateral = false;

  List<FilterData> filterData = [];
  List<int> type = [];
  List<FilterData> includedFee = [];
  List<FilterData> others = [];
  List<bool> verificationValue = [];

  FilterData paymentConditionValue = paymentConditionValues[0];
  String floorValue = filterFloor[0];
  double startPaymentValue = 200000;
  double endPaymentValue = 4500000;
  double sliderMax = 4500000;
  String timeType = byMonth;
  final loading = false.obs;
  String duration = '1';
  String startDate = '';
  final controller = Get.put(MainController());

  reset() async {
    setState(() {
      collateral = false;
      type = [];
      includedFee = [];
      others = [];
      verificationValue = [];

      paymentConditionValue = paymentConditionValues[0];
      floorValue = filterFloor[0];

      timeType = byMonth;
      filterData = [];
    });
  }

  @override
  void initState() {
    super.initState();
    start();
  }

  search() async {
    loading.value = true;

    // timeType
    filterData.add(
      FilterData(
          field: timeType == byMonth ? "monthlyRent" : 'dailyRent',
          op: "=",
          qry: true),
    );
    // start date
    if (startDate != '') {
      filterData.add(FilterData(field: "startDate", op: "<=", qry: startDate));
    }
    // duration

    filterData.add(FilterData(field: "rentDuration", op: "=", qry: duration));

    // category fix
    if (type.isNotEmpty) {
      filterData.add(FilterData(field: "categoryId", op: "IN", qry: type));
    }
    // deposit
    if (collateral) {
      filterData
          .add(FilterData(field: "depositRequired", op: "=", qry: collateral));
    }
    // payment term
    if (paymentConditionValue.name != 'Бүгд') {
      filterData.add(FilterData(
          field: "paymentTerm", op: "=", qry: paymentConditionValue));
    }
    if (timeType == byMonth) {
      // price
      filterData
          .add(FilterData(field: "price", op: ">=", qry: startPaymentValue));
      filterData
          .add(FilterData(field: "price", op: "<=", qry: endPaymentValue));
    } else {
      // price daily
      filterData.add(
          FilterData(field: "priceDaily", op: ">=", qry: startPaymentValue));
      filterData
          .add(FilterData(field: "priceDaily", op: ">=", qry: endPaymentValue));
    }
    // price included
    if (includedFee.isNotEmpty) {
      filterData.addAll(includedFee);
    }
    // floor

    if (floorValue == filterFloor[0]) {
      filterData.add(FilterData(field: "floor", op: ">=", qry: 1));
    } else if (floorValue == filterFloor[1]) {
      filterData.add(FilterData(field: "floor", op: ">=", qry: 2));
      filterData.add(FilterData(field: "floor", op: "=<", qry: 5));
    } else if (floorValue == filterFloor[2]) {
      filterData.add(FilterData(field: "floor", op: ">", qry: 5));
    }
    // other
    if (others.isNotEmpty) {
      filterData.addAll(others);
    }
    // verification
    if (verificationValue.isNotEmpty) {
      filterData.add(
          FilterData(field: "special", op: "=", qry: verificationValue.first));
    }

    await controller.getAllPosts(0, 10, SortData(), filterData);
    for (int i = 0; i < filterData.length; i++) {
      print(filterData[i]);
    }
    print(controller.allPosts);

    widget.func(filterData);
    loading.value = false;
  }

  start() async {
    reset();
    List<dynamic> res = await controller.getPostPriceRange(FilterData());
    if (res.length > 1) {
      setState(() {
        startPaymentValue = double.parse(res.first['price'].toString());
        endPaymentValue = double.parse(res.last['price'].toString());
        sliderMax = endPaymentValue;
      });
    }
    setState(() {
      timeType = controller.timeType.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGray,
      appBar: MainAppBar(
        bgColor: Colors.white,
        statusBarColor: Colors.white,
        back: true,
        logo: false,
        child: TextButton(
            onPressed: () {
              reset();
            },
            child: Text(
              startAgain,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: black, fontWeight: FontWeight.bold),
            )),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height - 63,
          padding: const EdgeInsets.symmetric(
            horizontal: origin,
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    space16,
                    RowRadio(
                      border: const Border(),
                      groupValue: timeType,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            timeType = value;
                          });
                        }
                      },
                      list: const [byMonth, byDay],
                    ),
                    space24,
                    RowFlex(
                      child1: AdditionCard(
                          title: time,
                          color: black,
                          child: ShadowContainer(
                            child: DropDown(
                              list: [
                                '1',
                                '2',
                                '3',
                                '4',
                                '5',
                                '6',
                                '7',
                                '8',
                                '9',
                                '10',
                                '11',
                                '12',
                                '12+'
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    duration = value;
                                  });
                                }
                              },
                              value: duration,
                            ),
                          )),
                      child: AdditionCard(
                        title: startRentDate,
                        color: black,
                        child: ShadowContainer(
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
                                        return DatePickerThemeWidget(child: child!);
                                      });
                              if (selectedDate != null) {
                                setState(() {
                                  startDate = selectedDate.toString();
                                });
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: 13),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: black, width: 1),
                              ),
                              child: Text(
                                startDate != ""
                                    ? startDate.substring(0, 10)
                                    : startDate,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    space36,
                    space4,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        typeStr,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    space8,
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: origin,
                      crossAxisSpacing: origin,
                      childAspectRatio: 171 / 46,
                      controller: ScrollController(keepScrollOffset: false),
                      children: controller.allCategory
                          .map((e) => RowCheckBox(
                                onChanged: (bool? value) {
                                  if (value == true) {
                                    type.add(e.id!);
                                  } else {
                                    type.remove(e.id!);
                                  }
                                  setState(() {});
                                },
                                text: e.name!,
                                value: type
                                    .where((element) => element == e.id!)
                                    .isNotEmpty,
                              ))
                          .toList(),
                    ),
                    space36,
                    space4,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        itemsIncludedFee,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    space8,
                    ShadowContainer(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '${currencyFormat(startPaymentValue, false)}₮',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: black),
                                ),
                                Text(
                                  '${currencyFormat(endPaymentValue, false)}₮',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: black),
                                )
                              ],
                            ),
                            space16,
                            RangeSlider(
                              inactiveColor: sliderGray,
                              activeColor: orange,
                              max: sliderMax,
                              values: RangeValues(
                                  startPaymentValue, endPaymentValue),
                              onChanged: (values) {
                                setState(() {
                                  startPaymentValue = values.start;
                                  endPaymentValue = values.end;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    space16,
                    RowCheckBox(
                      onChanged: (bool? value) {
                        setState(() {
                          collateral = value!;
                        });
                      },
                      text: collaterals[0],
                      value: collateral,
                    ),
                    space16,
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 0,
                              blurRadius: 15,
                              offset: const Offset(
                                  0, 0), // changes position of shadow
                            )
                          ]),
                      child: AdditionCard(
                          title: paymentCondition,
                          child: RowRadio(
                            border: const Border(),
                            groupValue: paymentConditionValue.name!,
                            onChanged: (value) {
                              FilterData data =
                                  paymentConditionValues.firstWhere((element) =>
                                      element.name == value.toString());
                              setState(() {
                                paymentConditionValue = data;
                              });
                            },
                            list: paymentConditionValues
                                .map((e) => e.name!)
                                .toList(),
                          )),
                    ),
                    space36,
                    space4,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        itemsIncludedFee,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    space8,
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: origin,
                      crossAxisSpacing: origin,
                      childAspectRatio: 171 / 46,
                      controller: ScrollController(keepScrollOffset: false),
                      children: filterItemsIncludedFee
                          .map((e) => RowCheckBox(
                                onChanged: (bool? value) {
                                  if (value == true) {
                                    includedFee.add(e);
                                  } else {
                                    includedFee.remove(e);
                                  }
                                  setState(() {});
                                },
                                text: e.name!,
                                value: includedFee
                                    .where((element) => element == e)
                                    .isNotEmpty,
                              ))
                          .toList(),
                    ),
                    space36,
                    space4,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        other,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    space8,
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 0,
                              blurRadius: 15,
                              offset: const Offset(
                                  0, 0), // changes position of shadow
                            )
                          ]),
                      child: AdditionCard(
                          title: floor,
                          child: RowRadio(
                            border: const Border(),
                            groupValue: floorValue,
                            onChanged: (value) {
                              setState(() {
                                floorValue = value!;
                              });
                            },
                            list: filterFloor,
                          )),
                    ),
                    space16,
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: origin,
                      crossAxisSpacing: origin,
                      childAspectRatio: 171 / 46,
                      controller: ScrollController(keepScrollOffset: false),
                      children: filterOther
                          .map((e) => RowCheckBox(
                                onChanged: (bool? value) {
                                  if (value == true) {
                                    others.add(e);
                                  } else {
                                    others.remove(e);
                                  }
                                  setState(() {});
                                },
                                text: e.name!,
                                value: others
                                    .where((element) => element == e)
                                    .isNotEmpty,
                              ))
                          .toList(),
                    ),
                    space36,
                    space4,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        verification,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    space8,
                    space8,
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: origin,
                      crossAxisSpacing: origin,
                      childAspectRatio: 171 / 46,
                      controller: ScrollController(keepScrollOffset: false),
                      children: filterVerification
                          .map((e) => RowCheckBox(
                                onChanged: (bool? value) {
                                  if (value == true) {
                                    if (verificationValue.isNotEmpty) {
                                      verificationValue = [];
                                    } else {
                                      if (e == 'Баталгаажсан') {
                                        verificationValue.add(false);
                                      } else {
                                        verificationValue.add(true);
                                      }
                                    }
                                  } else {
                                    if (e == 'Баталгаажсан') {
                                      verificationValue.remove(false);
                                    } else {
                                      verificationValue.remove(true);
                                    }
                                  }

                                  setState(() {});
                                },
                                text: e,
                                value: (verificationValue.isNotEmpty &&
                                        verificationValue.first == false &&
                                        e == 'Баталгаажсан') ||
                                    (verificationValue.isNotEmpty &&
                                        verificationValue.first == true &&
                                        e == 'Онцлох'),
                              ))
                          .toList(),
                    ),
                    space32,
                    space64
                  ],
                ),
              ),
              Positioned(
                  bottom: large,
                  left: 0,
                  right: 0,
                  child: MainButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      if (!loading.value) {
                        await search();
                      }
                    },
                    padding: const EdgeInsets.symmetric(
                        vertical: small, horizontal: 24),
                    text: search1,
                  )),
            ],
          )),
    );
  }
}

class RowFlex extends StatelessWidget {
  const RowFlex({super.key, required this.child, required this.child1});
  final Widget child;
  final Widget child1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(child: child),
        space16,
        Flexible(child: child1)
      ],
    );
  }
}



/*
startdate
{
            "field": "startDate",
            "op": "<=",
            "qry": "2023-08-16"

        }

duration
 {
            "field": "rentDuration",
            "op": "=",
            "qry": "5000"

        }

    
     
   



        */