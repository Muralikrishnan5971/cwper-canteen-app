import 'package:canteen/screens/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/cart_controller.dart';
import '../models/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartController>();
    final cartItems = cart.items.values.toList(); // convert Map to List

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: Colors.blue[500],
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text("Your cart is empty", style: TextStyle(fontSize: 18)),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final CartItem cartItem = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          title: Text(
                            cartItem.item.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "₹ ${cartItem.item.price.toStringAsFixed(2)} x ${cartItem.quantity}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          trailing: SizedBox(
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    cart.decreaseQuantity(cartItem.item.id);
                                  },
                                ),
                                Text(
                                  cartItem.quantity.toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    cart.increaseQuantity(cartItem.item.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Total amount and Checkout button
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total: ₹ ${cart.totalAmount.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CheckoutPage(),
                            ),
                          );
                          // Mock Payment Flow

                          // make this dialog set up after payment integration done!
                          // showDialog(
                          //   context: context,
                          //   builder: (_) => AlertDialog(
                          //     title: const Text("Payment Successful"),
                          //     content: Text(
                          //       "You have paid ₹ ${cart.totalAmount.toStringAsFixed(2)}",
                          //     ),
                          //     actions: [
                          //       TextButton(
                          //         onPressed: () {
                          //           cart.clearCart(); // clear cart
                          //           Navigator.pop(context); // close dialog
                          //           Navigator.pop(context); // back to menu
                          //         },
                          //         child: const Text("OK"),
                          //       ),
                          //     ],
                          //   ),
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          "Checkout",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
