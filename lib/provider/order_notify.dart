import 'package:flutter/cupertino.dart';
import '../model/order.dart';

class OrderNotify extends ChangeNotifier {
  List<Order> items = [];

  void addOrder(Order order) {
    // check list product in item
    final i = items.indexWhere((e) => e.product == order.product);
    if (i > -1) {
      items[i].qty += order.qty;
    } else {
      this.items.add(order);
    }
    notifyListeners();
  }

  removeOrder(o) {
    items.remove(o);
    notifyListeners();
  }

  decrementQty(order) {
    final i = items.indexWhere((e) => e.product == order.product);
    if (items[i].qty == 1) {
      removeOrder(order);
    } else {
      items[i].qty -= 1;
      notifyListeners();
    }
  }

  incrementQty(order) {
    items[items.indexOf(order)].qty += 1;
    notifyListeners();
  }
}
