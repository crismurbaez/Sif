import 'package:flutter/material.dart';

class ProviderInfo extends ChangeNotifier {
  final List _products = [];

  List get products => _products;

  void setProducts(newproduct) {
    _products.add(newproduct);
    print('products-----------');
    print(products);
  }
}
//MODELOS DE DATOS
// const products = {
//   'id': 1,
//   'code': 0,
//   'category': '',
//   'brand': '',
//   'name': '',
//   'color': '',
//   'waist': '',
//   'descriptions': '',
//   'barcode': 0,
//   'cost_price': 0,
//   'percentageMarkup': 0, ///MODIFICAR
//   'sell_price': 0,
//   'quantity': 0,
//   'unit_mensurement': 0
//   'stock_min': 0,
//   'percentageDiscount': 0 //AGREGAR
// };

// const stockControl = {
//   'id': '',
//   'turnPercent': '',
// };

// const sellPercent = {
//   'id': '',
//   'sellPercent': '',
// };
// const client = {
//   'id': '',
//   'name': '',
//   'cuit': '',
//   'address': '',
//   'phone': '',
//   'email': '',
//   'ri': '',
// };

// const providers = {
//   'id': '',
//   'name': '',
//   'cuit': '',
//   'address': '',
//   'phone': '',
//   'email': '',
// };

// const professionals = {
//   'id': '',
//   'name': '',
//   'cuit': '',
//   'address': '',
//   'phone': '',
//   'email': '',
// };

// const bill = {
//   'id': '',
//   'name': '',
//   'address': '',
//   'cuit': '',
// };
