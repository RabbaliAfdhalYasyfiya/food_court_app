import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_court_app/widget/widget_tabbar.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';

import '../../../services/models/markers.dart';
import '../../../widget/tile.dart';
import '../rute_page.dart';
import '../tenant_court/tenant_court_page.dart';
import '../list_food_court/list_food_court_page.dart';

class FoodCourtPage extends StatefulWidget {
  final Markers markers;
  const FoodCourtPage({super.key, required this.markers});

  @override
  State<FoodCourtPage> createState() => _FoodCourtPageState();
}

class _FoodCourtPageState extends State<FoodCourtPage> {
  int currentIndex = 0;
  final List<Tab> tabs = const [
    Tab(text: 'Tenant'),
    Tab(text: 'Ulasan'),
  ];

  @override
  void initState() {
    super.initState();
    _getAddressPlace();
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
            '${place.name}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea} ${place.postalCode}';
      });
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.width * 1.65;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
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
                  builder: (context) => const ListFoodCourtPage(),
                ),
              );
            },
          ),
          actionsIconTheme: const IconThemeData(color: Colors.white),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => RutePage(markers: widget.markers),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Theme.of(context).primaryColor),
                  padding: const MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 15),
                  ),
                ),
                icon: const Row(
                  children: [
                    Text(
                      'Rute',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      CupertinoIcons.arrow_turn_up_right,
                    ),
                  ],
                ),
                visualDensity: VisualDensity.standard,
              ),
            )
          ],
        ),
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              Image.network(
                widget.markers.imgPlace,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: sizeHeight,
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              widget.markers.label,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                height: 1.05,
                              ),
                            ),
                          ),
                          Container(
                            width: 75,
                            constraints: const BoxConstraints(
                              maxWidth: 75,
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '4.5',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Gap(5),
                                Icon(
                                  CupertinoIcons.star_fill,
                                  color: Colors.amber,
                                  size: 17,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Gap(10),
                      Text(
                        specAddressLocation.text,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.25,
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: tabWithDivider(
                          context,
                          tabs,
                          (index) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TabBarView(
                          children: [
                            pageTenant(),
                            pageUlasan(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pageUlasan() {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(vertical: 15),
      itemCount: 7,
      itemBuilder: (context, index) {
        return tileUlasan(
          'Nama Pengguna',
          'Banyak pilihan. Jadi, satu meja bisa pesan di dua atau lebih tempat. Luas, tersedia banyak kursi. Layout menarik. Good pokoknya.',
        );
      },
    );
  }

  Widget pageTenant() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 7,
        mainAxisSpacing: 7,
      ),
      itemCount: 10,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(vertical: 15),
      itemBuilder: (context, index) {
        return tileTenantFoodCourt(
          '',
          'https://i.pinimg.com/564x/13/ca/b3/13cab340d2733ba8d281957e06340881.jpg',
          () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => TenantCourtPage(
                  markers: widget.markers,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
