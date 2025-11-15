import 'product.dart';
import 'package:flutter/material.dart';

class WarehouseStore {
  List<Product> products = [];
  List<StockMovement> movements = [];

  VoidCallback? onDataChanged;

  void addProduct(Product product) {
    products.add(product);
    _notifyListeners();
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
      _notifyListeners();
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
    _notifyListeners();
  }

  void updateProduct(Product updatedProduct) {
    final index = products.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      products[index] = updatedProduct;
      _notifyListeners();
    }
  }

  List<Product> getLowStockProducts() {
    return products.where((product) => product.quantity < 10).toList();
  }

  List<Product> getProductsByCategory(String category) {
    return products.where((product) => product.category == category).toList();
  }

  int get totalProductsCount => products.length;

  int get lowStockProductsCount => getLowStockProducts().length;

  void _notifyListeners() {
    onDataChanged?.call();
  }
}