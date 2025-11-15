import 'package:flutter/material.dart';
import '../service_locator.dart';
import 'products_screen.dart';
import 'dashboard_screen.dart';
import '../models/warehouse_store.dart';

class WarehouseApp extends StatefulWidget {
  @override
  _WarehouseAppState createState() => _WarehouseAppState();
}

class _WarehouseAppState extends State<WarehouseApp> {
  int _currentIndex = 0;
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
    return Scaffold(
      body: _currentIndex == 0
          ? ProductsScreen()
          : DashboardScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Товары',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Панель',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _store.onDataChanged = null;
    super.dispose();
  }
}