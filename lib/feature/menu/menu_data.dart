class FoodItem {
  final String name;
  final String description;
  final double price;
  final double rating;
  final String category;

  const FoodItem({
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
  });
}

final List<FoodItem> menuItems = [
  FoodItem(
    name: 'Classic Burger',
    description: 'Beef burger with cheddar and fries',
    price: 8.99,
    rating: 4.8,
    category: 'Burgers',
  ),

  FoodItem(
    name: 'Double Bacon Burger',
    description: 'Double beef, crispy bacon and BBQ sauce',
    price: 11.49,
    rating: 4.9,
    category: 'Burgers',
  ),

  FoodItem(
    name: 'Margherita Pizza',
    description: 'Tomato sauce, mozzarella and basil',
    price: 9.50,
    rating: 4.7,
    category: 'Pizza',
  ),

  FoodItem(
    name: 'Pepperoni Pizza',
    description: 'Pepperoni, mozzarella and oregano',
    price: 10.99,
    rating: 4.8,
    category: 'Pizza',
  ),

  FoodItem(
    name: 'Chicken Wrap',
    description: 'Grilled chicken with fresh vegetables',
    price: 7.20,
    rating: 4.5,
    category: 'Wraps',
  ),

  FoodItem(
    name: 'Caesar Salad',
    description: 'Chicken, parmesan and caesar dressing',
    price: 6.80,
    rating: 4.4,
    category: 'Salads',
  ),

  FoodItem(
    name: 'Spaghetti Carbonara',
    description: 'Creamy pasta with pancetta and parmesan',
    price: 10.20,
    rating: 4.7,
    category: 'Pasta',
  ),

  FoodItem(
    name: 'Sushi Mix',
    description: 'Fresh salmon and tuna sushi selection',
    price: 14.99,
    rating: 4.9,
    category: 'Sushi',
  ),

  FoodItem(
    name: 'Chocolate Pancakes',
    description: 'Pancakes with chocolate sauce and berries',
    price: 5.90,
    rating: 4.6,
    category: 'Desserts',
  ),

  FoodItem(
    name: 'Ice Coffee',
    description: 'Cold coffee with milk and vanilla syrup',
    price: 3.80,
    rating: 4.5,
    category: 'Drinks',
  ),
];
