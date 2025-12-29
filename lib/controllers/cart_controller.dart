import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../models/cart_item.dart';

class CartController extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  /// Add item to cart
  void addToCart(MenuItem item) {
    if (_items.containsKey(item.id)) {
      _items[item.id]!.quantity++;
    } else {
      _items[item.id] = CartItem(item: item, quantity: 1);
    }
    notifyListeners();
  }

  /// Increase quantity of an item
  void increaseQuantity(String itemId) {
    if (_items.containsKey(itemId)) {
      _items[itemId]!.quantity++;
      notifyListeners();
    }
  }

  /// Decrease quantity or remove if quantity = 1
  void decreaseQuantity(String itemId) {
    if (!_items.containsKey(itemId)) return;

    if (_items[itemId]!.quantity > 1) {
      _items[itemId]!.quantity--;
    } else {
      _items.remove(itemId);
    }
    notifyListeners();
  }

  /// Remove an item completely from cart
  void removeItem(String itemId) {
    if (_items.containsKey(itemId)) {
      _items.remove(itemId);
      notifyListeners();
    }
  }

  /// Total number of items in cart
  int get totalItems =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);

  /// Total amount of cart
  double get totalAmount =>
      _items.values.fold(0, (sum, item) => sum + item.totalPrice);

  /// Clear the cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
