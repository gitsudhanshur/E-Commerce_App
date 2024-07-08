import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  List<Cart> _cartItems = [];

  List<Cart> get cartItems => _cartItems;

  void addProduct(Product product) {
    int index = _cartItems.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _cartItems[index].incrementQuantity();
    } else {
      _cartItems.add(Cart(product: product));
    }
    notifyListeners();
  }

  void removeProduct(String productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void incrementQuantity(String productId) {
    int index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _cartItems[index].incrementQuantity();
      notifyListeners();
    }
  }

  void decrementQuantity(String productId) {
    int index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0 && _cartItems[index].quantity > 1) {
      _cartItems[index].decrementQuantity();
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;
    for (var cart in _cartItems) {
      total += cart.product.price * cart.quantity;
    }
    return total;
  }
}
