import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// الاستيرادات الخاصة بمشروعك
import './providers/shop_provider.dart';
import './screens/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // نغلف التطبيق بـ ChangeNotifierProvider لإدارة الحالة في كامل المشروع
    return ChangeNotifierProvider(
      create: (context) => ShopProvider(),
      child: MaterialApp(
        title: 'FlowShop',
        debugShowCheckedModeBanner: false,
        theme: _buildAppTheme(), // استدعاء دالة الثيم المنظمة
        home: const TabsScreen(),
      ),
    );
  }

  // دالة منفصلة لبناء الثيم لزيادة مقروئية الكود وتنظيمه
  ThemeData _buildAppTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blueAccent,
        brightness: Brightness.dark, // الاعتماد على الوضع الداكن كاساس
      ),
      
      // تعديل البار العلوي ليكون أزرقاً كما طلبت
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.blueAccent, // اللون الأزرق للبار العلوي
        foregroundColor: Colors.white,      // لون النص والأيقونات (أبيض)
        elevation: 4,
        titleTextStyle: TextStyle(
          fontFamily: 'Cairo', 
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      // تنسيق الكروت في التطبيق
      cardTheme: CardTheme(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),

      // تنسيق عام للنصوص
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(fontFamily: 'Cairo'),
      ),
    );
  }
}