import 'package:canteen/screens/order_page.dart';
import 'package:canteen/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../controllers/cart_controller.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _onPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _onPaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _onExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  // ---------------- PAYMENT HANDLERS ----------------

  void _onPaymentSuccess(PaymentSuccessResponse response) async {
    // Read BEFORE async gap
    final cart = context.read<CartController>();

    final orderService = OrderService();

    // 1️⃣ Create order in Firestore (async)
    final orderId = await orderService.createOrder(
      userName: "Murali", // later use logged-in user
      cart: cart,
      paymentId: response.paymentId!,
    );

    // ⛔ Widget may have been disposed
    if (!mounted) return;

    // 2️⃣ Clear cart after order creation
    cart.clearCart();

    // 3️⃣ Navigate to Order Success page (QR screen)
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => OrderPage(orderId: orderId)),
      (route) => false,
    );
  }

  void _onPaymentError(PaymentFailureResponse response) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Payment Failed"),
        content: Text(response.message ?? "Something went wrong"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }

  void _onExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Wallet: ${response.walletName}")));
  }

  // ---------------- OPEN CHECKOUT ----------------

  void _startPayment(double amount) {
    final options = {
      'key': 'rzp_test_Rwyou2nHTFJEWs', // 🔴 your test key ID
      'amount': (amount * 100).toInt(), // rupees → paise
      'currency': 'INR',
      'name': 'Carriage Works Canteen',
      'description': 'Food Order',
      'timeout': 120,
      'method': {
        'upi': true, // enable UPI apps like GPay
        'card': true, // enable cards
        'netbanking': false,
        'wallet': false,
        'paylater': false,
        'emi': false,
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Razorpay open error: $e");
    }
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // -------- SUMMARY --------
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      "Order Summary",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...cart.items.values.map(
                      (item) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${item.item.name} × ${item.quantity}"),
                          Text("₹ ${item.totalPrice}"),
                        ],
                      ),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "₹ ${cart.totalAmount.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // -------- PAY BUTTON --------
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _startPayment(cart.totalAmount);
                },
                child: const Text("Pay Now", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
