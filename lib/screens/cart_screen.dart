import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 242, 240, 238),
        appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 115, 1),
        elevation: 0,
        title: const Text(
          'My Cart',
          style: TextStyle(color: Color.fromARGB(255, 251, 251, 251)),
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return TextButton.icon(
                onPressed: cart.itemCount > 0
                    ? () {
                        cart.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Cart cleared'),
                            duration: Duration(seconds: 1),
                            backgroundColor: Color(0xFF2D0C57),
                          ),
                        );
                      }
                    : null,
                icon: const Icon(Icons.delete, color: Color.fromARGB(255, 1, 1, 1)),
                label: const Text(
                  'Clear',
                  style: TextStyle(color: Color.fromARGB(255, 6, 6, 5)),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.itemCount == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: const Color.fromARGB(255, 255, 136, 0).withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 9, 10, 10),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Add some delicious items to your cart',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(179, 7, 4, 4),
                    ),
                  ),
                ],
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cart.items.length,
                  itemBuilder: (ctx, i) {
                    final cartItem = cart.items.values.toList()[i];
                    return Dismissible(
                      key: ValueKey(cartItem.id),
                      background: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        color: Colors.red.shade400,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        cart.removeItem(cartItem.id);
                      },
                      child: Card(
                        color: const Color.fromARGB(255, 239, 236, 218),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(8),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              cartItem.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                width: 60,
                                height: 60,
                                color: Colors.grey.shade300,
                                child: const Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            cartItem.name,
                            style: const TextStyle(
                              color: Color(0xFF2D0C57),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '₹${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
                            style: TextStyle(
                              color: const Color(0xFF2D0C57).withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: Color(0xFF2D0C57),
                                ),
                                onPressed: () {
                                  cart.removeSingleItem(cartItem.id);
                                },
                              ),
                              Text(
                                '${cartItem.quantity}',
                                style: const TextStyle(
                                  color: Color(0xFF2D0C57),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  color: Color(0xFF2D0C57),
                                ),
                                onPressed: () {
                                  cart.addSingleItem(cartItem.id);
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
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 239, 236, 218),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Subtotal',
                            style: TextStyle(
                              color: Color(0xFF2D0C57),
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '₹${cart.subtotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Color(0xFF2D0C57),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Delivery Fee',
                            style: TextStyle(
                              color: Color(0xFF2D0C57),
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '₹${cart.deliveryFee.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Color(0xFF2D0C57),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Color(0xFF2D0C57)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              color: Color(0xFF2D0C57),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '₹${cart.total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Color(0xFF2D0C57),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 251, 147, 2),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: cart.total <= 0
                              ? null
                              : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Processing your order...'),
                                      backgroundColor: Color.fromARGB(255, 251, 130, 1),
                                    ),
                                  );
                                },
                          child: const Text(
                            'CHECKOUT',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
} 