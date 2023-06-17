import 'package:flutter/foundation.dart';
import 'package:proyecto_dam/models/model_carrusel.dart';
import 'package:provider/provider.dart';

class CartModel extends ChangeNotifier {
  List<Carrusel> _items = [];

  List<Carrusel> get items => _items;

  void addItem(Carrusel item, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _items.add(item);
    }
    notifyListeners();
  }
  
   void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void removeItem(Carrusel item) {
    _items.remove(item);
    notifyListeners();
  }

  double get total {
    double sum = 0;
    for (var item in _items) {
      sum += double.parse(item.precio);
    }
    return sum;
  }
}
