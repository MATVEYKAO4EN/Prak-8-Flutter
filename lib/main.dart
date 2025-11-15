import 'package:flutter/material.dart';
import 'service_locator.dart';
import 'screens/warehouse_app.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Складской учет',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WarehouseApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}