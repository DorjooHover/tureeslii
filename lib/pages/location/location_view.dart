import 'dart:async';
import 'dart:math';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:location/location.dart';
import 'package:tureeslii/controllers/main_controller.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/pages/location/filter_view.dart';
import 'package:tureeslii/pages/location/item_detail_view.dart';
import 'package:tureeslii/pages/no_data.dart';
import 'package:tureeslii/shared/index.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  final mainController = Get.put(MainController());
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LocationData? currentLocation;
  LatLng? startLocation;
  final Set<Marker> markers = {};
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  final double _headerHeight = 100.0;
  final double _maxHeight = 600.0;
  final double sortMaxHeight = 320.0;
  final double sortHeaderHeight = 320.0;
  double sortBodyHeight = 0.0;
  bool _isDragUp = true;
  double _bodyHeight = 0.0;
  int selected = -1;
  final random = Random();
  bool isSort = false;

  bool isLoading = false;

  int page = 0;
  int limit = 10;
  SortData sortData = SortData();
  List<FilterData> filterData = <FilterData>[];
  List<dynamic>? price;
  Future<void> getPosts() async {
    setState(() {
      isLoading = true;
    });
    try {
      await mainController.getAllPosts(
        page,
        limit,
        sortData,
        filterData,
      );
      List<dynamic> res = await mainController.getPostPriceRange(FilterData());
      price = res;
      setState(() {});
      addMarkers();
      setState(() {
        isLoading = false;
      });
    } on DioException {
      setState(() {
        isLoading = false;
      });
    }
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  void getCurrentLocation() async {
    // Location location = Location();

    // loc = await location.getLocation();

    moveCurrentLocation();
    addCustomIcon();
  }

  void addMarkers() {
    locations = [];
    markers.clear();
    for (Post post in mainController.allPosts) {
      double lat = double.parse(post.lat!);
      double lng = double.parse(post.long!);
      locations.add(LatLng(lat, lng));
      markers
          .addLabelMarker(LabelMarker(
        label: '${currencyFormat(post.price!, true)}₮',
        backgroundColor: post.id! == selected ? orange : Colors.white,
        textStyle: TextStyle(
            fontSize: 27,
            color: post.id! != selected ? orange : Colors.white,
            height: 1.5,
            fontWeight: FontWeight.w400),
        markerId: MarkerId('${post.id!}'),
        position: LatLng(lat, lng),
        onTap: () {
          setState(() {
            selected = post.id!;
          });
        },
      ))
          .then((value) {
        setState(() {});
      });

      // _customInfoWindowController.addInfoWindow!(
      //     Container(
      //         width: 100,
      //         height: 100,
      //         color: red,
      //         child: Text(currencyFormat(e * 400000, true))),
      //     LatLng(lat, lng));
    }

    if (mainController.allPosts.isNotEmpty) {
      setState(() {
        startLocation = LatLng(
            double.parse(mainController.allPosts[0].lat ?? "47.9188141,"),
            double.parse(mainController.allPosts.first.long ?? '106.917484'));
      });
    }
  }

  List<LatLng> locations = [];
  bool isData = true;
  @override
  void initState() {
    super.initState();

    // if (mainController.allPosts.isEmpty) {
    filterData = [
      FilterData(field: 'city', op: "=", qry: mainController.city.value),
      FilterData(
          field: mainController.timeType.value == byMonth
              ? "monthlyRent"
              : 'dailyRent',
          op: "=",
          qry: "true"),
    ];
    getPosts().then((value) {
      getCurrentLocation();
    });
    // }
    if (mainController.allPosts.isEmpty && !isLoading) {
      setState(() {
        isData = false;
      });
    }
  }

  void moveCurrentLocation() async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(startLocation!, 14));
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

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SizedBox(
      height: _size.height,
      width: double.infinity,
      child: Stack(
        children: [
          startLocation != null && !isLoading
              ? GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) async {
                    _controller.complete(controller);
                    _customInfoWindowController.googleMapController =
                        controller;
                  },
                  markers: {
                    // Marker(
                    //   markerId: MarkerId("currentLocation"),
                    //   position: LatLng(currentLocation!.latitude!,
                    //       currentLocation!.longitude!),
                    // ),
                    ...markers
                  },
                )
              : isData
                  ? const CustomLoader()
                  : Center(
                      child: Text(
                          _bodyHeight < 10 && _isDragUp ? 'Зар олдсонгүй' : ""),
                    ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 75,
            width: 150,
            offset: 50,
          ),
          Positioned(
            left: origin,
            right: origin,
            bottom: (selected != -1 && !_isDragUp
                    ? _maxHeight - 160
                    : _headerHeight) +
                26,
            child: selected != -1
                ? AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOut,
                    height: selected != -1 ? 160 : 0,
                    child: Obx(
                      () => LocationCard(
                        data: mainController.allPosts
                            .firstWhere((Post post) => post.id == selected),
                        onTap: () {
                          Get.to(() => ItemDetailView(
                                data: mainController.allPosts
                                    .firstWhere((post) => post.id == selected),
                              ));
                        },
                      ),
                    ))
                : const SizedBox(),
          ),
          Positioned(
            bottom: 0.0,
            left: origin,
            right: origin,
            child: AnimatedContainer(
                constraints: BoxConstraints(
                  maxHeight: _maxHeight,
                  minHeight: _headerHeight,
                ),
                curve: Curves.easeOut,
                height: _bodyHeight,
                duration: const Duration(milliseconds: 600),
                child: GestureDetector(
                  onVerticalDragUpdate: (DragUpdateDetails data) {
                    double _draggedAmount =
                        _size.height - data.globalPosition.dy;

                    if (_isDragUp) {
                      if (_draggedAmount < 10.0)
                        setState(() {
                          _bodyHeight = _draggedAmount;
                        });
                      if (_draggedAmount > 10.0)
                        setState(() {
                          _bodyHeight = _maxHeight - (selected != -1 ? 160 : 0);
                        });
                    } else {
                      /// the _draggedAmount cannot be higher than maxHeight b/c maxHeight is _dragged Amount + header Height
                      double _downDragged = _maxHeight - _draggedAmount;
                      if (_downDragged < 5.0) {
                        setState(() {
                          _bodyHeight =
                              _draggedAmount - (selected != -1 ? 160 : 0);
                        });
                      }
                      ;
                      if (_downDragged > 5.0) {
                        setState(() {
                          _bodyHeight = 0.0;
                        });
                      }
                      ;
                    }
                  },
                  onVerticalDragEnd: (DragEndDetails data) {
                    setState(() {
                      _isDragUp = !_isDragUp;
                    });
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: _size.width,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0),
                          ),
                        ),
                        height: _headerHeight,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            space13,
                            Container(
                              width: 50,
                              height: 4,
                              decoration: BoxDecoration(
                                  color: prime,
                                  borderRadius: BorderRadius.circular(2.5)),
                            ),
                            space24,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                MainIconButton(
                                  onPressed: () async {
                                    Get.to(
                                        FilterView(
                                          func: (List<FilterData> data) {
                                            setState(() {
                                              filterData = data;
                                            });
                                            addMarkers();
                                          },
                                          price: price ?? [],
                                        ),
                                        transition: Transition.cupertino,
                                        duration:
                                            const Duration(milliseconds: 300));
                                  },
                                  back: true,
                                  text: search,
                                  color: prime,
                                  child: SvgPicture.asset(iconSearch),
                                ),
                                MainIconButton(
                                  onPressed: () {
                                    setState(() {
                                      isSort = !isSort;
                                    });
                                  },
                                  back: true,
                                  text: sort,
                                  child: SvgPicture.asset(iconSort),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: Obx(
                        () => mainController.allPosts.isNotEmpty
                            ? SingleChildScrollView(
                                child: Container(
                                  width: _size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: origin, vertical: 12),
                                  color: Colors.white,
                                  child: Column(
                                    children: <Widget>[
                                      ...mainController.allPosts
                                          .map((Post post) {
                                        return Obx(
                                          () => BookmarkCard(
                                            onPress: () {
                                              Get.to(() => ItemDetailView(
                                                    data: post,
                                                  ));
                                            },
                                            active: mainController.savedPosts
                                                .where((p0) => p0.id == post.id)
                                                .isNotEmpty,
                                            data: post,
                                            onBookmark: () async {
                                              await mainController.togglePost(
                                                  id: post.id!, post: post);
                                            },
                                          ),
                                        );
                                      }).toList()
                                    ],
                                  ),
                                ),
                              )
                            : Center(
                                child: _bodyHeight > 10
                                    ? NoDataView()
                                    : Container(),
                              ),
                      )),
                    ],
                  ),
                )),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: AnimatedContainer(
              height: isSort ? sortMaxHeight : 0.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              child: dragBottomSheet(),
            ),
          ),
        ],
      ),
    );
  }

  Widget dragBottomSheet() {
    final Size _size = MediaQuery.of(context).size;
    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails data) {
        double draggedAmount = _size.height - data.globalPosition.dy;

        if (draggedAmount > 10.0) {
          setState(() {
            isSort = !isSort;
          });
        }
      },
      onVerticalDragEnd: (DragEndDetails data) {
        setState(() {
          isSort = !isSort;
        });
      },
      child: Container(
        width: _size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              space13,
              Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                    color: Color(0xffC9C9C9),
                    borderRadius: BorderRadius.circular(2.5)),
              ),
              space24,
              ...sortValues
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        mainController.getAllPosts(page, limit, e, filterData);
                        setState(() {
                          sortData = e;
                          isSort = !isSort;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 40),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Color(0xffEFEFEF)))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(e.name!,
                                style: Theme.of(context).textTheme.bodyMedium!),
                            SvgPicture.asset(e.icon!),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
              space64
            ],
          ),
        ),
      ),
    );
  }
}
