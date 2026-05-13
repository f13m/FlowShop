import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/ShopProvider.dart';
import '../screens/product_details_screen.dart';

// ... الاستيرادات ...

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final shopProvider = Provider.of<ShopProvider>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          // التعديل: نستخدم Consumer لمراقبة كائن المنتج الفردي
          leading: Consumer<Product>(
            builder: (ctx, prod, _) => IconButton(
              iconSize: 20, 
              icon: Icon(
                prod.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.redAccent,
              ),
             onPressed: () {
                // 1. نقوم بتحديث الحالة عبر الـ Provider أولاً
                shopProvider.updateFavoriteStatus(prod.id);
                
                // 2. الحل البرمجي: نعتمد على الحالة المعكوسة لحظياً لإظهار الرسالة الصحيحة
                // أو نستخدم الحالة المحدثة مباشرة إذا كان الكائن 'prod' محدثاً
                final String message = !prod.isFavorite ? 'حذفت من المفضلة' : 'اضيفت الى المفضلة';

                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: !prod.isFavorite ? Colors.redAccent : Colors.green, // تمييز بصري احترافي
                    duration: const Duration(milliseconds: 800),
                    behavior: SnackBarBehavior.floating, // يجعل الرسالة تطفو بشكل عصري
                  ),
                );
              },
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            iconSize: 20,
            icon: const Icon(Icons.add_shopping_cart, color: Colors.blueAccent),
            onPressed: () {
              shopProvider.addToCart(product);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تم إضافة ${product.title} إلى السلة'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'تراجع',
                    onPressed: () => shopProvider.removeSingleItem(product.id),
                  ),
                ),
              );
            },
          ),
        ),
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
            fit: BoxFit.contain, 
            errorBuilder: (ctx, error, stackTrace) => const Center(
              child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
            ),
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