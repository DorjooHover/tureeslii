import 'package:flutter/material.dart';
import 'package:landlord/shared/index.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  String date = byMonth;
  bool collateral = false;
  List<String> type = [];
  List<String> includedFee = [];
  List<String> others = [];
  List<String> verificationValue = [];

  String paymentConditionValue = paymentConditionValues[0];
  String floorValue = filterFloor[0];
  double startPaymentValue = 200000;
  double endPaymentValue = 4500000;
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
            onPressed: () {},
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
                      groupValue: date,
                      onChanged: (value) {
                        setState(() {
                          date = value!;
                        });
                      },
                      list: [byMonth, byDay],
                    ),
                    space24,
                    RowFlex(
                      child: AdditionCard(
                          title: startRentDate,
                          color: black,
                          child: ShadowContainer(child: Input())),
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
                                '12'
                              ],
                              onChanged: (value) {},
                              value: '1',
                            ),
                          )),
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
                      children: filterType
                          .map((e) => RowCheckBox(
                                onChanged: (bool? value) {
                                  if (value == true) {
                                    type.add(e);
                                  } else {
                                    type.remove(e);
                                  }
                                  setState(() {});
                                },
                                text: e,
                                value: type
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
                              min: 150000,
                              max: 5000000,
                              values: RangeValues(
                                  startPaymentValue, endPaymentValue),
                              onChanged: (values) {
                                print(startPaymentValue);
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
                            groupValue: paymentConditionValue,
                            onChanged: (value) {
                              setState(() {
                                paymentConditionValue = value!;
                              });
                            },
                            list: paymentConditionValues,
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
                                text: e,
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
                          title: paymentCondition,
                          child: RowRadio(
                            border: const Border(),
                            groupValue: floor,
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
                                text: e,
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
                                    verificationValue.add(e);
                                  } else {
                                    verificationValue.remove(e);
                                  }
                                  setState(() {});
                                },
                                text: e,
                                value: verificationValue
                                    .where((element) => element == e)
                                    .isNotEmpty,
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
                    onPressed: () {
                      Navigator.pop(context);
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
