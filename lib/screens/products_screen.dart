import 'package:flutter/material.dart';
import '../widgets/warehouse_inherited_widget.dart';
import '../widgets/product_card.dart';
import '../widgets/add_product_dialog.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final warehouse = WarehouseInheritedWidget.of(context);
    final products = warehouse.store.products;

    return Scaffold(
      appBar: AppBar(
        title: Text('Товары на складе'),
      ),
      body: products.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Нет товаров',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Добавьте первый товар',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(product: product);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProductDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddProductDialog(),
    );
  }
}