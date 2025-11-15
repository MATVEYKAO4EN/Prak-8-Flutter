import 'product.dart';

class WarehouseStore {
  List<Product> products = [];
  List<StockMovement> movements = [];

  void addProduct(Product product) {
    products.add(product);
  }

  void updateQuantity(String productId, int newQuantity, String reason) {
    final productIndex = products.indexWhere((p) => p.id == productId);
    if (productIndex != -1) {
      final product = products[productIndex];
      final movement = StockMovement(
        productId: productId,
        previousQuantity: product.quantity,
        newQuantity: newQuantity,
        reason: reason,
        timestamp: DateTime.now(),
      );

      products[productIndex] = product.copyWith(quantity: newQuantity);
      movements.add(movement);
    }
  }

  void removeProduct(String productId) {
    products.removeWhere((p) => p.id == productId);

    final movement = StockMovement(
      productId: productId,
      previousQuantity: 0,
      newQuantity: 0,
      reason: 'Товар удален',
      timestamp: DateTime.now(),
    );
    movements.add(movement);
  }

  List<Product> getLowStockProducts() {
    return products.where((product) => product.quantity < 10).toList();
  }

  List<Product> getProductsByCategory(String category) {
    return products.where((product) => product.category == category).toList();
  }

  int get totalProductsCount => products.length;

  int get lowStockProductsCount => getLowStockProducts().length;
}