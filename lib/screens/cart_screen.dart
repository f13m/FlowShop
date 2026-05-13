import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ShopProvider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<ShopProvider>(context);
    
    // تعريف القائمة بشكل صريح
    final List<CartItem> cartItemsList = cart.cartItems.values.toList(); 

    return Column(
      children: [
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
                  onPressed: cart.totalAmount <= 0 
                      ? null 
                      : () {
                          // برمجة الدفع لاحقاً
                          print('جاري الدفع...');
                        },
                  child: const Text('إتمام الشراء'),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: cartItemsList.isEmpty 
            ? const Center(child: Text('سلة المشتريات فارغة!'))
            : ListView.builder(
                itemCount: cartItemsList.length,
                itemBuilder: (ctx, i) {
                  final currentItem = cartItemsList[i];

                  // لاحظ علامة التعجب (!) بعد currentItem في كل سطر
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(currentItem!.imageUrl),
                    ),
                    title: Text(currentItem!.title),
                    subtitle: Text(
                      'الكمية: x${currentItem!.quantity} - السعر: \$${(currentItem!.price * currentItem!.quantity).toStringAsFixed(2)}'
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        cart.removeFromCart(currentItem!.id);
                      },
                    ),
                  );
                },
              ),
        ),
      ],
    );
  }
}