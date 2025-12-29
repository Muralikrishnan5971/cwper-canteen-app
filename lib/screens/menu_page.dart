import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../controllers/cart_controller.dart';
import 'package:provider/provider.dart';
import 'cart_page.dart';

class MenuPage extends StatefulWidget {
  final String userName; // pass "Murali" from login screen
  const MenuPage({super.key, required this.userName});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // SAMPLE DATA
  final List<Map<String, dynamic>> breakfastItems = [
    {
      "name": "Idly",
      "price": 20,
      "calories": 150,
      "image": "assets/images/idly.png",
    },
    {
      "name": "Pongal",
      "price": 35,
      "calories": 320,
      "image": "assets/images/dosa.png",
    },
    {
      "name": "Coffee",
      "price": 35,
      "calories": 320,
      "image": "assets/images/coffee.png",
    },
  ];

  final List<Map<String, dynamic>> lunchItems = [
    {
      "name": "Meals",
      "price": 60,
      "calories": 650,
      "image": "assets/images/meals.png",
    },
    {
      "name": "Curd Rice",
      "price": 40,
      "calories": 280,
      "image": "assets/images/curdrice.png",
    },
  ];

  MenuItem _toMenuItem(Map<String, dynamic> item, String category) {
    return MenuItem(
      id: "${category}_${item["name"]}", // unique id
      name: item["name"],
      price: item["price"].toDouble(),
      category: category,
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Whenever image is added, add the asset to pubspec.yaml
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/indian-railways-logo.png', // your left logo
            fit: BoxFit.contain,
          ),
        ),
        title: Text("CARRIAGE WORKS CANTEEN"),
        actions: [
          Consumer<CartController>(
            builder: (context, cart, _) => Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    // Navigate to Cart Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CartPage()),
                    );
                  },
                ),
                if (cart.totalItems > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        cart.totalItems.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
        backgroundColor: Colors.blue[500],
        centerTitle: true,
        elevation: 4,
        bottom: TabBar(
          controller: _tabController,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          tabs: const [
            Tab(text: "Breakfast"),
            Tab(text: "Lunch"),
          ],
        ),
      ),
      backgroundColor: Colors.blue[100],

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Good Morning, ${widget.userName}!",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // BREAKFAST LIST
                buildFoodList(breakfastItems, "BREAKFAST"),

                // LUNCH LIST
                buildFoodList(lunchItems, "LUNCH"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFoodList(List<Map<String, dynamic>> items, String category) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Card(
          elevation: 3,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // FOOD IMAGE
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: Image.asset(
                  item["image"],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["name"],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),

                      Text(
                        "₹ ${item["price"]}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "${item["calories"]} calories",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ADD TO CART BUTTON
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ElevatedButton(
                  onPressed: () {
                    // Cart logic here
                    final menuItem = _toMenuItem(item, category);
                    context.read<CartController>().addToCart(menuItem);

                    final messenger = ScaffoldMessenger.of(context);
                    // 🔥 Remove any existing SnackBar immediately
                    messenger.hideCurrentSnackBar();

                    messenger.showSnackBar(
                      SnackBar(
                        content: Text("${item["name"]} added to cart"),
                        duration: const Duration(milliseconds: 900),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: const Text("Add to cart"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
