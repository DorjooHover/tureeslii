import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  }

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

  final double _headerHeight = 40.0;
  final double _maxHeight = 600.0;
  bool _isDragUp = true;
  double _bodyHeight = 0.0;
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Stack(
      children: [
        currentLocation != null
            ? GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: {
                  Marker(
                    markerId: MarkerId("currentLocation"),
                    position: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                  ),
                },
              )
            : Center(
                child: Text('loading...'),
              ),
        Positioned(
          bottom: 0.0,
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
                  double _draggedAmount = _size.height - data.globalPosition.dy;
                  if (this._isDragUp) {
                    if (_draggedAmount < 100.0)
                      this._bodyHeight = _draggedAmount;
                    if (_draggedAmount > 100.0)
                      this._bodyHeight = this._maxHeight;
                  } else {
                    /// the _draggedAmount cannot be higher than maxHeight b/c maxHeight is _dragged Amount + header Height
                    double _downDragged = this._maxHeight - _draggedAmount;
                    if (_downDragged < 100.0) this._bodyHeight = _draggedAmount;
                    if (_downDragged > 100.0) this._bodyHeight = 0.0;
                  }
                  this.setState(() {});
                },
                onVerticalDragEnd: (DragEndDetails data) {
                  if (_isDragUp) {
                    this._isDragUp = false;
                  } else {
                    this._isDragUp = true;
                  }
                  this.setState(() {});
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      width: _size.width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0),
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 2.0,
                                blurRadius: 4.0),
                          ]),
                      height: _headerHeight,
                      child: Text("drag me"),
                    ),
                    Expanded(
                      child: Container(
                        width: _size.width,
                        color: Colors.greenAccent,
                        alignment: Alignment.center,
                        child: Text("it worked!"),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
