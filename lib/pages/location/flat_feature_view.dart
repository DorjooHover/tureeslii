import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/main_controller.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';

class FlatFeatureView extends StatefulWidget {
  const FlatFeatureView({super.key});

  @override
  State<FlatFeatureView> createState() => _FlatFeatureViewState();
}

class _FlatFeatureViewState extends State<FlatFeatureView> {
  GlobalKey<ScaffoldState> flatFeatureKey = GlobalKey<ScaffoldState>();
  bool isDrawer = false;
  final controller = Get.put(MainController());

  bool elevator = false;
  bool balcony = false;
  bool internet = false;
  bool oven = false;
  bool washing = false;
  bool cabel = false;
  bool refrigerator = false;
  bool kitchen = false;
  bool hasFurniture = false;
  bool drawer = false;
  bool table = false;
  bool chair = false;
  bool sofa = false;
  bool cabinet = false;
  @override
  void initState() {
    super.initState();
    elevator = controller.createPost.value!.elevator!;
    balcony = controller.createPost.value!.balcony! ;
    internet = controller.createPost.value!.wifi! ;
    oven = controller.createPost.value!.stove! ;
    washing = controller.createPost.value!.washingMachine! ;
    cabel = controller.createPost.value!.tvCable! ;
    refrigerator = controller.createPost.value!.refrigerator! ;
    kitchen = controller.createPost.value!.kitchenFurniture! ;
    hasFurniture = controller.createPost.value!.hasFurniture! ;
refrigerator = controller.createPost.value!.furnitures?.contains('refrigerator') ?? false;
drawer = controller.createPost.value!.furnitures?.contains('drawer') ?? false;
table = controller.createPost.value!.furnitures?.contains('table') ?? false;
sofa = controller.createPost.value!.furnitures?.contains('sofa') ?? false;
cabinet = controller.createPost.value!.furnitures?.contains('wardrobe') ?? false;


  }
  nextStep() {
    controller.createPost.value!.elevator = elevator;
    controller.createPost.value!.balcony = balcony;
    controller.createPost.value!.wifi = internet;
    controller.createPost.value!.stove = oven;
    controller.createPost.value!.washingMachine = washing;
    controller.createPost.value!.tvCable = cabel;
    controller.createPost.value!.refrigerator = refrigerator;
    controller.createPost.value!.kitchenFurniture = kitchen;
    controller.createPost.value!.hasFurniture = hasFurniture;
    if (refrigerator) {
      controller.createPost.value!.furnitures?.add('refrigerator');
    }
    if (drawer) {
      controller.createPost.value!.furnitures?.add('drawer');
    }
    if (table) {
      controller.createPost.value!.furnitures?.add('table');
    }
    if (sofa) {
      controller.createPost.value!.furnitures?.add('sofa');
    }
    if (chair) {
      controller.createPost.value!.furnitures?.add('chair');
    }
    if (cabinet) {
      controller.createPost.value!.furnitures?.add('wardrobe');
    }
    controller.nextStep();
    Get.toNamed(Routes.flatInfo);
  }
// CustomSnackbar snackbar = CustomSnackbar();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: bgGray,
            key: flatFeatureKey,
            appBar: MainAppBar(
              back: true,
              logo: false,
              center: Text(
                flatFeature,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              actions: [Container()],
              bgColor: bgGray,
              statusBarColor: bgGray,
              child: IconButton(
                onPressed: () async  {
                  await controller.updatePost([]).then((value) {
                    if(value) {
                      //  snackbar.mainSnackbar(context, successSaved, SnackbarType.success);
                    } else {
                      //  snackbar.mainSnackbar(context, errorOccurred, SnackbarType.warning);
                    }
                  });
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
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom),
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 63,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MenuContainer(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.white,
                          activeTrackColor: active,
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(iconElevator),
                              space13,
                              Text(
                                elevatorStr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: black,
                                    ),
                              ),
                            ],
                          ),
                          value: elevator,
                          onChanged: (value) {
                            setState(() {
                              elevator = value;
                            });
                          },
                        ),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.white,
                          activeTrackColor: active,
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                imageBalcony,
                                width: 16,
                                height: 16,
                              ),
                              space13,
                              Text(
                                balconyStr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: black,
                                    ),
                              ),
                            ],
                          ),
                          value: balcony,
                          onChanged: (value) {
                            setState(() {
                              balcony = value;
                            });
                          },
                        ),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.white,
                          activeTrackColor: active,
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(iconInternet),
                              space13,
                              Text(
                                internetStr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: black,
                                    ),
                              ),
                            ],
                          ),
                          value: internet,
                          onChanged: (value) {
                            setState(() {
                              internet = value;
                            });
                          },
                        ),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.white,
                          activeTrackColor: active,
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(iconOven),
                              space13,
                              Text(
                                ovenStr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: black,
                                    ),
                              ),
                            ],
                          ),
                          value: oven,
                          onChanged: (value) {
                            setState(() {
                              oven = value;
                            });
                          },
                        ),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.white,
                          activeTrackColor: active,
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(iconWashing),
                              space13,
                              Text(
                                washingStr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: black,
                                    ),
                              ),
                            ],
                          ),
                          value: washing,
                          onChanged: (value) {
                            setState(() {
                              washing = value;
                            });
                          },
                        ),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.white,
                          activeTrackColor: active,
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(iconCabel),
                              space13,
                              Text(
                                cabelStr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: black,
                                    ),
                              ),
                            ],
                          ),
                          value: cabel,
                          onChanged: (value) {
                            setState(() {
                              cabel = value;
                            });
                          },
                        ),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.white,
                          activeTrackColor: active,
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(iconRefrigerator),
                              space13,
                              Text(
                                refrigeratorStr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: black,
                                    ),
                              ),
                            ],
                          ),
                          value: refrigerator,
                          onChanged: (value) {
                            setState(() {
                              refrigerator = value;
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
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.white,
                          activeTrackColor: active,
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(iconKitchen),
                              space13,
                              Text(
                                isFurniture,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: black,
                                    ),
                              ),
                            ],
                          ),
                          value: hasFurniture,
                          onChanged: (value) {
                            setState(() {
                              hasFurniture = value;
                            });
                          },
                        ),
                        if (hasFurniture)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SwitchListTile.adaptive(
                                contentPadding: EdgeInsets.zero,
                                activeColor: Colors.white,
                                activeTrackColor: active,
                                title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(iconKitchen),
                                    space13,
                                    Text(
                                      kitchenStr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: black,
                                          ),
                                    ),
                                  ],
                                ),
                                value: kitchen,
                                onChanged: (value) {
                                  setState(() {
                                    kitchen = value;
                                  });
                                },
                              ),
                              SwitchListTile.adaptive(
                                contentPadding: EdgeInsets.zero,
                                activeColor: Colors.white,
                                activeTrackColor: active,
                                title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(iconDrawer),
                                    space13,
                                    Text(
                                      drawerStr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: black,
                                          ),
                                    ),
                                  ],
                                ),
                                value: drawer,
                                onChanged: (value) {
                                  setState(() {
                                    drawer = value;
                                  });
                                },
                              ),
                              SwitchListTile.adaptive(
                                contentPadding: EdgeInsets.zero,
                                activeColor: Colors.white,
                                activeTrackColor: active,
                                title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(iconTable),
                                    space13,
                                    Text(
                                      tableStr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: black,
                                          ),
                                    ),
                                  ],
                                ),
                                value: table,
                                onChanged: (value) {
                                  setState(() {
                                    table = value;
                                  });
                                },
                              ),
                              SwitchListTile.adaptive(
                                contentPadding: EdgeInsets.zero,
                                activeColor: Colors.white,
                                activeTrackColor: active,
                                title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(iconSofa),
                                    space13,
                                    Text(
                                      sofaStr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: black,
                                          ),
                                    ),
                                  ],
                                ),
                                value: sofa,
                                onChanged: (value) {
                                  setState(() {
                                    sofa = value;
                                  });
                                },
                              ),
                              SwitchListTile.adaptive(
                                contentPadding: EdgeInsets.zero,
                                activeColor: Colors.white,
                                activeTrackColor: active,
                                title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(iconChair),
                                    space13,
                                    Text(
                                      chairStr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: black,
                                          ),
                                    ),
                                  ],
                                ),
                                value: chair,
                                onChanged: (value) {
                                  setState(() {
                                    chair = value;
                                  });
                                },
                              ),
                              SwitchListTile.adaptive(
                                contentPadding: EdgeInsets.zero,
                                activeColor: Colors.white,
                                activeTrackColor: active,
                                title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(iconCabinet),
                                    space13,
                                    Text(
                                      cabinetStr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: black,
                                          ),
                                    ),
                                  ],
                                ),
                                value: cabinet,
                                onChanged: (value) {
                                  setState(() {
                                    cabinet = value;
                                  });
                                },
                              ),
                            ],
                          )
                      ],
                    )),
                    space40,
                    space40,
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
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            right: !isDrawer ? 0 : MediaQuery.of(context).size.width * 0.75,
            curve: Curves.ease,
            bottom: MediaQuery.of(context).size.height * 0.25,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                print(details.delta.dx);
                if (details.delta.dx > 1) {
                  flatFeatureKey.currentState!.openEndDrawer();
                  setState(() {
                    isDrawer = true;
                  });
                } else {
                  flatFeatureKey.currentState!.closeEndDrawer();
                  setState(() {
                    isDrawer = false;
                  });
                }
              },
              onTap: () {
                if (isDrawer) {
                  flatFeatureKey.currentState!.closeEndDrawer();
                  setState(() {
                    isDrawer = false;
                  });
                } else {
                  flatFeatureKey.currentState!.openEndDrawer();
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
