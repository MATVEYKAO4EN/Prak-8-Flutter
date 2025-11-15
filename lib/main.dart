import 'package:flutter/material.dart';
import 'models/warehouse_store.dart';
import 'widgets/warehouse_inherited_widget.dart';
import 'screens/warehouse_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final WarehouseStore _store = WarehouseStore();

  @override
  Widget build(BuildContext context) {
    return WarehouseInheritedWidget(
      store: _store,
      updateState: () {
      },
      child: MaterialApp(
        title: 'Складской учет',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: WarehouseApp(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}