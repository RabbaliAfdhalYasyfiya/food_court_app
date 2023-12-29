import 'package:flutter/material.dart';
import 'package:food_court_app/services/models/markers.dart';
import 'package:food_court_app/widget/widget_tabbar.dart';

import '../../../widget/tile.dart';
import '../location_page.dart';


class ListFoodCourtPage extends StatefulWidget {
  const ListFoodCourtPage({super.key});

  @override
  State<ListFoodCourtPage> createState() => _ListFoodCourtPageState();
}

class _ListFoodCourtPageState extends State<ListFoodCourtPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  int currentIndex = 0;
  final List<Tab> tabs = [
    Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.grey),
        ),
        child: const Center(
          child: Text('Near me'),
        ),
      ),
    ),
    Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.grey),
        ),
        child: const Center(
          child: Text('Open'),
        ),
      ),
    ),
    Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.grey),
        ),
        child: const Center(
          child: Text('Rated 4.5+'),
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool sizedText = true;

  List<String> categories = [
    'Near me',
    'Open',
    'Rate',
  ];

  List<String> selectedCategories = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: NestedScrollView(
        scrollDirection: Axis.vertical,
        headerSliverBuilder: (contex, index) {
          return [
            SliverAppBar.medium(
              backgroundColor: Colors.white,
              scrolledUnderElevation: 2,
              elevation: 2,
              pinned: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                ),
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocationPage(),
                    ),
                  );
                },
              ),
              title: const Text(
                'Food Court',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ];
        },
        body: SafeArea(
          top: false,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 0,
                  child: SizedBox(
                    height: 50,
                    child: tabWithoutDivider(
                      context,
                      _tabController,
                      tabs,
                      (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListView.separated(
                    itemCount: markers.length,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemBuilder: (context, index) {
                      return TileFoodCourt(markers: markers[index]);
                    },
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
