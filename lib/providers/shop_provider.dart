import 'package:flutter/material.dart';
import '../models/product.dart';

class ShopProvider with ChangeNotifier {
  // قائمة المنتجات (بيانات وهمية للتجربة)
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Aura Headphones',
      description: 'سماعات احترافية بعزل ضوضاء فائق وجودة صوت نقية.',
      price: 145.00,
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=500',
    ),
    Product(
      id: 'p2',
      title: 'Nova Smart Watch',
      description: 'ساعة ذكية متطورة لمتابعة النشاط البدني والصحة بدقة عالية.',
      price: 129.90,
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=500',
    ),
    Product(
      id: 'p3',
      title: 'Velvet Perfume',
      description: 'عطر فريد يجمع بين الأصالة والحداثة برائحة تدوم طويلاً.',
      price: 74.99,
      imageUrl: 'https://images.unsplash.com/photo-1541643600914-78b084683601?q=80&w=500',
    ),
  ];

  // قائمة العناصر في السلة
  final List<Product> _cartItems = [];

  // دالة للحصول على نسخة من المنتجات (Getter)
  List<Product> get items => [..._items];

  // دالة للحصول على المنتجات المفضلة فقط
  List<Product> get favoriteItems => _items.where((prod) => prod.isFavorite).toList();

  // دالة للحصول على عناصر السلة
  List<Product> get cartItems => _cartItems;

  // منطق تبديل المفضلة
  void toggleFavorite(String id) {
    final product = _items.firstWhere((prod) => prod.id == id);
    product.toggleFavoriteStatus();
    notifyListeners(); // أهم سطر: لتحديث الواجهات فوراً
  }

  // منطق السلة
  void addToCart(Product product) {
    if (!_cartItems.contains(product)) {
      _cartItems.add(product);
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    _cartItems.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }

  // حساب المجموع الكلي
  double get totalAmount {
    return _cartItems.fold(0.0, (sum, item) => sum + item.price);
  }
}