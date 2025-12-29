import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderPage extends StatelessWidget {
  final String orderId;
  const OrderPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Confirmed")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 20),
            const Text(
              "Payment Successful",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text("Order ID: $orderId"),
            const SizedBox(height: 20),

            // QR CODE
            QrImageView(data: orderId, size: 220),

            const SizedBox(height: 20),
            const Text(
              "Show this QR at the counter",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
