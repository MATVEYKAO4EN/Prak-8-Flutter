import 'package:flutter/material.dart';
import '../widgets/warehouse_inherited_widget.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final warehouse = WarehouseInheritedWidget.of(context);
    final lowStockProducts = warehouse.store.getLowStockProducts();
    final totalProducts = warehouse.store.totalProductsCount;

    return Scaffold(
      appBar: AppBar(title: Text('Панель управления')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                _buildStatCard(
                  context,
                  'Всего товаров',
                  totalProducts.toString(),
                  Icons.inventory_2,
                  Colors.blue,
                ),
                SizedBox(width: 16),
                _buildStatCard(
                  context,
                  'Мало на складе',
                  lowStockProducts.length.toString(),
                  Icons.warning,
                  Colors.orange,
                ),
              ],
            ),
            SizedBox(height: 24),

            Text(
              'Товары с низким запасом:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            if (lowStockProducts.isEmpty)
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Все товары в достаточном количестве',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              )
            else
              ...lowStockProducts.map((product) => Card(
                margin: EdgeInsets.only(bottom: 8),
                color: Colors.orange.shade50,
                child: ListTile(
                  leading: Icon(Icons.warning, color: Colors.orange),
                  title: Text(product.name),
                  subtitle: Text('Осталось: ${product.quantity} ${product.unit}'),
                  trailing: Text(
                    'СРОЧНО ЗАКАЗАТЬ',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              )),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      BuildContext context,
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, size: 40, color: color),
              SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}