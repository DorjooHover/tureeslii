import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';
import 'package:image_picker/image_picker.dart';
class ImageLibraryView extends StatefulWidget {
  const ImageLibraryView({super.key});

  @override
  State<ImageLibraryView> createState() => _ImageLibraryViewState();
}

class _ImageLibraryViewState extends State<ImageLibraryView> {
  XFile? image;

  final ImagePicker picker = ImagePicker();
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }
  final GlobalKey<ScaffoldState> imageLibraryKey = GlobalKey<ScaffoldState>();
  bool isDrawer = false;

  List<int> verified = [0, 1, 2, 3, 4, 5];
  bool isDay = false;
  bool isMonth = false;
  bool flatPrice = false;
  bool sokh = false;
  bool electronic = false;
  bool internet = false;
  bool bailMoney = false;

  String selectedContractCondition = contractConditionValues[0];
  String selectedPaymentCondition = paymentConditionValues[0];
  String selectedBailCondition = bailConditionValues[0];
  String selectedCancelCondition = cancelConditionValues[0];
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
                              onChanged: (value) {},
                            )),
                        space24,
                        AdditionCard(
                            mark: true,
                            title: cancelCondition,
                            child: DropDown(
                              list: cancelConditionValues,
                              value: selectedCancelCondition,
                              onChanged: (value) {},
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
                            child: Input(textInputType: TextInputType.number)),
                        space24,
                        AdditionCard(
                            title: minimumRentDay,
                            child: Input(textInputType: TextInputType.number)),
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
                            child: Input(textInputType: TextInputType.number)),
                        space24,
                        AdditionCard(
                            title: minimumRentDay,
                            child: Input(textInputType: TextInputType.number)),
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
                              onChanged: (value) {},
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
                              onChanged: (value) {},
                            )),
                      ],
                    )),
                  ],
                ),
              ),
            ),
            drawerScrimColor: Colors.transparent,
            endDrawer: LocationDrawer(selected: verified),
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
                        Get.toNamed(Routes.condition);
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
                        Get.toNamed(Routes.condition);
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
                  '2',
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
