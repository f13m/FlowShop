import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ShopProvider.dart';
import 'main_screen.dart';
import 'favorites_screen.dart';
import 'cart_screen.dart';
import 'categories_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  // قائمة الشاشات التي سنتنقل بينها
  final List<Map<String, Object>> _pages = [
    {'page': const MainScreen(), 'title': 'FlowShop'},
    {'page': CategoriesScreen(), 'title': 'الأقسام'},
    {'page': const FavoritesScreen(), 'title': 'مفضلاتي'},
    {'page': const CartScreen(), 'title': 'سلة المشتريات'},
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // العنوان يتغير تلقائياً حسب الشاشة المختارة
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
      ),
      // عرض الشاشة المختارة حالياً
      body: _pages[_selectedPageIndex]['page'] as Widget,
     bottomNavigationBar: BottomNavigationBar(
  onTap: _selectPage,
  currentIndex: _selectedPageIndex,
  
  // --- التعديلات المطلوبة للثيم ---
  type: BottomNavigationBarType.fixed,
  backgroundColor: const Color(0xFF1A1A1A), // خلفية داكنة جداً لتبرز الألوان
  selectedItemColor: Colors.blueAccent,    // لون الأيقونة والكلمة عند التحديد (أزرق)
  unselectedItemColor: Colors.grey,        // لون الأيقونة والكلمة غير المحددة
  showUnselectedLabels: true,              // إظهار الكلمات دائماً
  selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold), // جعل الكلمة المختارة عريضة
  // ------------------------------

  items: [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
    const BottomNavigationBarItem(icon: Icon(Icons.category), label: 'الأقسام'),
    const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'المفضلة'),
    BottomNavigationBarItem(
      icon: Consumer<ShopProvider>(
        builder: (_, shop, ch) => Badge(
          isLabelVisible: shop.cartItems.isNotEmpty,
          label: Text(shop.cartItems.length.toString()),
          child: ch!,
        ),
        child: const Icon(Icons.shopping_cart),
      ),
      label: 'السلة',
    ),
  ],
),
    );
  }
}