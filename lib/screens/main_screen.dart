import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ShopProvider.dart';
import '../widgets/product_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    // جلب البيانات بطريقة احترافية تضمن عدم تعارضها مع بناء السياق
    Future.microtask(() =>
        Provider.of<ShopProvider>(context, listen: false).loadProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(
      builder: (ctx, shopData, child) {
        // 1. حالة التحميل
        if (shopData.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // 2. حالة خلو البيانات
        if (shopData.items.isEmpty) {
          return const Center(
            child: Text(
              "لا توجد منتجات لعرضها.\nتأكد من الاتصال بالإنترنت.",
              textAlign: TextAlign.center,
            ),
          );
        }

        // 3. حالة عرض البيانات
        final products = shopData.items;

        // التعديل الجوهري: إضافة return وتغليف العناصر بـ ChangeNotifierProvider
        return GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2, // نسبة العرض إلى الطول لتناسب شكل البطاقة
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: products[i], // توفير كائن المنتج الفردي لـ ProductItem
            child: ProductItem(
              product: products[i],
            ),
          ),
        );
      },
    );
  }
}