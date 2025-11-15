import 'package:flutter/material.dart';
import '../models/product.dart';
import '../service_locator.dart';
import '../models/warehouse_store.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final _store = getIt<WarehouseStore>();

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
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
            IconButton(
              icon: Icon(Icons.remove, size: 20),
              onPressed: () => _updateQuantity(context, product.quantity - 1),
            ),
            Text(
              '${product.quantity}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.add, size: 20),
              onPressed: () => _updateQuantity(context, product.quantity + 1),
            ),
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
      _store.updateQuantity(
        product.id,
        newQuantity,
        'Ручное изменение',
      );
    }
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Удалить товар?'),
          content: Text('Вы уверены, что хотите удалить "${product.name}"? Это действие нельзя отменить.'),
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
                _store.removeProduct(product.id);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Товар "${product.name}" удален'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text('Удалить', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}