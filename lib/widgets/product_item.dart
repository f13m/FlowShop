import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/shop_provider.dart';
import '../screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // الوصول للمحرك (Provider) بدون الاستماع للتغييرات هنا لتحسين الأداء
    final shopProvider = Provider.of<ShopProvider>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          // زر المفضلة
          leading: IconButton(
            icon: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.redAccent,
            ),
            onPressed: () {
              // تغيير حالة المفضلة في الـ Provider
              shopProvider.toggleFavorite(product.id);
            },
          ),
          // عنوان المنتج
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          // زر الإضافة للسلة
          trailing: IconButton(
            icon: const Icon(Icons.add_shopping_cart, color: Colors.blueAccent),
            onPressed: () {
              // إضافة المنتج للسلة
              shopProvider.addToCart(product);
              
              // إظهار رسالة تأكيد للمستخدم (SnackBar)
              ScaffoldMessenger.of(context).hideCurrentSnackBar(); // لإخفاء الرسالة السابقة إن وجدت
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تم إضافة ${product.title} إلى السلة'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'تراجع',
                    onPressed: () {
                      shopProvider.removeFromCart(product.id);
                    },
                  ),
                ),
              );
            },
          ),
        ),
        // الجزء القابل للضغط للانتقال لشاشة التفاصيل
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDetailsScreen(productId: product.id),
              ),
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            // إضافة مؤشر تحميل في حال تأخرت الصورة
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}