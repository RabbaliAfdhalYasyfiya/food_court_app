import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_court_app/services/map_service.dart';
import 'package:food_court_app/services/models/markers.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widget/button.dart';
import '../../widget/tile.dart';
import '../menu_page.dart';
import 'list_food_court/list_food_court_page.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final Completer<GoogleMapController> _completer =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-7.740697249517362, 110.35192056953613),
    tilt: 60,
    zoom: 14,
  );

  String apiKey = 'AIzaSyBQ0CWDFFQ9qOjVOjtRZnExng95RS0QkNQ';
  String tokenKey = '';
  String placeImg = '';

  var radiusValue = 2500.0;

  final Set<Marker> _marker = <Marker>{};
  Set<Marker> markersDupe = <Marker>{};
  final Set<Circle> _circle = <Circle>{};

  int markerIdCounter = 1;

  List<dynamic> allFavoritePlaces = [];

  final addressLocation = TextEditingController();
  final specAddressLocation = TextEditingController();

  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  void _getLocationUser() async {
    setState(() {
      setLoading = true;
      radiusSlider = false;
    });

    
    //getNearbyPlace();
    Position position = await MapService().determinePosition();

    

    GoogleMapController controller = await _completer.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14,
          tilt: 85,
        ),
      ),
    );

    _marker.clear();
    _marker.add(
      Marker(
        markerId: const MarkerId('currentLocation'),
        visible: true,
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(position.latitude, position.longitude),
        infoWindow: const InfoWindow(
          title: 'My Current Location',
        ),
      ),
    );

    latitudeController.text = position.latitude.toString();
    longitudeController.text = position.longitude.toString();

    // place mark
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[3];

      setState(() {
        addressLocation.text = '${place.name}';
        specAddressLocation.text =
            '${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea} ${place.postalCode}';
      });
    } catch (e) {
      return Future.error(e);
    }

    // nerby place
    _circle.clear();
    _circle.add(
      Circle(
        circleId: const CircleId('raj'),
        center: LatLng(position.latitude, position.longitude),
        fillColor: Theme.of(context).primaryColor.withOpacity(0.05),
        radius: radiusValue,
        strokeColor: Theme.of(context).primaryColor.withOpacity(0.25),
        strokeWidth: 1,
      ),
    );

    for (int i = 0; i < markers.length; i++) {
      final Uint8List markerIcon = await MapService()
          .getBytesFromAsset(markers.elementAt(i).imgIcon, 60);
      _marker.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: markers.elementAt(i).latlng,
          infoWindow: InfoWindow(
            title: markers.elementAt(i).label,
            snippet: '${markers.elementAt(i).rating} rating',
          ),
          icon: BitmapDescriptor.fromBytes(markerIcon),
        ),
      );
    }

    //setState(() {});

    setState(() {
      setLoading = false;
      radiusSlider = true;
    });
  }

  Uint8List? markerIcon;

  void getNearPlace() async {
    setState(() {
      pressNear = true;
    });

    Position position = await MapService().determinePosition();

    var placeResult = await _getPlaceDetails(
        LatLng(position.latitude, position.longitude), radiusValue.toInt());

    List<dynamic> placeWithin = placeResult['results'] as List;

    tokenKey = placeResult['next_page_token'] ?? 'none';

    for (var element in placeWithin) {
      _setNearMarker(
        LatLng(element['geometry']['location']['lat'],
            element['geometry']['location']['lng']),
        element['name'],
        element['types'],
        element['business_status'] ?? 'not available',
      );
    }

    markersDupe = _marker;

    setState(() {});

    setState(() {
      pressNear = false;
    });
  }

  _getPlaceDetails(LatLng coords, int radius) async {
    var lat = coords.latitude;
    var lng = coords.longitude;

    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?&location=$lat,$lng&radius=$radius&key=$apiKey';

    var response = await http.get(
      Uri.parse(url),
    );

    var json = convert.jsonDecode(response.body);

    return json;
  }

  _setNearMarker(LatLng point, String label, List types, String status) async {
    var counter = markerIdCounter++;

    final Uint8List markerIcon;

    if (types.contains('food')) {
      markerIcon = await MapService()
          .getBytesFromAsset('assets/mapicons/restaurants.png', 75);
    } else if (types.contains('food court')) {
      markerIcon = await MapService()
          .getBytesFromAsset('assets/mapicons/restaurants.png', 75);
    } else {
      markerIcon = await MapService()
          .getBytesFromAsset('assets/mapicons/restaurants.png', 75);
    }

    final Marker marker = Marker(
      markerId: MarkerId('marker_$counter'),
      position: point,
      onTap: () {},
      icon: BitmapDescriptor.fromBytes(markerIcon),
    );

    setState(() {
      
    });

    setState(() {
      _marker.add(marker);
    });
  }

  bool pressNear = false;
  bool radiusSlider = false;
  bool cardTapped = false;
  bool setLoading = false;

  @override
  void initState() {
    super.initState();
    _marker;
    MapService().determinePosition();
    _getLocationUser();
    getNearPlace();
  }

  loadData() {
    for (int i = 0; i < markers.length; i++) {
      _marker.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: markers.elementAt(i).latlng,
          infoWindow: InfoWindow(
            title: markers.elementAt(i).label,
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      //setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height * 0.35;
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
                builder: (context) => const MenuPage(),
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
              'Location',
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
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: _kGooglePlex,
                    myLocationEnabled: false,
                    compassEnabled: false,
                    trafficEnabled: true,
                    buildingsEnabled: false,
                    circles: _circle,
                    fortyFiveDegreeImageryEnabled: true,
                    rotateGesturesEnabled: false,
                    zoomGesturesEnabled: true,
                    indoorViewEnabled: true,
                    mapType: MapType.terrain,
                    markers: Set<Marker>.of(_marker),
                    onMapCreated: (GoogleMapController gMController) {
                      _completer.complete(gMController);
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 35, left: 10),
                      child: radiusSlider
                          ? Card(
                              margin: const EdgeInsets.all(0),
                              child: Container(
                                height: 200,
                                width: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Slider(
                                    max: 5000.0,
                                    min: 500.0,
                                    autofocus: true,
                                    overlayColor: MaterialStatePropertyAll(
                                        Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.25)),
                                    inactiveColor: Colors.grey.shade300,
                                    activeColor: Theme.of(context).primaryColor,
                                    value: radiusValue,
                                    onChanged: (newValue) {
                                      radiusValue = newValue;
                                      _getLocationUser();
                                      getNearPlace();
                                      setLoading = false;
                                      radiusSlider = true;
                                      pressNear = true;
                                    },
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 0,
              child: currentLocation(sizeHeight, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget currentLocation(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.25),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            const Gap(10),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                onPressed: _getLocationUser,
                style: ButtonStyle(
                  padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 20)),
                  elevation: const MaterialStatePropertyAll(0),
                  overlayColor: MaterialStatePropertyAll(
                    Theme.of(context).primaryColor.withOpacity(0.25),
                  ),
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.grey.shade200),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
                icon: const Icon(
                  CupertinoIcons.placemark_fill,
                  size: 19,
                  color: Colors.redAccent,
                ),
                label: Text(
                  'See Current Location',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            const Gap(5),
            Card(
              margin: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: tileAddressLocation(
                setLoading,
                context,
                'https://i.pinimg.com/564x/a3/e2/d4/a3e2d4d8ff898100546f73e57b18d866.jpg',
                addressLocation.text,
                specAddressLocation.text,
                '${latitudeController.text}, ${longitudeController.text}',
              ),
            ),
            const Gap(10),
            Align(
              alignment: Alignment.bottomRight,
              child: buttonWithIcon(
                context,
                'Food Court',
                const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                ),
                () {
                  debugPrint('Enter Food Court');

                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const ListFoodCourtPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
