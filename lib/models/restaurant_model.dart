class RestaurantModel {
  final String name;
  final String image;
  final double rating;
  final String deliveryTime;
  final String deliveryFee;

  const RestaurantModel({
    required this.name,
    required this.image,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
  });
}

final List<RestaurantModel> popularRestaurants = [
  RestaurantModel(
    name: 'Pizza Palace',
    image: 'https://images.unsplash.com/photo-1513104890138-7c749659a591',
    rating: 4.5,
    deliveryTime: '25-35 min',
    deliveryFee: '\$2.99',
  ),
  RestaurantModel(
    name: 'Burger Hub',
    image: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
    rating: 4.3,
    deliveryTime: '20-30 min',
    deliveryFee: '\$1.99',
  ),
  RestaurantModel(
    name: 'Sushi Master',
    image: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c',
    rating: 4.7,
    deliveryTime: '30-40 min',
    deliveryFee: '\$3.99',
  ),
]; 