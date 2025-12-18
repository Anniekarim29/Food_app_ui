class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final String imagePath;
  final List<String> ingredients;
  final int calories;
  final String prepTime;

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.imagePath,
    required this.ingredients,
    required this.calories,
    required this.prepTime,
  });
}

final List<FoodItem> mockFoodItems = [
  FoodItem(
    id: '1',
    name: 'Chicken Biryani',
    description: 'Aromatic basmati rice cooked with tender chicken, exotic spices, and saffron. A classic favorite.',
    price: 12.50,
    rating: 4.9,
    imagePath: 'assets/images/Chicken_biryani-removebg-preview.png',
    ingredients: ['Rice', 'Chicken', 'Saffron', 'Spices', 'Yogurt'],
    calories: 600,
    prepTime: '45 min',
  ),
  FoodItem(
    id: '2',
    name: 'Beef Qorma',
    description: 'Rich and creamy beef curry slow-cooked with yogurt, fried onions, and a blend of traditional spices.',
    price: 15.00,
    rating: 4.8,
    imagePath: 'assets/images/Beef_Qorma-removebg-preview.png',
    ingredients: ['Beef', 'Yogurt', 'Onions', 'Ginger', 'Garlic'],
    calories: 750,
    prepTime: '60 min',
  ),
  FoodItem(
    id: '3',
    name: 'Special Haleem',
    description: 'A wholesome stew of wheat, barley, and lentils slow-cooked with tender beef, garnished with ginger and lemon.',
    price: 10.99,
    rating: 4.9,
    imagePath: 'assets/images/Haleem-removebg-preview.png',
    ingredients: ['Wheat', 'Lentils', 'Beef', 'Ginger', 'Lemon'],
    calories: 550,
    prepTime: '8 hours',
  ),
  FoodItem(
    id: '4',
    name: 'Traditional Mamtu',
    description: 'Steamed dumplings filled with seasoned minced meat and onions, served with yogurt and tomato sauce.',
    price: 14.50,
    rating: 4.7,
    imagePath: 'assets/images/Mamtu-removebg-preview.png',
    ingredients: ['Flour', 'Minced Meat', 'Onions', 'Yogurt', 'Tomato'],
    calories: 400,
    prepTime: '40 min',
  ),
  FoodItem(
    id: '5',
    name: 'Crispy Samosa',
    description: 'Golden-fried pastry pockets filled with spiced potatoes, peas, and aromatic herbs. Served with tangy chutney.',
    price: 4.99,
    rating: 4.8,
    imagePath: 'assets/images/Samosa-removebg-preview.png',
    ingredients: ['Flour', 'Potatoes', 'Peas', 'Cumin', 'Chutney'],
    calories: 260,
    prepTime: '20 min',
  ),
  FoodItem(
    id: '6',
    name: 'Rice & Curry Platter',
    description: 'Tender chicken simmered in a rich, savory curry sauce served alongside fluffy aromatic basmati rice.',
    price: 11.50,
    rating: 4.6,
    imagePath: 'assets/images/rice_and_curry-removebg-preview.png',
    ingredients: ['Chicken', 'Basmati Rice', 'Curry Sauce', 'Spices', 'Herbs'],
    calories: 650,
    prepTime: '35 min',
  ),
];
