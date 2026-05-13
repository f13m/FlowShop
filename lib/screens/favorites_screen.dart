import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ShopProvider.dart';
import '../widgets/product_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // هنا نطلب من الـ Provider إعطاءنا القائمة المصفاة فقط
    final favoriteProducts = Provider.of<ShopProvider>(context).favoriteItems;

  return favoriteProducts.isEmpty 
    ? const Center(child: Text('لم تقم بإضافة أي منتجات للمفضلة بعد!'))
    : GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: favoriteProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        // التعديل هنا لإصلاح خطأ "Could not find the correct Provider"
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: favoriteProducts[i], // توفير كائن المنتج الفردي للمراقب (Consumer)
          child: ProductItem(product: favoriteProducts[i]),
        ),
      );
  }
}