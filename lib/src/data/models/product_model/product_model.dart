class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rating;
  final int ratingCount;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.ratingCount,
  });

  factory Product.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Product.empty();
    }

    final ratingJson = json['rating'] as Map<String, dynamic>?;

    return Product(
      id: json['id'] is int ? json['id'] : 0,
      title: (json['title'] ?? 'No title').toString(),
      price: (json['price'] is num) ? (json['price'] as num).toDouble() : 0.0,
      description: (json['description'] ?? '').toString(),
      category: (json['category'] ?? 'Unknown').toString(),
      image: (json['image'] ?? '').toString(),
      rating: (ratingJson?['rate'] is num)
          ? (ratingJson!['rate'] as num).toDouble()
          : 0.0,
      ratingCount: (ratingJson?['count'] is int) ? ratingJson!['count'] : 0,
    );
  }

  factory Product.empty() => Product(
    id: 0,
    title: 'No title',
    price: 0,
    description: '',
    category: 'Unknown',
    image: '',
    rating: 0,
    ratingCount: 0,
  );
}
