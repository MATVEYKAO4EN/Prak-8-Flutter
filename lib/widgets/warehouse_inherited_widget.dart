import 'package:flutter/material.dart';
import '../models/warehouse_store.dart';

class WarehouseInheritedWidget extends InheritedWidget {
  final WarehouseStore store;
  final VoidCallback updateState;

  const WarehouseInheritedWidget({
    super.key,
    required super.child,
    required this.store,
    required this.updateState,
  });

  static WarehouseInheritedWidget? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WarehouseInheritedWidget>();
  }

  static WarehouseInheritedWidget of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No WarehouseInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(WarehouseInheritedWidget oldWidget) {
    return store != oldWidget.store;
  }
}