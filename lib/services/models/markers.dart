import 'package:google_maps_flutter/google_maps_flutter.dart';

class Markers {
  final String label;
  final LatLng latlng;
  final String rating;
  final String imgIcon;
  final String imgPlace;
  final bool openClose;

  Markers({
    required this.label,
    required this.latlng,
    required this.rating,
    required this.imgIcon,
    required this.imgPlace,
    required this.openClose,
  });
}

List<Markers> markers = [
  Markers(
    label: 'KEDJORA Food Hall',
    latlng: const LatLng(-7.757521314412837, 110.32010436290017),
    rating: '4,9',
    imgIcon: 'assets/mapicons/restaurants.png',
    imgPlace:
        'https://lh5.googleusercontent.com/p/AF1QipOoGdd1xI38aWSoTHafEU6I9OOmeYDjvZKthiMv=w408-h724-k-no',
    openClose: false,
  ),
  Markers(
    label: 'Warung Kopi dan Food Court Mbak Rani',
    latlng: const LatLng(-7.734262756577598, 110.34242220394368),
    rating: '4,5',
    imgIcon: 'assets/mapicons/restaurants.png',
    imgPlace:
        'https://lh5.googleusercontent.com/p/AF1QipPEjwr22qn6k-BpB_fYV07dO4OHSxUwKZEkpPiI=w408-h389-k-no',
    openClose: true,
  ),
  Markers(
    label: 'Pramonihh Food Court',
    latlng: const LatLng(-7.737676671672309, 110.3513126835237),
    rating: '3,9',
    imgIcon: 'assets/mapicons/restaurants.png',
    imgPlace:
        'https://lh5.googleusercontent.com/p/AF1QipNmTGZqDKRS4w6F_c-KDNDmzxScSzUFnI7Y-Hbm=w408-h306-k-no',
    openClose: true,
  ),
  Markers(
    label: "Oko.ono",
    latlng: const LatLng(-7.740674232832946, 110.35571590779429),
    rating: '4,3',
    imgIcon: 'assets/mapicons/restaurants.png',
    imgPlace:
        'https://lh5.googleusercontent.com/p/AF1QipOQOq20tZSLI9MgZx_wCgKO92skzIsMMqortdNU=w408-h306-k-no',
    openClose: false,
  ),
  Markers(
    label: 'Lombok Abang',
    latlng: const LatLng(-7.736993890876185, 110.36171572087518),
    rating: '5,0',
    imgIcon: 'assets/mapicons/restaurants.png',
    imgPlace:
        'https://lh5.googleusercontent.com/p/AF1QipPLp7fXihU-4Bn36NKnru5HBdHW9JDtq3NqYmrk=w426-h240-k-no',
    openClose: true,
  ),
  Markers(
    label: 'Food Court Indogrosir Lt. 2',
    latlng: const LatLng(-7.750696883712289, 110.3624950262152),
    rating: '4,2',
    imgIcon: 'assets/mapicons/restaurants.png',
    imgPlace:
        'https://lh5.googleusercontent.com/p/AF1QipNi65dkiM-zTpWndYo6SSMR1Qhoslyk_GVsJeVk=w426-h240-k-no',
    openClose: false,
  ),
  Markers(
    label: 'Foodcourt Jombor',
    latlng: const LatLng(-7.750778431531081, 110.36260006325),
    rating: '5,0',
    imgIcon: 'assets/mapicons/restaurants.png',
    imgPlace:
        'https://lh5.googleusercontent.com/p/AF1QipMBBJ293_kcw7wz3TdO1jDX8K2i6e9VQtRoyWpa=w408-h306-k-no',
    openClose: true,
  ),
  Markers(
    label: 'Jogja Paradise Food Court',
    latlng: const LatLng(-7.751954519193332, 110.36263711175141),
    rating: '4,3',
    imgIcon: 'assets/mapicons/restaurants.png',
    imgPlace:
        'https://lh3.googleusercontent.com/gps-proxy/AMy85WLmKG6Zehh0gt1j9_ZPT6i9m3T8pxo45jvkGyU5Y8PXszLpFVS1FquSqAfzrpQZ4l5Rw1LN7YPPO4upWyNXw6A-5tNdSvxUdfGTiJW7EpNKAf06cgD31Jij53rk4NgmlxEpP-po8hm-MTGVlYr0Go5qDEEBB4uXpZXMnnX1t8u-O77C1MP-fwymjWyktpJ2JBbP10w=w408-h306-k-no',
    openClose: false,
  ),
  Markers(
    label: 'Food Garden Jogja City Mall',
    latlng: const LatLng(-7.753236768391502, 110.36097329803991),
    rating: '4,2',
    imgIcon: 'assets/mapicons/restaurants.png',
    imgPlace:
        'https://lh5.googleusercontent.com/p/AF1QipPjpfUhhyesh-xjW5-MxtjqIM3nvGPeaSZn2Bos=w408-h306-k-no',
    openClose: true,
  ),
  Markers(
    label: 'Food Court Pujo',
    latlng: const LatLng(-7.753175282955233, 110.3598400837832),
    rating: '5,0',
    imgIcon: 'assets/mapicons/restaurants.png',
    imgPlace:
        'https://lh5.googleusercontent.com/p/AF1QipMMOgkc399lsDEtOYy-U52HdNmLMEV0qTLRo8o=w426-h240-k-no',
    openClose: true,
  ),
  Markers(
    label: 'Kondang Food Court',
    latlng: const LatLng(-7.754004481212905, 110.36005466049869),
    rating: '4,4',
    imgIcon: 'assets/mapicons/restaurants.png',
    imgPlace:
        'https://lh5.googleusercontent.com/p/AF1QipNWTYnlzg5l7tsQneWVspH3b8zQ1JhXLG8egUla=w426-h240-k-no',
    openClose: false,
  ),
  Markers(
    label: 'Foodcourt Teras pojok ndeso',
    latlng: const LatLng(-7.754876200696277, 110.35971133775391),
    rating: '4,6',
    imgIcon: 'assets/mapicons/restaurants.png',
    imgPlace:
        'https://lh5.googleusercontent.com/p/AF1QipPrv-B-N5gCQgz4_Ory0jA-DdNgQnf52KQ7rTlM=w408-h306-k-no',
    openClose: false,
  ),
  Markers(
    label: 'Indomie Tumis Zafa',
    latlng: const LatLng(-7.760831696257761, 110.35007645630986),
    rating: '5,0',
    imgIcon: 'assets/mapicons/restaurants.png',
    imgPlace:
        'https://lh5.googleusercontent.com/p/AF1QipOgJdkbn8fpH5hAMuYt_gRGcJNGoHCNu2P-TA-j=w508-h240-k-no',
    openClose: true,
  ),
  Markers(
    label: 'Burjo Omega',
    latlng: const LatLng(-7.731232881898071, 110.38314023143305),
    rating: '4,8',
    imgIcon: 'assets/mapicons/restaurants.png',
    imgPlace:
        'https://lh5.googleusercontent.com/p/AF1QipOeE4eg4fMQ_iTEw0oq0FNQwGsmjWU82pTIF8dd=w408-h544-k-no',
    openClose: true,
  ),
];
