import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final int id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  // 1. تحويل البيانات القادمة من السيرفر (API)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'منتج بدون عنوان',
      description: json['description'] ?? 'لا يوجد وصف متاح لهذا المنتج',
      price: (json['price'] as num? ?? 0.0).toDouble(),
      imageUrl: json['thumbnail'] ?? 'https://via.placeholder.com/150',
      isFavorite: false, 
    );
  }

  // 2. دالة تحويل الكائن إلى Map ليتم حفظه في ذاكرة الهاتف (SharedPreferences)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
    };
  }

  // 3. دالة استعادة الكائن من ذاكرة الهاتف (Offline Mode)
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners(); 
  }
}