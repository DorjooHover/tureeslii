import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';

class FlatInfoView extends StatefulWidget {
  const FlatInfoView({super.key});

  @override
  State<FlatInfoView> createState() => _FlatInfoViewState();
}

class _FlatInfoViewState extends State<FlatInfoView> {
  final GlobalKey<ScaffoldState> flatInfoView = GlobalKey<ScaffoldState>();
  bool isDrawer = false;

  List<int> verified = [0, 1, 2, 3];

  String selectedHeating = heatingValues[0];
  String selectedWaterSupply = waterSupplyValues[0];
  String selectedToilet = toiletValues[0];

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
                        AdditionCard(
                            title: heating,
                            child: DropDown(
                              list: heatingValues,
                              value: selectedHeating,
                              onChanged: (value) {},
                            )),
                        space24,
                        AdditionCard(
                            title: waterSupple,
                            child: DropDown(
                              list: waterSupplyValues,
                              value: selectedWaterSupply,
                              onChanged: (value) {},
                            )),
                        space24,
                        AdditionCard(
                            title: toilet,
                            child: DropDown(
                              list: toiletValues,
                              value: selectedToilet,
                              onChanged: (value) {},
                            )),
                        space24,
                        AdditionCard(
                            title: area,
                            child: Input(
                              textInputType: TextInputType.number,
                            )),
                      ],
                    )),
                    space40,
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
                        Get.toNamed(Routes.flatFeature);
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
                        Get.toNamed(Routes.roomInfo);
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
                child: Text(
                  '5',
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
