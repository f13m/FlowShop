import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// الاستيرادات الخاصة بمشروعك
import 'providers/ShopProvider.dart';
import './screens/tabs_screen.dart';

// 1. يجب إضافة async هنا لأننا سنستخدم await بالداخل
void main() async {
  // 2. هذا هو السطر الجوهري الذي ينقصك؛ يضمن تهيئة روابط فلاتر قبل تشغيل الـ Provider
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // 3. نقوم باستدعاء loadProducts فور إنشاء الـ Provider لجلب البيانات
      create: (context) => ShopProvider()..loadProducts(),
      child: MaterialApp(
        title: 'FlowShop',
        debugShowCheckedModeBanner: false,
        theme: _buildAppTheme(),
        home: const TabsScreen(),
      ),
    );
  }

  ThemeData _buildAppTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blueAccent,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 4,
        titleTextStyle: TextStyle(
          fontFamily: 'Cairo', 
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(fontFamily: 'Cairo'),
      ),
    );
  }
}