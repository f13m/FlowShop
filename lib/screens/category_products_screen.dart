import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // إضافة المكتبة لتفعيل ChangeNotifierProvider
import '../services/api_service.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;
  final String categoryTitle;

  const CategoryProductsScreen({
    super.key, 
    required this.categoryName, 
    required this.categoryTitle
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
        centerTitle: true, // لضمان مظهر متناسق واحترافي
      ),
      body: FutureBuilder<List<Product>>(
        future: ApiService().fetchProductsByCategory(categoryName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا توجد منتجات في هذا القسم حالياً.'));
          } else {
            final products = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65, 
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: products.length,
              // التعديل الجوهري: تغليف المنتج بـ Provider
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: products[i], // ربط كائن المنتج القادم من الـ API بالـ Provider
                child: ProductItem(
                  product: products[i], 
                ),
              ),
            );
          }
        },
      ),
    );
  }
}