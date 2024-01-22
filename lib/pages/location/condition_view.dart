import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/main_controller.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';

class ConditionView extends StatefulWidget {
  const ConditionView({super.key});

  @override
  State<ConditionView> createState() => _ConditionViewState();
}

class _ConditionViewState extends State<ConditionView> {
  GlobalKey<ScaffoldState> conditionKey = GlobalKey<ScaffoldState>();
  bool isDrawer = false;
  final controller = Get.put(MainController());

  bool pet = false;
  bool invite = false;
  bool smoke = false;
  bool isLive = false;

  String selectedWhomRent = whomRentValues[0];
  int personCount = 1;
  @override
  void initState() {
    super.initState();
    if(controller.createPost.value?.id != null) {
      setState(() {
        personCount = controller.createPost.value!.acceptedTenants! ;
    pet = controller.createPost.value!.petAllowed! ;
invite=     controller.createPost.value!.guestAllowed!;
    smoke = controller.createPost.value!.smokingAllowed! ;
    isLive = controller.createPost.value!.livingProperty!;
    int whomRentIndex = whomRentValuesValue.indexOf(controller.createPost.value!.acceptedGender!);
    selectedWhomRent =
        whomRentValues[whomRentIndex];
      });
    }
  }

  nextStep() {
    controller.createPost.value!.acceptedTenants = personCount;
    controller.createPost.value!.petAllowed = pet;
    controller.createPost.value!.guestAllowed = invite;
    controller.createPost.value!.smokingAllowed = smoke;
    controller.createPost.value!.livingProperty = isLive;
    int whomRentIndex = whomRentValues.indexOf(selectedWhomRent);
    controller.createPost.value!.acceptedGender =
        whomRentValuesValue[whomRentIndex];
    controller.nextStep();
    Get.toNamed(Routes.flatFeature);
  }
  // CustomSnackbar snackbar = CustomSnackbar();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: bgGray,
            key: conditionKey,
            appBar: MainAppBar(
              back: true,
              logo: false,
              center: Text(
                conditionRestriction,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              actions: [Container()],
              bgColor: bgGray,
              statusBarColor: bgGray,
              child: IconButton(
                onPressed: () async {await controller.updatePost([]).then((value) {
                    if(value) {
                      //  snackbar.mainSnackbar(context, successSaved, SnackbarType.success);
                    } else {
                      //  snackbar.mainSnackbar(context, errorOccurred, SnackbarType.warning);
                    }
                  });},
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
                                title: whomRent,
                                child: DropDown(
                                  list: whomRentValues,
                                  value: selectedWhomRent,
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        selectedWhomRent = value;
                                      });
                                    }
                                  },
                                )),
                            space24,
                            AdditionCard(
                                title: personNumber,
                                child: Input(
                                  value: personCount.toString(),
                                  textInputType: TextInputType.number,
                                  inputFormatter: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChange: (p0) {
                                    setState(() {
                                      personCount = int.tryParse(p0) ?? 1;
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
                              requiredThings,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: black,
                                      fontWeight: FontWeight.bold),
                            ),
                            SwitchListTile.adaptive(
                              contentPadding: EdgeInsets.zero,
                               activeColor: prime,
                              activeTrackColor: active,
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(iconPet),
                                  space13,
                                  Text(
                                    petStr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: black,
                                        ),
                                  ),
                                ],
                              ),
                              value: pet,
                              onChanged: (value) {
                                setState(() {
                                  pet = value;
                                });
                              },
                            ),
                            SwitchListTile.adaptive(
                              contentPadding: EdgeInsets.zero,
                              activeColor: prime,
                              activeTrackColor: active,
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(iconInvite),
                                  space13,
                                  Text(
                                    inviteStr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: black,
                                        ),
                                  ),
                                ],
                              ),
                              value: invite,
                              onChanged: (value) {
                                setState(() {
                                  invite = value;
                                });
                              },
                            ),
                            SwitchListTile.adaptive(
                              contentPadding: EdgeInsets.zero,
                               activeColor: prime,
                              activeTrackColor: active,
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(iconSmoke),
                                  space13,
                                  Text(
                                    smokeStr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: black,
                                        ),
                                  ),
                                ],
                              ),
                              value: smoke,
                              onChanged: (value) {
                                setState(() {
                                  smoke = value;
                                });
                              },
                            ),
                            SwitchListTile.adaptive(
                              contentPadding: EdgeInsets.zero,
                               activeColor: prime,
                              activeTrackColor: active,
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(iconIsLive),
                                  space13,
                                  Text(
                                    isLiveStr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: black,
                                        ),
                                  ),
                                ],
                              ),
                              value: isLive,
                              onChanged: (value) {
                                setState(() {
                                  isLive = value;
                                });
                              },
                            ),
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
                      padding: const EdgeInsets.only(
                          top: 18, right: 16, left: 16, bottom: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
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
                  conditionKey.currentState!.openEndDrawer();
                  setState(() {
                    isDrawer = true;
                  });
                } else {
                  conditionKey.currentState!.closeEndDrawer();
                  setState(() {
                    isDrawer = false;
                  });
                }
              },
              onTap: () {
                if (isDrawer) {
                  conditionKey.currentState!.closeEndDrawer();
                  setState(() {
                    isDrawer = false;
                  });
                } else {
                  conditionKey.currentState!.openEndDrawer();
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
