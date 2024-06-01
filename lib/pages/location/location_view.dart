import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:landlord/controllers/main_controller.dart';
import 'package:landlord/shared/index.dart';
import 'package:location/location.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView>
    with AutomaticKeepAliveClientMixin {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LocationData? currentLocation;

  final double _headerHeight = 292.0;

  double sortBodyHeight = 0.0;
  bool isDrag = false;
  double bodyHeight = 0.0;
  int selected = -1;
  List<int> list = [0, 1, 2, 3, 4, 5];
  final random = Random();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
    });
    moveCurrentLocation();
    addCustomIcon();
  }

  GlobalKey<ScaffoldState> locationKey = GlobalKey<ScaffoldState>();
  bool isDrawer = false;
  LatLng? selectedLocation;
  int? cityValue;
  TextEditingController stateController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController flatNumberController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController doorNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final controller = Get.put(MainController());
  @override
  void initState() {
    super.initState();
    controller.currentStep.value = 0;
    if (controller.createPost.value?.id != null) {
      setState(() {
        selectedLocation = LatLng(
            double.parse(controller.createPost.value!.lat!),
            double.parse(controller.createPost.value!.long!));
        currentLocation = LocationData.fromMap({
          "latitude": double.parse(controller.createPost.value!.lat!),
          "longitude": double.parse(controller.createPost.value!.long!)
        });
      });
    }
    int cityIndex = controller.cities
        .indexWhere((p0) => p0.name == controller.createPost.value!.city);
    setState(() {
      cityValue = cityIndex == -1 ? 0 : cityIndex;
      controller.createPost.value!.state != null
          ? stateController.text = controller.createPost.value!.state!
          : stateController.clear();
      controller.createPost.value!.district != null
          ? districtController.text = controller.createPost.value!.district!
          : districtController.clear();
      controller.createPost.value!.apartmentNo != null
          ? flatNumberController.text =
              controller.createPost.value!.apartmentNo!
          : flatNumberController.clear();
      controller.createPost.value!.floor != null
          ? floorController.text =
              controller.createPost.value!.floor!.toString()
          : floorController.clear();
      controller.createPost.value!.doorNo != null
          ? doorNumberController.text = controller.createPost.value!.doorNo!
          : doorNumberController.clear();
      controller.createPost.value!.address != null
          ? addressController.text = controller.createPost.value!.address!
          : addressController.clear();
    });

    if (currentLocation == null) {
      getCurrentLocation();
    }
    if (controller.cities.isNotEmpty) {
      if (controller.createPost.value?.id == null) {
        moveLocation(LatLng(controller.cities[0].location![0],
            controller.cities[0].location![1]));
      } else {
        moveLocation(LatLng(double.parse(controller.createPost.value!.lat!),
            double.parse(controller.createPost.value!.long!)));
      }
    } else {
      controller.getCities().then((value) => {
            if (controller.createPost.value?.id == null)
              {
                moveLocation(LatLng(controller.cities[0].location![0],
                    controller.cities[0].location![1])),
              }
            else
              {
                moveLocation(LatLng(
                    double.parse(controller.createPost.value!.lat!),
                    double.parse(controller.createPost.value!.long!)))
              }
          });
    }
  }

  void moveCurrentLocation() {
    if (currentLocation != null) {
      moveLocation(
          LatLng(currentLocation!.latitude!, currentLocation!.longitude!));
    }
  }

  void moveLocation(LatLng location) async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(CameraUpdate.newLatLngZoom(location, 14));
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(), imageDot).then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  nextStep(bool edit) async {
    bool success = true;
    String message = '';
    if (selectedLocation == null) {
      success = false;
      message = locationErrorStr;
    }
    if (addressController.text != '' &&
        cityValue != null &&
        stateController.text != '' &&
        districtController.text != '' &&
        floorController.text != "" &&
        flatNumberController.text != '' &&
        doorNumberController.text != '' &&
        selectedLocation != null) {
      controller.createPost.value!.address = addressController.text;
      controller.createPost.value!.city = controller.cities[cityValue!].name;
      controller.createPost.value!.state = stateController.text;
      controller.createPost.value!.district = districtController.text;
      controller.createPost.value!.floor =
          int.tryParse(floorController.text) ?? 1;
      controller.createPost.value!.apartmentNo = flatNumberController.text;
      controller.createPost.value!.doorNo = doorNumberController.text;
      controller.createPost.value!.long =
          selectedLocation!.longitude.toString();
      controller.createPost.value!.lat = selectedLocation!.latitude.toString();
    } else {
      success = false;
      message = Messages.incomplete;
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
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Size _size = MediaQuery.of(context).size;

    return SafeArea(
      child: Material(
        child: Stack(
          children: [
            Scaffold(
              // resizeToAvoidBottomInset: false,
              key: locationKey,
              appBar: MainAppBar(
                back: true,
                logo: false,
                center: Text(
                  location,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
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
                  currentLocation != null
                      ? GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: _kGooglePlex,
                          onMapCreated: (GoogleMapController controller) async {
                            _controller.complete(controller);
                          },
                          onTap: (argument) {
                            setState(() {
                              selectedLocation = argument;
                            });
                          },
                          markers: {
                            if (selectedLocation != null)
                              Marker(
                                markerId: MarkerId("selectedLocation    "),
                                position: selectedLocation!,
                              ),
                          },
                        )
                      : const Center(
                          child: Text('Түр хүлээнэ үү...'),
                        ),
                  Positioned(
                      left: origin,
                      top: 15,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 14),
                        width: 187,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 15,
                                offset: const Offset(0, 4)),
                          ],
                        ),
                        child: Text(
                          markInMap,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: black,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300),
                        ),
                      )),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: AnimatedContainer(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.55,
                        ),
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).padding.bottom),
                        curve: Curves.easeOut,
                        height: !isDrag ? _headerHeight : _size.height * 0.55,
                        duration: const Duration(milliseconds: 600),
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: origin),
                                width: _size.width,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                    topLeft: Radius.circular(20.0),
                                  ),
                                ),
                                height: _size.height * 0.55,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isDrag = !isDrag;
                                          });
                                        },
                                        onVerticalDragUpdate:
                                            (DragUpdateDetails data) {
                                          if (data.localPosition.dy > 0) {
                                            setState(() {
                                              isDrag = true;
                                            });
                                          } else {
                                            setState(() {
                                              isDrag = false;
                                            });
                                          }
                                        },
                                        onVerticalDragEnd:
                                            (DragEndDetails data) {
                                          setState(() {
                                            isDrag = !isDrag;
                                          });
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 40,
                                          color: Colors.white,
                                          alignment: Alignment.center,
                                          child: Container(
                                            width: 50,
                                            height: 4,
                                            decoration: BoxDecoration(
                                                color: prime,
                                                borderRadius:
                                                    BorderRadius.circular(2.5)),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: AdditionCard(
                                            title: city,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 13,
                                                      vertical: 13),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border:
                                                      Border.all(color: gray),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: DropdownButton(
                                                isDense: true,
                                                icon: SvgPicture.asset(
                                                    iconArrowDown),
                                                iconEnabledColor: gray,
                                                isExpanded: true,
                                                dropdownColor: Colors.white,
                                                value: cityValue,
                                                hint: Text(choose,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color: labelGray)),
                                                underline: const SizedBox(),
                                                items:
                                                    controller.cities.map((e) {
                                                  int i = controller.cities
                                                      .indexOf(e);
                                                  return DropdownMenuItem(
                                                    value: i,
                                                    child: Text(
                                                      e.name!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              color: black),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      cityValue = value;
                                                      isDrag = true;
                                                    });
                                                    moveLocation(LatLng(
                                                        controller.cities[value]
                                                            .location![0],
                                                        controller.cities[value]
                                                            .location![1]));
                                                  }
                                                },
                                              ),
                                            ),
                                          )),
                                          space16,
                                          Expanded(
                                              child: AdditionCard(
                                                  title: district,
                                                  child: Input(
                                                    controller:
                                                        districtController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onChange: (p0) {
                                                      setState(() {
                                                        districtController
                                                            .text = p0;
                                                        isDrag = true;
                                                      });
                                                    },
                                                  ))),
                                        ],
                                      ),
                                      space24,
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: AdditionCard(
                                                  title: committee,
                                                  child: Input(
                                                      controller:
                                                          stateController,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      textInputType:
                                                          TextInputType.number,
                                                      inputFormatter:
                                                          onlyUnsignedNumbers(),
                                                      onChange: (p0) {
                                                        setState(() {
                                                          stateController.text =
                                                              p0;
                                                          isDrag = true;
                                                        });
                                                      }))),
                                          space16,
                                          Expanded(
                                              child: AdditionCard(
                                                  title: floor,
                                                  child: Input(
                                                      controller:
                                                          floorController,
                                                      textInputType:
                                                          TextInputType.number,
                                                      inputFormatter:
                                                          onlyUnsignedNumbers(),
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      onChange: (p0) {
                                                        if (p0.isNotEmpty) {
                                                          setState(() {
                                                            isDrag = true;
                                                            floorController
                                                                .text = p0;
                                                          });
                                                        }
                                                      }))),
                                        ],
                                      ),
                                      space24,
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: AdditionCard(
                                                  title: flatNumber,
                                                  child: Input(
                                                      controller:
                                                          flatNumberController,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      onChange: (p0) {
                                                        setState(() {
                                                          flatNumberController
                                                              .text = p0;
                                                          isDrag = true;
                                                        });
                                                      }))),
                                          space16,
                                          Expanded(
                                              child: AdditionCard(
                                                  title: doorNumber,
                                                  child: Input(
                                                      controller:
                                                          doorNumberController,
                                                      textInputType:
                                                          TextInputType.number,
                                                      inputFormatter:
                                                          onlyUnsignedNumbers(),
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      onChange: (p0) {
                                                        setState(() {
                                                          isDrag = true;
                                                          doorNumberController
                                                              .text = p0;
                                                        });
                                                      }))),
                                        ],
                                      ),
                                      space24,
                                      Flexible(
                                        child: Container(
                                          color: Colors.white,
                                          padding:
                                              const EdgeInsets.only(bottom: 13),
                                          width: _size.width,
                                          child: AdditionCard(
                                              title: address,
                                              child: Input(
                                                controller: addressController,
                                                maxLine: 5,
                                                onChange: (p0) {
                                                  setState(() {
                                                    isDrag = true;
                                                    addressController.text = p0;
                                                  });
                                                },
                                                onSubmitted: (p0) {
                                                  nextStep(false);
                                                },
                                              )),
                                        ),
                                      ),
                                      !isDrag
                                          ? const SizedBox(
                                              height: 78,
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          nextStep(false);
                        },
                        child: Container(
                          color: bgGray,
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                            top: 10,
                            right: 16,
                            bottom: MediaQuery.of(context).padding.bottom + 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
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
                      ))
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
              onDrawerChanged: (isOpened) {
                if (isOpened != isDrawer) {
                  setState(() {
                    isDrawer = isOpened;
                  });
                }
              },
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              right: !isDrawer
                  ? 0
                  : MediaQuery.of(context).size.width > 640
                      ? 640 * 0.75
                      : MediaQuery.of(context).size.width * 0.75,
              curve: Curves.ease,
              bottom: MediaQuery.of(context).size.height * 0.25,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 1) {
                    locationKey.currentState!.openEndDrawer();
                    setState(() {
                      isDrawer = true;
                    });
                  } else {
                    locationKey.currentState!.closeEndDrawer();
                    setState(() {
                      isDrawer = false;
                    });
                  }
                },
                onTap: () {
                  if (isDrawer) {
                    locationKey.currentState!.closeEndDrawer();
                    setState(() {
                      isDrawer = false;
                    });
                  } else {
                    locationKey.currentState!.openEndDrawer();
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
      ),
    );
  }
}
