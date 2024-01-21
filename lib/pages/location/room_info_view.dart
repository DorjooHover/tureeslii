import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:landlord/controllers/main_controller.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';

class RoomInfoView extends StatefulWidget {
  const RoomInfoView({super.key});

  @override
  State<RoomInfoView> createState() => _RoomInfoViewState();
}

class _RoomInfoViewState extends State<RoomInfoView> {
  GlobalKey<ScaffoldState> roomInfoView = GlobalKey<ScaffoldState>();
  bool isDrawer = false;
  final controller = Get.put(MainController());

  int selectedType = 0;
  String titleValue = "";
  int kitchenValue = 0;
  int bathRoomValue = 0;
  int livingRoomValue = 0;
  int bedRoomValue = 0;
  int bedOneValue = 0;
  int bedTwoValue = 0;
  // CustomSnackbar snackbar = CustomSnackbar();
  Future nextStep() async {
    if (titleValue == '') {
      // snackbar.mainSnackbar(context, incompleteTitle, SnackbarType.error);
      return;
    }
    controller.createPost.value!.singleBed = bedOneValue;
    controller.createPost.value!.doubleBed = bedTwoValue;
    controller.createPost.value!.bedroom = bedRoomValue;
    controller.createPost.value!.bathroom = bathRoomValue;
    controller.createPost.value!.livingRoom = livingRoomValue;
    controller.createPost.value!.kitchen = kitchenValue;
    controller.createPost.value!.title = titleValue;
    controller.createPost.value!.category = selectedType;
    controller.nextStep();
    Get.toNamed(Routes.imageLibrary);
  }

  @override
  void initState() {
    super.initState();
    if (controller.allCategory.isNotEmpty) {
      setState(() {
        selectedType = controller.allCategory[0].id!;
      });
    } else {
      controller.getCategories();
    }

    setState(() {
      bedOneValue =  controller.createPost.value!.singleBed == null ? 0 : controller.createPost.value!.singleBed!;
    bedTwoValue =  controller.createPost.value!.singleBed == null ? 0 : controller.createPost.value!.doubleBed!;
    bedRoomValue =  controller.createPost.value!.singleBed == null ? 0 : controller.createPost.value!.bedroom!;
    bathRoomValue =  controller.createPost.value!.singleBed == null ? 0 : controller.createPost.value!.bathroom!;
    livingRoomValue =  controller.createPost.value!.singleBed == null ? 0 : controller.createPost.value!.livingRoom!;
    kitchenValue =  controller.createPost.value!.singleBed == null ? 0 : controller.createPost.value!.kitchen!;
    selectedType = controller.createPost.value!.category!['id'];
    controller.createPost.value!.category = controller.createPost.value!.category['id'];
    titleValue = controller.createPost.value!.title!;
    });
   

  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: bgGray,
            key: roomInfoView,
            appBar: MainAppBar(
              back: true,
              logo: false,
              center: Text(
                roomInfo,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              actions: [Container()],
              bgColor: bgGray,
              statusBarColor: bgGray,
              child: IconButton(
                onPressed: () async {
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
            body: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: origin),
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
                                title: title,
                                child: Input(
                                  value: titleValue,
                                  textInputAction: TextInputAction.next,
                                  onChange: (p0) {
                                    titleValue = p0;
                                  },
                                )),
                            space24,
                            AdditionCard(
                                title: typeStr,
                                child: DropDown(
                                  list: const [],
                                  value: '',
                                  child: DropdownButton(
                                      isDense: true,
                                      icon: SvgPicture.asset(iconArrowDown),
                                      iconEnabledColor: gray,
                                      isExpanded: true,
                                      dropdownColor: Colors.white,
                                      value: controller.allCategory.isNotEmpty
                                          ? controller.allCategory
                                              .firstWhere((element) =>
                                                  element.id == selectedType)
                                              .name!
                                          : '',
                                      hint: Text(choose,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: labelGray)),
                                      underline: const SizedBox(),
                                      items: controller.allCategory.map((e) {
                                        return DropdownMenuItem(
                                          value: e.name!,
                                          child: Text(
                                            e.name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: black),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          final i = controller.allCategory
                                              .indexWhere((element) =>
                                                  element.name == value);
                                          setState(() {
                                            selectedType = i;
                                          });
                                        }
                                      }),
                                  onChanged: (value) {},
                                )),
                            space24,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: AdditionCard(
                                      title: kitchenRoom,
                                      child: Input(
                                         value: kitchenValue.toString(),
                                        textInputType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        inputFormatter: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        onChange: (p0) {
                                          
                                            setState(() {
                                            kitchenValue = int.tryParse(p0) ?? 0;
                                            
                                          });
                                        },
                                      )),
                                ),
                                space16,
                                Expanded(
                                  child: AdditionCard(
                                      title: bathRoom,
                                      child: Input(
                                        value: bathRoomValue.toString(),
                                        textInputType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        inputFormatter: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        onChange: (p0) {
                                          setState(() {
                                            bathRoomValue = int.tryParse(p0) ?? 0;
                                          });
                                        },
                                      )),
                                ),
                              ],
                            ),
                            space24,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: AdditionCard(
                                      title: livingRoom,
                                      child: Input(
                                        value: livingRoomValue.toString(),
                                        textInputType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        inputFormatter: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        onChange: (p0) {
                                          setState(() {
                                            livingRoomValue = int.tryParse(p0) ?? 0;
                                          });
                                        },
                                      )),
                                ),
                                space16,
                                Expanded(
                                  child: AdditionCard(
                                      title: bedRoom,
                                      child: Input(
                                        value: bedRoomValue.toString(),
                                        textInputType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        inputFormatter: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        onChange: (p0) {
                                          setState(() {
                                            bedRoomValue = int.tryParse(p0) ?? 0;
                                          });
                                        },
                                      )),
                                ),
                              ],
                            ),
                            space24,
                            if (bedRoomValue > 0)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: AdditionCard(
                                        title: bedOne,
                                        child: Input(
                                          value: bedOneValue.toString(),
                                          textInputType: TextInputType.number,
                                          textInputAction: TextInputAction.next,
                                          inputFormatter: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          onChange: (p0) {
                                            setState(() {
                                              bedOneValue = int.tryParse(p0) ?? 0;
                                            });
                                          },
                                        )),
                                  ),
                                  space16,
                                  Expanded(
                                    child: AdditionCard(
                                        title: bedTwo,
                                        child: Input(
                                          value: bedTwoValue.toString(),
                                          textInputType: TextInputType.number,
                                          inputFormatter: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          onChange: (p0) {
                                            setState(() {
                                              bedTwoValue = int.tryParse(p0) ?? 0;
                                            });
                                          },
                                          onSubmitted: ((p0) {
                                            nextStep();
                                          }),
                                        )),
                                  ),
                                ],
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
                  roomInfoView.currentState!.openEndDrawer();
                  setState(() {
                    isDrawer = true;
                  });
                } else {
                  roomInfoView.currentState!.closeEndDrawer();
                  setState(() {
                    isDrawer = false;
                  });
                }
              },
              onTap: () {
                if (isDrawer) {
                  roomInfoView.currentState!.closeEndDrawer();
                  setState(() {
                    isDrawer = false;
                  });
                } else {
                  roomInfoView.currentState!.openEndDrawer();
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
