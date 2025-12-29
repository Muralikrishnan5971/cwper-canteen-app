import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/cart_controller.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createOrder({
    required String userName,
    required CartController cart,
    required String paymentId,
  }) async {
    final orderId = "ORD_${DateTime.now().millisecondsSinceEpoch}";

    await _firestore.collection('orders').doc(orderId).set({
      "orderId": orderId,
      "userName": userName,
      "paymentId": paymentId,
      "amount": cart.totalAmount,
      "status": "PAID",
      "createdAt": FieldValue.serverTimestamp(),
      "items": cart.items.values.map((cartItem) {
        return {
          "name": cartItem.item.name,
          "price": cartItem.item.price,
          "quantity": cartItem.quantity,
          "total": cartItem.totalPrice,
        };
      }).toList(),
    });

    return orderId;
  }
}
