import 'package:flutter/material.dart';
import 'package:flutterproviderfood/provider/order_notify.dart';
import 'package:provider/provider.dart';
import '../model/order.dart';

class OrderCard extends StatelessWidget {
  Order order;

  OrderCard(this.order);
  @override
  Widget build(BuildContext context) {
    final po = Provider.of<OrderNotify>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.network(
          order.product.image,
          width: 90,
          height: 90,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                order.product.name,
                style: TextStyle(fontSize: 20),
              ),
              Text(order.product.desc),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    child: OutlineButton.icon(
                      onPressed: () {
                        po.decrementQty(order);
                      },
                      icon: Icon(Icons.remove),
                      label: Text(''),
                    ),
                  ),
                  Container(
                    width: 40,
                    child: Text(
                      order.qty.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  RaisedButton(
                    child: Icon(Icons.plus_one),
                    onPressed: () {
                      po.incrementQty(order);
                    },
                  ),
                  Expanded(
                    child: Text(
                      '\$ ' + (order.qty * order.price).toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
