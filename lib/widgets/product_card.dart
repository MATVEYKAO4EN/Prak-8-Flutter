import 'package:flutter/material.dart';
import '../models/product.dart';
import 'warehouse_inherited_widget.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final warehouse = WarehouseInheritedWidget.of(context);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.inventory_2, color: Colors.blue),
        ),
        title: Text(
          product.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${product.quantity} ${product.unit}'),
            Text('${product.price} руб. • ${product.category}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Кнопка уменьшения количества
            IconButton(
              icon: Icon(Icons.remove, size: 20),
              onPressed: () => _updateQuantity(context, product.quantity - 1),
            ),
            Text(
              '${product.quantity}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // Кнопка увеличения количества
            IconButton(
              icon: Icon(Icons.add, size: 20),
              onPressed: () => _updateQuantity(context, product.quantity + 1),
            ),
            // Кнопка удаления товара
            IconButton(
              icon: Icon(Icons.delete, size: 20, color: Colors.red),
              onPressed: () => _showDeleteConfirmation(context),
            ),
          ],
        ),
      ),
    );
  }

  void _updateQuantity(BuildContext context, int newQuantity) {
    if (newQuantity >= 0) {
      final warehouse = WarehouseInheritedWidget.of(context);
      warehouse.store.updateQuantity(
        product.id,
        newQuantity,
        'Ручное изменение',
      );
      warehouse.updateState();
    }
  }

  // ДОБАВЛЯЕМ МЕТОД ПОДТВЕРЖДЕНИЯ УДАЛЕНИЯ
  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Удалить товар?'),
          content: Text('Вы уверены, что хотите удалить "${product
              .name}"? Это действие нельзя отменить.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Отмена'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                _deleteProduct(context);
                Navigator.of(context).pop();
              },
              child: Text('Удалить', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _deleteProduct(BuildContext context) {
    final warehouse = WarehouseInheritedWidget.of(context);
    warehouse.store.removeProduct(product.id);
    warehouse.updateState();
  }
}