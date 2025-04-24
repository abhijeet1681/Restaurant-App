import 'package:flutter/foundation.dart';
import '../models/food_item.dart';

class FoodProvider with ChangeNotifier {
  final List<FoodItem> _items = [
    FoodItem(
      id: '1',
      name: 'Butter Chicken',
      description:
          'Creamy, rich curry with tender chicken pieces in tomato-based sauce',
      price: 499,
      imageUrl: 'assets/images/butterchicken.jpg',
      category: 'Indian Main Course',
    ),
    FoodItem(
      id: '2',
      name: 'Paneer Tikka',
      description: 'Grilled cottage cheese cubes marinated in spiced yogurt',
      price: 399,
      imageUrl: 'assets/images/paneertikka.jpg',
      category: 'Indian Appetizer',
    ),
    FoodItem(
      id: '3',
      name: 'Biryani',
      description:
          'Fragrant basmati rice cooked with aromatic spices and mixed vegetables',
      price: 449,
      imageUrl: 'assets/images/biryani.jpg',
      category: 'Indian Main Course',
    ),
    FoodItem(
      id: '4',
      name: 'Masala Dosa',
      description:
          'Crispy rice crepe filled with spiced potato filling, served with chutneys',
      price: 99,
      imageUrl: 'assets/images/dosa.jpg',
      category: 'Indian Breakfast',
    ),
    FoodItem(
      id: '5',
      name: 'Palak Paneer',
      description: 'Cottage cheese cubes in creamy spinach gravy',
      price: 299,
      imageUrl: 'assets/images/palak-paneer.webp',
      category: 'Indian Main Course',
    ),
    FoodItem(
      id: '6',
      name: 'Samosa',
      description: 'Crispy pastry filled with spiced potatoes and peas',
      price: 99,
      imageUrl: 'assets/images/AlooSamosa.webp',
      category: 'Indian Snacks',
    ),
    FoodItem(
      id: '7',
      name: 'Naan Bread',
      description: 'Soft, buttery flatbread baked in tandoor',
      price: 9,
      imageUrl: 'assets/images/naan.jpg',
      category: 'Indian Bread',
    ),
    FoodItem(
      id: '8',
      name: 'Gulab Jamun',
      description: 'Sweet milk dumplings soaked in sugar syrup',
      price: 19,
      imageUrl: 'assets/images/gulabJamun.jpg',
      category: 'Indian Dessert',
    ),
    FoodItem(
      id: '9',
      name: 'Chicken Tikka',
      description: 'Grilled chicken pieces marinated in spiced yogurt',
      price: 499,
      imageUrl: 'assets/images/chickentikkamasala.jpeg',
      category: 'Indian Appetizer',
    ),
    FoodItem(
      id: '10',
      name: 'Dal Makhani',
      description:
          'Creamy black lentils simmered overnight with butter and spices',
      price: 199,
      imageUrl: 'assets/images/dal-makhani.jpg',
      category: 'Indian Main Course',
    ),
  ];

  List<FoodItem> _filteredItems = [];
  String _searchQuery = '';
  bool _sortByPriceAscending = true;

  List<FoodItem> get items {
    if (_searchQuery.isEmpty) {
      return [..._items];
    }
    return [..._filteredItems];
  }

  void searchItems(String query) {
    _searchQuery = query.toLowerCase();
    _filteredItems = _items
        .where((item) =>
            item.name.toLowerCase().contains(_searchQuery) ||
            item.description.toLowerCase().contains(_searchQuery))
        .toList();
    notifyListeners();
  }

  void toggleSortByPrice() {
    _sortByPriceAscending = !_sortByPriceAscending;
    _items.sort((a, b) => _sortByPriceAscending
        ? a.price.compareTo(b.price)
        : b.price.compareTo(a.price));
    if (_searchQuery.isNotEmpty) {
      _filteredItems.sort((a, b) => _sortByPriceAscending
          ? a.price.compareTo(b.price)
          : b.price.compareTo(a.price));
    }
    notifyListeners();
  }

  bool get isSortedByPriceAscending => _sortByPriceAscending;
}
