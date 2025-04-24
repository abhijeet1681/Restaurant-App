class CartItemModel {
  final String id;        // Unique ID to track the item
  final String name;      // Name of the food item
  final String image;     // Image path or URL
  final double price;     // Price per unit
  int quantity;           // Quantity in the cart

  CartItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1,
  });

  // Total price = price * quantity
  double get total => price * quantity;
}
