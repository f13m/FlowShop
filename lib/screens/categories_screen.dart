import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
   CategoriesScreen({super.key});

  // قائمة وهمية للأقسام بناءً على تصميمك
  final List<Map<String, dynamic>> categories = const [
    {'title': 'Electronics', 'icon': Icons.electrical_services, 'color': Colors.blue},
    {'title': 'Fashion', 'icon': Icons.checkroom, 'color': Colors.red},
    {'title': 'Sports', 'icon': Icons.sports_basketball, 'color': Colors.green},
    {'title': 'Perfumes', 'icon': Icons.flare, 'color': Colors.purple},
    {'title': 'Backset', 'icon': Icons.chair, 'color': Colors.teal},
    {'title': 'Others', 'icon': Icons.more_horiz, 'color': Colors.orange},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,          // عمودان كما في الصورة
        childAspectRatio: 1.2,      // لجعل المربعات شبه مربعة
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemBuilder: (ctx, i) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[900], // خلفية داكنة تناسب تصميمك
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(categories[i]['icon'], size: 40, color: categories[i]['color']),
              const SizedBox(height: 10),
              Text(
                categories[i]['title'],
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}