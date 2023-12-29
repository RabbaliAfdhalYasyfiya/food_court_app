import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';

import '../pages/location/rute_page.dart';
import '../services/models/markers.dart';

class TileFoodCourt extends StatefulWidget {
  final Markers markers;
  const TileFoodCourt({super.key, required this.markers});

  @override
  State<TileFoodCourt> createState() => _TileFoodCourtState();
}

class _TileFoodCourtState extends State<TileFoodCourt> {
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
            '${place.name}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}';
      });
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        if (widget.markers.openClose) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => RutePage(markers: widget.markers),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              showCloseIcon: true,
              backgroundColor: Colors.redAccent,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              behavior: SnackBarBehavior.floating,
              content: Text('${widget.markers.label} is Close'),
            ),
          );
        }
      },
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: double.infinity,
            height: 125,
            color: Colors.grey.shade600,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: double.infinity,
                    child: Image.network(
                      widget.markers.imgPlace,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.low,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.markers.label,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        height: 1,
                                      ),
                                    ),
                                    const Gap(5),
                                    Text(
                                      specAddressLocation.text,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        height: 1,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.5, horizontal: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              widget.markers.rating,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const Gap(2),
                                            const Icon(
                                              CupertinoIcons.star_fill,
                                              color: Colors.amber,
                                              size: 13,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        widget.markers.openClose
                                            ? ' · Open'
                                            : ' · Close',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: widget.markers.openClose
                                              ? Colors.greenAccent.shade400
                                              : Colors.redAccent.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2.5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.blueAccent.shade400,
                                    ),
                                    child: const Text(
                                      '1.5 km',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Gap(5),
                        const VerticalDivider(
                          thickness: 1,
                        ),
                        const Gap(5),
                        Expanded(
                          flex: 0,
                          child: Icon(
                            CupertinoIcons.arrow_up_right_diamond_fill,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget tileTenantFoodCourt(
  final String nameFoodCourt,
  final String image,
  final Function() ontap,
) {
  return InkWell(
    borderRadius: BorderRadius.circular(15),
    onTap: ontap,
    child: Card(
      margin: const EdgeInsets.all(0),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: double.infinity,
          height: 125,
          color: Colors.grey.shade600,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(15)),
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.low,
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  flex: 0,
                  child: Text(
                    nameFoodCourt,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Gap(10),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget tileAddressLocation(
  final bool setLoad,
  final BuildContext context,
  final String image,
  final String addressLocation,
  final String specificAddressLocation,
  final String cordinate,
) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: ShapeDecoration(
      color: Colors.white70,
      shape: SmoothRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: SmoothBorderRadius(
          cornerRadius: 25,
          cornerSmoothing: 1.0,
        ),
      ),
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
            height: 100,
            width: 115,
            child: !setLoad
                ? Image.network(
                    image,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.low,
                  )
                : Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                  ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !setLoad
                  ? Text(
                      addressLocation,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          height: 20,
                          width: 125,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        const Gap(5),
                      ],
                    ),
              !setLoad
                  ? Text(
                      specificAddressLocation,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 15,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        const Gap(2.5),
                        Container(
                          height: 15,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
              const Divider(
                thickness: 0.3,
                color: Colors.grey,
              ),
              !setLoad
                  ? Text(
                      cordinate,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                        //decorationColor: Colors.blue.shade400,
                      ),
                    )
                  : Container(
                      height: 18,
                      width: 175,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget tileMenuFoodCourt(
  final BuildContext context,
  final String image,
  final String nameMenu,
  final String descMenu,
  final String asalMenu,
  final String price,
  final Function() ontap,
) {
  return InkWell(
    borderRadius: BorderRadius.circular(15),
    onTap: ontap,
    child: Card(
      margin: const EdgeInsets.all(0),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: double.infinity,
          height: 100,
          color: Colors.grey.shade600,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.low,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        nameMenu,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        descMenu,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rp · $asalMenu',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Text(
                            'Rp $price',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget tileUlasan(
  final String nameUser,
  final String komenUser,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              'https://i.pinimg.com/564x/2f/15/f2/2f15f2e8c688b3120d3d26467b06330c.jpg',
              height: 40,
              width: 40,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.low,
            ),
          ),
        ),
        const Gap(10),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nameUser,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              Text(
                komenUser,
                maxLines: 4,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                  height: 1,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
