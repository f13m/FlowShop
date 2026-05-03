import 'package:flutter/material.dart';

class Product {
  final String id;          // معرف فريد لكل منتج
  final String title;       // اسم المنتج
  final String description; // وصف المنتج (للشاشة التي اقترحتَها)
  final double price;       // سعر المنتج
  final String imageUrl;    // رابط الصورة
  bool isFavorite;          // حالة المفضلة (متغيرة)

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false, // القيمة الافتراضية ليست مفضلة
  });

  // دالة لتبديل حالة المفضلة
  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
  }
}