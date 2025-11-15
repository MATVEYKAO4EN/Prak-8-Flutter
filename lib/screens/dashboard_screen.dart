import 'package:flutter/material.dart';
import '../service_locator.dart';
import '../models/warehouse_store.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
    final lowStockProducts = _store.getLowStockProducts();
    final totalProducts = _store.totalProductsCount;

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
                  'Всего товаров',
                  totalProducts.toString(),
                  Icons.inventory_2,
                  Colors.blue,
                ),
                SizedBox(width: 16),
                _buildStatCard(
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

  @override
  void dispose() {
    _store.onDataChanged = null;
    super.dispose();
  }
}