import 'product.dart';

class Order {
  Product product;
  int qty = 1;
  double price;

  Order({this.product, this.qty, this.price});
}
