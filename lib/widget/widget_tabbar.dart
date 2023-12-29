import 'package:flutter/material.dart';

Widget tabWithDivider(
  BuildContext context,
  List<Tab> tabs,
  Function(int) onTap,
) {
  return TabBar(
    automaticIndicatorColorAdjustment: true,
    isScrollable: true,
    enableFeedback: true,
    dividerHeight: 0.5,
    dividerColor: Colors.grey,
    onTap: onTap,
    tabs: tabs,
    labelPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    labelStyle: const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 15,
      height: 2,
    ),
    overlayColor: MaterialStatePropertyAll(Colors.grey.shade300),
    unselectedLabelStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 15,
    ),
    labelColor: Theme.of(context).primaryColor,
    tabAlignment: TabAlignment.start,
    indicatorSize: TabBarIndicatorSize.label,
    indicatorWeight: 5,
    indicatorColor: Theme.of(context).primaryColor,
  );
}

Widget tabWithoutDivider(
  BuildContext context,
  TabController controller,
  List<Tab> tabs,
  Function(int) onTap,
) {
  return TabBar(
    automaticIndicatorColorAdjustment: true,
    isScrollable: true,
    enableFeedback: true,
    onTap: onTap,
    controller: controller,
    tabs: tabs,
    physics: const ClampingScrollPhysics(),
    labelPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3.8),
    labelStyle: const TextStyle(
      fontWeight: FontWeight.w600,
    ),
    overlayColor: MaterialStatePropertyAll(Colors.grey.shade300),
    unselectedLabelStyle: const TextStyle(
      fontWeight: FontWeight.w400,
    ),
    dividerColor: Colors.transparent,
    labelColor: Colors.white,
    tabAlignment: TabAlignment.start,
    splashBorderRadius: BorderRadius.circular(50),
    indicatorSize: TabBarIndicatorSize.label,
    indicator: BoxDecoration(
      color: Theme.of(context).primaryColor,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(50),
    ),
    indicatorPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
  );
}

class FilterFoodCourt {
  final String name;
  final String category;
  FilterFoodCourt({
    required this.name,
    required this.category,
  });
}

final List<FilterFoodCourt> filter = [
  FilterFoodCourt(name: "Near me", category: 'Near me'),
  FilterFoodCourt(name: "Open", category: 'Open'),
  FilterFoodCourt(name: "Rate 4.5+", category: 'Rate'),
];
