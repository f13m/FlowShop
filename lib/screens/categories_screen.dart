import 'package:flutter/material.dart';
import 'category_products_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key}); // استخدام const هنا أفضل للممارسات

  final List<Map<String, dynamic>> categories = const [
    {
      'title': 'Electronics', 
      'icon': Icons.electrical_services, 
      'color': Colors.blue,
      'searchKey': 'smartphones'
    },
    {
      'title': 'Fashion', 
      'icon': Icons.checkroom, 
      'color': Colors.red,
      'searchKey': 'mens-shirts'
    },
    {
      'title': 'Sports', 
      'icon': Icons.sports_basketball, 
      'color': Colors.green,
      'searchKey': 'sports-accessories'
    },
    {
      'title': 'Perfumes', 
      'icon': Icons.flare, 
      'color': Colors.purple,
      'searchKey': 'fragrances'
    },
    {
      'title': 'Furniture', // قمت بتعديل الاسم ليكون أوضح برمجياً
      'icon': Icons.chair, 
      'color': Colors.teal,
      'searchKey': 'furniture'
    },
    {
      'title': 'Others', 
      'icon': Icons.more_horiz, 
      'color': Colors.orange,
      'searchKey': 'groceries'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemBuilder: (ctx, i) {
        return Material( // إضافة Material لتفعيل تأثير النقر (Ripple Effect)
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => CategoryProductsScreen(
                    categoryName: categories[i]['searchKey'],
                    categoryTitle: categories[i]['title'],
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(15), // لضمان بقاء التأثير داخل الحواف
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white10), // إضافة إطار خفيف جداً للجمالية
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // تغليف الأيقونة بحاوية دائرية خفيفة لإبراز اللون
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (categories[i]['color'] as Color).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      categories[i]['icon'], 
                      size: 35, 
                      color: categories[i]['color']
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    categories[i]['title'],
                    style: const TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}