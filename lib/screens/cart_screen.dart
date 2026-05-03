import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shop_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // الاتصال بالـ Provider لمراقبة محتويات السلة
    final cart = Provider.of<ShopProvider>(context);

    return Column(
      children: [
        // كارت عرض المجموع الإجمالي
        Card(
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('الإجمالي', style: TextStyle(fontSize: 20)),
                const Spacer(),
                Chip(
                  label: Text(
                    '\$${cart.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blueAccent,
                ),
                TextButton(
                  onPressed: () {
                    // هنا نبرمج عملية الدفع لاحقاً
                  },
                  child: const Text('إتمام الشراء'),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        // قائمة المنتجات المختارة
        Expanded(
          child: ListView.builder(
            itemCount: cart.cartItems.length,
            itemBuilder: (ctx, i) => ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(cart.cartItems[i].imageUrl),
              ),
              title: Text(cart.cartItems[i].title),
              subtitle: Text('السعر: \$${cart.cartItems[i].price}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // استدعاء دالة الحذف من الـ Provider
                  cart.removeFromCart(cart.cartItems[i].id);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}