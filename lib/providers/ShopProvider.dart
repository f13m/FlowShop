import 'dart:convert'; // ضروري لتحويل البيانات (json encode/decode)
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // تأكد من إضافة المكتبة في pubspec.yaml
import '../models/product.dart';
import '../services/api_service.dart';

// كلاس مساعد لبيانات السلة
class CartItem {
  final int id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });
}

class ShopProvider with ChangeNotifier {
  List<Product> _items = [];
  bool _isLoading = false;
  final ApiService _apiService = ApiService();

  List<Product> get items => [..._items];
  bool get isLoading => _isLoading;

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  // --- منطق التخزين المحلي (Caching Logic) ---

  // 1. حفظ المنتجات في الذاكرة الدائمة
  Future<void> _saveToCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // تحويل قائمة المنتجات إلى JSON String
      final String encodedData = json.encode(
        _items.map((prod) => prod.toMap()).toList(),
      );
      await prefs.setString('cached_products', encodedData);
    } catch (e) {
      print("🚨 فشل حفظ الكاش: $e");
    }
  }

  // 2. استرجاع المنتجات من الذاكرة الدائمة
  Future<void> _loadFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('cached_products')) return;

      final String? cachedData = prefs.getString('cached_products');
      if (cachedData != null) {
        final List<dynamic> decodedData = json.decode(cachedData);
        _items = decodedData.map((item) => Product.fromMap(item)).toList();
        print("✅ تم تحميل البيانات من الذاكرة المحلية (Offline Mode)");
      }
    } catch (e) {
      print("🚨 فشل استرجاع الكاش: $e");
    }
  }

  // --- دالة جلب البيانات المطورة ---
  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // محاولة جلب البيانات من السيرفر
      _items = await _apiService.fetchProducts();
      // إذا نجحت العملية، قم بتحديث الكاش فوراً
      await _saveToCache();
      print("✅ تم تحديث البيانات من السيرفر بنجاح");
    } catch (error) {
      print("🚨 فشل الاتصال بالسيرفر، محاولة جلب الكاش... : $error");
      // في حالة الفشل، قم بتحميل الكاش
      await _loadFromCache();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

Product findById(int id) {
  // استخدام safe search
  return _items.firstWhere(
    (prod) => prod.id == id,
    orElse: () => Product(id: 0, title: 'none', description: '', price: 0.0, imageUrl: ''),
  );
}

  // تبديل حالة المفضلة
bool toggleFavoriteStatus(int id) {
  final productIndex = _items.indexWhere((prod) => prod.id == id);
  if (productIndex >= 0) {
    _items[productIndex].toggleFavoriteStatus();
    _saveToCache(); 
    notifyListeners();
    // نعيد الحالة الجديدة بعد التبديل
    return _items[productIndex].isFavorite;
  }
  return false;
}

  // ==========================================
  // --- نظام السلة (Cart Logic) ---
  // ==========================================
  
  final Map<int, CartItem> _cartItems = {};

  Map<int, CartItem> get cartItems => {..._cartItems};

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addToCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems.update(
        product.id,
        (existing) => CartItem(
          id: existing.id,
          title: existing.title,
          price: existing.price,
          quantity: existing.quantity + 1,
          imageUrl: existing.imageUrl,
        ),
      );
    } else {
      _cartItems.putIfAbsent(
        product.id,
        () => CartItem(
          id: product.id,
          title: product.title,
          price: product.price,
          quantity: 1,
          imageUrl: product.imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(int productId) {
    if (!_cartItems.containsKey(productId)) return;
    if (_cartItems[productId]!.quantity > 1) {
      _cartItems.update(
        productId,
        (existing) => CartItem(
          id: existing.id,
          title: existing.title,
          price: existing.price,
          quantity: existing.quantity - 1,
          imageUrl: existing.imageUrl,
        ),
      );
    } else {
      _cartItems.remove(productId);
    }
    notifyListeners();
  }

  void removeFromCart(int productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
  // داخل كلاس ShopProvider
void updateFavoriteStatus(int id) {
  final productIndex = _items.indexWhere((prod) => prod.id == id);
  if (productIndex >= 0) {
    _items[productIndex].toggleFavoriteStatus();
    notifyListeners(); // تحديث كافة الشاشات المرتبطة بالمفصلة
  }
}
}