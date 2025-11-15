import 'package:flutter/material.dart';
import '../widgets/warehouse_inherited_widget.dart';
import 'products_screen.dart';
import 'dashboard_screen.dart';

class WarehouseApp extends StatefulWidget {
  @override
  _WarehouseAppState createState() => _WarehouseAppState();
}

class _WarehouseAppState extends State<WarehouseApp> {
  int _currentIndex = 0;

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Получаем существующий InheritedWidget
    final existingInherited = WarehouseInheritedWidget.maybeOf(context);

    return WarehouseInheritedWidget(
      store: existingInherited!.store, // Используем существующий store
      updateState: _updateState, // Обновляем callback
      child: Scaffold(
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
      ),
    );
  }
}