import 'package:flutter/material.dart';

import 'model/order.dart';
import 'model/product.dart';
import 'provider/order_notify.dart';

import 'package:provider/provider.dart';
import 'screen_order.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => OrderNotify(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  List<Product> items = [
    Product(
        image:
            'https://upl.stack.com/wp-content/uploads/2015/01/How-to-Build-Your-Meal-Plan-According-to-Body-Type_STACK.jpg',
        name: 'Food & xxx',
        desc: 'Food & xx....',
        price: 2.88),
    Product(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ02o6hJho_3k3Rhbow9IL6pToV1JVqi2OHXFprdFV2GoHJQWEy&usqp=CAU',
        name: 'Food & Wine Magazine',
        desc: 'Food & Wine Magazine....',
        price: 1.88)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food list'),
        actions: <Widget>[
          Stack(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // go to screen order
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScreenOrder(),
                      ),
                    );
                  }),
              Positioned(
                top: 0,
                right: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      context.watch<OrderNotify>().items.length.toString(),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: ListView(
        children: items
            .map((e) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: ProductCard(e),
                ))
            .toList(),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  Product product;

  ProductCard(this.product);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image.network(
          product.image,
          width: 90,
          height: 90,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  product.name,
                  style: TextStyle(fontSize: 18),
                ),
                Text(product.desc),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton.icon(
                        elevation: 0,
                        onPressed: () {
                          var o = Order(
                              product: product, qty: 1, price: product.price);
                          context.read<OrderNotify>().addOrder(o);
                        },
                        icon: Icon(Icons.add),
                        label: Text('Add')),
                    Text(
                      '\$ ${product.price}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff0D5CB9)),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
