import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:landlord/routes.dart';
import 'package:landlord/shared/index.dart';
import 'package:location/location.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
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

  final GlobalKey<ScaffoldState> locationKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void moveCurrentLocation() async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(currentLocation!.latitude!, currentLocation!.longitude!), 14));
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

  List<int> verified = [0];
  bool isDrawer = false;
  LatLng? selectedLocation;
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Material(
      child: Stack(
        children: [
          Scaffold(
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
                onPressed: () {},
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
                        child: Text('loading...'),
                      ),
                Positioned(
                    left: origin,
                    top: 15,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 14),
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
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300),
                      ),
                    )),
                Positioned(
                  bottom: MediaQuery.of(context).padding.bottom,
                  child: AnimatedContainer(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.6,
                      ),
                      curve: Curves.easeOut,
                      height: !isDrag ? _headerHeight : _size.height * 0.6,
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
                              height: _size.height * 0.6,
                              child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
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
                                      onVerticalDragEnd: (DragEndDetails data) {
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
                                                child: DropDown(
                                                  list: cities,
                                                  onChanged: (value) {},
                                                  value: cities[0],
                                                ))),
                                        space16,
                                        Expanded(
                                            child: AdditionCard(
                                                title: district,
                                                child: Input())),
                                      ],
                                    ),
                                    space24,
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: AdditionCard(
                                                title: committee,
                                                child: Input(
                                                  textInputType:
                                                      TextInputType.number,
                                                ))),
                                        space16,
                                        Expanded(
                                            child: AdditionCard(
                                                title: floor,
                                                child: Input(
                                                  textInputType:
                                                      TextInputType.number,
                                                ))),
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
                                              maxLine: 5,
                                              textInputType:
                                                  TextInputType.number,
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
                    bottom: MediaQuery.of(context).padding.bottom,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: bgGray,
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(top: 18, right: 16, bottom: 32),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.general);
                        },
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
            endDrawer: LocationDrawer(selected: verified),
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
                print(details.delta.dx);
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
                        image: AssetImage(imageTriangle), fit: BoxFit.contain)),
                height: 130,
                width: 48,
                padding: const EdgeInsets.only(left: 26),
                alignment: Alignment.center,
                child: Text(
                  '1',
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
