import 'package:flutter/material.dart';
import '../service_locator.dart';
import '../widgets/product_card.dart';
import '../widgets/add_product_dialog.dart';
import '../models/warehouse_store.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _store = getIt<WarehouseStore>();

  @override
  void initState() {
    super.initState();
    _store.onDataChanged = _updateState;
  }

  void _updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = _store.products;

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

          return Dismissible(
            key: Key(product.id),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Удалить товар?'),
                    content: Text('Удалить "${product.name}"?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('Отмена'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('Удалить', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  );
                },
              );
            },
            onDismissed: (direction) {
              _store.removeProduct(product.id);
            },
            child: ProductCard(product: product),
          );
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

  @override
  void dispose() {
    _store.onDataChanged = null;
    super.dispose();
  }
}