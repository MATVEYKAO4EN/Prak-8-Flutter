class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  int quantity;
  final String unit;
  final DateTime? expirationDate;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
    required this.unit,
    this.expirationDate,
  });

  Product copyWith({
    String? id,
    String? name,
    String? category,
    double? price,
    int? quantity,
    String? unit,
    DateTime? expirationDate,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      expirationDate: expirationDate ?? this.expirationDate,
    );
  }
}

class StockMovement {
  final String productId;
  final int previousQuantity;
  final int newQuantity;
  final String reason;
  final DateTime timestamp;

  StockMovement({
    required this.productId,
    required this.previousQuantity,
    required this.newQuantity,
    required this.reason,
    required this.timestamp,
  });
}