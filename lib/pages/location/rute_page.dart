import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:food_court_app/services/map_service.dart';
import 'package:food_court_app/widget/button.dart';
import 'package:food_court_app/widget/widget_tabbar.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../services/models/markers.dart';
import 'food_court/food_court_page.dart';

class RutePage extends StatefulWidget {
  final Markers markers;
  const RutePage({super.key, required this.markers});

  @override
  State<RutePage> createState() => _RutePageState();
}

class _RutePageState extends State<RutePage>
    with SingleTickerProviderStateMixin {
  final Completer<GoogleMapController> _completer =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-7.740697249517362, 110.35192056953613),
    tilt: 60,
    zoom: 14,
  );

  late final TabController _tabController;

  int currentIndex = 0;
  final List<Tab> tabs = [
    Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Center(
          child: Icon(
            Icons.motorcycle_rounded,
          ),
        ),
      ),
    ),
    Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Center(
          child: Icon(
            Icons.directions_walk_rounded,
          ),
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _getAddressPlace();
    _getLocationUser();
    _getPolyline();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final specAddressLocation = TextEditingController();

  _getAddressPlace() async {
    double lat = widget.markers.latlng.latitude;
    double lng = widget.markers.latlng.longitude;

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      Placemark place = placemarks[3];

      setState(() {
        specAddressLocation.text =
            '${place.name}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}';
      });
    } catch (e) {
      return Future.error(e);
    }
  }

  bool setLoading = false;

  void _getLocationUser() async {
    setState(() {
      setLoading = true;
    });

    Position position = await MapService().determinePosition();

    _marker.clear();

    final Uint8List markerIcon = await MapService()
        .getBytesFromAsset('assets/mapicons/navigation.png', 80);
    _marker.add(
      Marker(
        markerId: const MarkerId('currentLocation'),
        flat: false,
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.defaultMarker,
        //icon: BitmapDescriptor.fromBytes(markerIcon),
        infoWindow: const InfoWindow(
          title: 'My Current Location',
        ),
      ),
    );

    final Uint8List markerPlaceIcon = await MapService()
        .getBytesFromAsset('assets/mapicons/restaurants.png', 75);
    _marker.add(
      Marker(
        markerId: const MarkerId('placeLocation'),
        flat: false,
        position: widget.markers.latlng,
        icon: BitmapDescriptor.fromBytes(markerPlaceIcon),
        infoWindow: InfoWindow(
          title: widget.markers.label,
          snippet: '${widget.markers.rating} rating',
        ),
      ),
    );

    setState(() {
      setLoading = false;
    });
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline =
        Polyline(polylineId: id, color: Colors.red, points: polyLineCoordinate);
    polylines[id] = polyline;
    setState(() {});
  }

  List<LatLng> polyLineCoordinate = [];

  _getPolyline() async {
    Position position = await MapService().determinePosition();

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      apiKey,
      PointLatLng(position.latitude, position.longitude),
      PointLatLng(
          widget.markers.latlng.latitude, widget.markers.latlng.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polyLineCoordinate.add(
          LatLng(point.latitude, point.longitude),
        );
      }
    }
    _addPolyLine();
  }

  List<LatLng>? routeCoords;

  List<List<PatternItem>> patterns = <List<PatternItem>>[
    <PatternItem>[], //line
    <PatternItem>[PatternItem.dash(30.0), PatternItem.gap(20.0)], //dash
    <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)], //dot
    <PatternItem>[
      //dash-dot
      PatternItem.dash(30.0),
      PatternItem.gap(20.0),
      PatternItem.dot,
      PatternItem.gap(20.0)
    ],
  ];

  final Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};
  final Set<Marker> _marker = {};

  int polylineCount = markers.length;

  String apiKey = 'AIzaSyBQ0CWDFFQ9qOjVOjtRZnExng95RS0QkNQ';

  GoogleMapPolyline googleMapPolyline =
      GoogleMapPolyline(apiKey: 'AIzaSyBQ0CWDFFQ9qOjVOjtRZnExng95RS0QkNQ');

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height * 0.28;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white),
          ),
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => FoodCourtPage(markers: widget.markers),
              ),
            );
          },
        ),
        titleSpacing: 2,
        title: Card(
          margin: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Text(
              'Rute',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: _kGooglePlex,
                    myLocationEnabled: false,
                    compassEnabled: false,
                    trafficEnabled: true,
                    buildingsEnabled: false,
                    fortyFiveDegreeImageryEnabled: true,
                    rotateGesturesEnabled: false,
                    zoomGesturesEnabled: true,
                    indoorViewEnabled: true,
                    mapType: MapType.normal,
                    polylines: Set<Polyline>.of(polylines.values),
                    markers: Set<Marker>.of(_marker),
                    onMapCreated: (GoogleMapController gMController) {
                      _completer.complete(gMController);
                    },
                  ),
                  Positioned(
                    bottom: 35,
                    left: 15,
                    child: IconButton(
                      onPressed: _getLocationUser,
                      icon: Icon(
                        Icons.gps_fixed_rounded,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                      style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(10),
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                        padding: MaterialStatePropertyAll(
                          EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 0,
              child: ruteContain(sizeHeight, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget ruteContain(
    double sizeHeight,
    BuildContext context,
  ) {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            const Gap(20),
            Card(
              margin: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Container(
                padding: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white70,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(15),
                          Row(
                            children: [
                              const Gap(15),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.5),
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.25),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(15),
                              !setLoading
                                  ? Text(
                                      'Your Location',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                  : Container(
                                      height: 18,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade100,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                            ],
                          ),
                          const Gap(5),
                          const Divider(
                            thickness: 1,
                            indent: 0,
                            endIndent: 5,
                            color: Colors.grey,
                          ),
                          const Gap(5),
                          Row(
                            children: [
                              const Gap(15),
                              const Icon(
                                CupertinoIcons.placemark_fill,
                                color: Colors.red,
                              ),
                              const Gap(15),
                              Expanded(
                                child: !setLoading
                                    ? Text(
                                        specAddressLocation.text,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      )
                                    : Container(
                                        height: 18,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                          const Gap(15),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.arrow_up_arrow_down,
                        color: Colors.white,
                        size: 20,
                      ),
                      style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll(10),
                        padding:
                            const MaterialStatePropertyAll(EdgeInsets.all(5)),
                        backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                tabWithoutDivider(
                  context,
                  _tabController,
                  tabs,
                  (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
                buttonWithIcon(
                  context,
                  'Start',
                  const Icon(
                    CupertinoIcons.location_circle_fill,
                    color: Colors.white,
                  ),
                  () {
                    _getLocationUser();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
