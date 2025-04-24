class MenuItemModel {
  final String name;
  final String description;
  final double price;
  final String image;
  final bool isVeg;
  final String category;

  const MenuItemModel({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.isVeg,
    required this.category,
  });
}

final List<MenuItemModel> menuItems = [
  MenuItemModel(
    name: 'Paneer Butter Masala',
    description: 'Rich and creamy paneer curry',
    price: 14.99,
    image: 'assets/images/paneer_butter_masala.jpg',
    isVeg: true,
    category: 'Main Course',
  ),
  MenuItemModel(
    name: 'Chicken Tikka Masala',
    description: 'Grilled chicken in spicy curry sauce',
    price: 16.99,
    image: 'assets/images/chicken_tikka.jpg',
    isVeg: false,
    category: 'Main Course',
  ),
  MenuItemModel(
    name: 'Dal Makhani',
    description: 'Creamy black lentils',
    price: 12.99,
    image: 'assets/images/dal_makhani.jpg',
    isVeg: true,
    category: 'Main Course',
  ),
  MenuItemModel(
    name: 'Butter Chicken',
    description: 'Classic creamy chicken curry',
    price: 17.99,
    image: 'assets/images/butter_chicken.jpg',
    isVeg: false,
    category: 'Main Course',
  ),
  MenuItemModel(
    name: 'Veg Spring Rolls',
    description: 'Crispy rolls with vegetable filling',
    price: 8.99,
    image: 'assets/images/spring_rolls.jpg',
    isVeg: true,
    category: 'Starters',
  ),
  MenuItemModel(
    name: 'Chicken 65',
    description: 'Spicy fried chicken',
    price: 10.99,
    image: 'assets/images/chicken_65.jpg',
    isVeg: false,
    category: 'Starters',
  ),
]; 