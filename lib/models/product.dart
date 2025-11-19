class Product {
  final String id;
  final String name;
  final String brand;
  final int price;
  final String description;
  final String? thumbnail;
  final String category;
  final int stock;
  final bool isFeatured;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? ownerId;
  final String? ownerUsername;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.stock,
    required this.isFeatured,
    required this.createdAt,
    required this.updatedAt,
    required this.ownerId,
    required this.ownerUsername,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      thumbnail: json['thumbnail'] as String?,
      category: json['category'] as String,
      stock: json['stock'] as int,
      isFeatured: json['is_featured'] as bool,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      ownerId: json['user_id']?.toString(),
      ownerUsername: json['user_username'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'price': price,
      'description': description,
      'thumbnail': thumbnail,
      'category': category,
      'stock': stock,
      'is_featured': isFeatured,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'user_id': ownerId,
      'user_username': ownerUsername,
    };
  }
}
