import 'package:e_commerce_app/models/product.dart';

class Cart {
  final Product product;
  int quantity;

  Cart({
    required this.product,
    this.quantity = 1,
  });

  // Optionally, you can add methods to update the quantity
  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
