import 'package:flutter/material.dart';
import '../models/product.dart';
import '../service_locator.dart';
import '../models/warehouse_store.dart';

class AddProductDialog extends StatefulWidget {
  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  String _category = 'Прочее';
  String _unit = 'шт.';
  final _store = getIt<WarehouseStore>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Добавить товар'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Название товара',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Введите название' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Цена',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) => value!.isEmpty ? 'Введите цену' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Количество',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Введите количество' : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: InputDecoration(
                  labelText: 'Категория',
                  border: OutlineInputBorder(),
                ),
                items: ['Электроника', 'Одежда', 'Продукты', 'Прочее']
                    .map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _category = value!),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _unit,
                decoration: InputDecoration(
                  labelText: 'Единица измерения',
                  border: OutlineInputBorder(),
                ),
                items: ['шт.', 'кг', 'г', 'л', 'м', 'упак.']
                    .map((unit) => DropdownMenuItem(
                  value: unit,
                  child: Text(unit),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _unit = value!),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final product = Product(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: _nameController.text,
                category: _category,
                price: double.parse(_priceController.text),
                quantity: int.parse(_quantityController.text),
                unit: _unit,
              );

              _store.addProduct(product);
              Navigator.pop(context);
            }
          },
          child: Text('Добавить'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }
}