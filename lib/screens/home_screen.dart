import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/food_provider.dart';
import '../providers/cart_provider.dart';
import '../models/food_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 238, 242),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 253, 110, 0),
        title: const Text('Food Point', style: TextStyle(color: Color.fromARGB(255, 251, 251, 251))),
        elevation: 0,
        actions: [
          Row(
            children: [
              const Text(
                'Sort by: ',
                style: TextStyle(color: Color.fromARGB(255, 8, 8, 23), fontSize: 16),
              ),
              Consumer<FoodProvider>(
                builder: (context, foodProvider, child) {
                  return TextButton.icon(
                    icon: Icon(
                      foodProvider.isSortedByPriceAscending
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: const Color.fromARGB(255, 9, 9, 9),
                    ),
                    label: Text(
                      'Price',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 18, 18, 18),
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () => foodProvider.toggleSortByPrice(),
                  );
                },
              ),
            ],
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Color.fromARGB(255, 9, 9, 9)),
                onPressed: () {
                  DefaultTabController.of(context)?.animateTo(1);
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Consumer<CartProvider>(
                  builder: (context, cart, child) {
                    return cart.itemCount > 0
                        ? Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 65, 16, 78),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '${cart.itemCount}',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 254, 254, 254),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Container();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 239, 239, 241),
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: const TextStyle(color: Color.fromARGB(255, 27, 24, 24)),
              decoration: InputDecoration(
                hintText: 'Search foods...',
                hintStyle: const TextStyle(color: Color.fromARGB(179, 24, 24, 24)),
                prefixIcon: const Icon(Icons.search, color: Color.fromARGB(179, 21, 21, 21)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 15, 15, 15)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color.fromARGB(137, 26, 26, 26)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 71, 71, 69)),
                ),
                filled: true,
                fillColor: Colors.white10,
              ),
              onChanged: (value) {
                Provider.of<FoodProvider>(context, listen: false)
                    .searchItems(value);
              },
            ),
          ),
          Expanded(
            child: Consumer<FoodProvider>(
              builder: (context, foodProvider, child) {
                final foods = foodProvider.items;
                return GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    final food = foods[index];
                    return Card(
                      elevation: 4,
                      color: const Color.fromARGB(255, 235, 235, 227),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.asset(
                              food.imageUrl,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                height: 120,
                                color: Colors.grey.shade300,
                                child: const Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        food.name,
                                        style: const TextStyle(
                                          color: Color(0xFF2D0C57),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '₹${food.price.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          color: Color(0xFF2D0C57),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                                const Color.fromARGB(255, 254, 157, 2),
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: () {
                                        Provider.of<CartProvider>(context,
                                                listen: false)
                                            .addItem(food);
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                '${food.name} added to cart'),
                                            duration:
                                                const Duration(seconds: 2),
                                            backgroundColor:
                                                const Color.fromARGB(255, 254, 157, 2),
                                            action: SnackBarAction(
                                              label: 'UNDO',
                                              textColor:
                                                  const Color.fromARGB(255, 255, 255, 255),
                                              onPressed: () {
                                                Provider.of<CartProvider>(
                                                        context,
                                                        listen: false)
                                                    .removeSingleItem(food.id);
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text('Add to Cart'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
