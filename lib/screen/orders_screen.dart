import 'package:Shoop/providers/order.dart' show Orders;
import 'package:Shoop/widgets/appDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Shoop/widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routName = "/orders";

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders "),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text("An error occurred!"),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.order.length,
                  itemBuilder: (ctx, i) => OrderItem(orderData.order[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
