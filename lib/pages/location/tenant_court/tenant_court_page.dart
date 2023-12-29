import 'package:flutter/material.dart';
import 'package:food_court_app/widget/tile.dart';
import 'package:food_court_app/widget/widget_tabbar.dart';

import '../../../services/models/markers.dart';
import '../food_court/food_court_page.dart';

class TenantCourtPage extends StatefulWidget {
  final Markers markers;
  const TenantCourtPage({super.key, required this.markers});

  @override
  State<TenantCourtPage> createState() => _TenantCourtPageState();
}

class _TenantCourtPageState extends State<TenantCourtPage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  final List<Tab> tabs = const [
    Tab(text: 'Menu'),
    Tab(text: 'Best Seller'),
  ];

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
                  builder: (context) => FoodCourtPage(markers: widget.markers),
                ),
              );
            },
          ),
        ),
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              Image.network(
                'https://i.pinimg.com/564x/7d/f1/a5/7df1a5885648b4801552b1f05cf81ddc.jpg',
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
                      const Text(
                        'Name Tenant',
                        style: TextStyle(
                          fontSize: 22.5,
                          fontWeight: FontWeight.w600,
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
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return tileMenuFoodCourt(
                              context,
                              'https://i.pinimg.com/236x/bf/72/cf/bf72cf389f6e1d7e8cb53273f8c71e72.jpg',
                              'Nasi Goreng',
                              '',
                              'Indonesian',
                              '15.000',
                              () {},
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
