import 'dart:convert';
import 'package:Shoop/providers/cart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _order = [];

  List<OrderItem> get order {
    return [..._order];
  }

  Future<void> fetchAndSetOrders() async {
    const url = "https://shop1-product-default-rtdb.firebaseio.com/orders.json";
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extrackedData = json.decode(response.body) as Map<String, dynamic>;
    if (extrackedData == null) {
      return;
    }
    extrackedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData["amount"],
          dateTime: DateTime.parse(orderData["dateTime"]),
          products: (orderData["products"] as List<dynamic>)
              .map((item) => CartItem(
                    id: item["id"],
                    quantity: item["quantity"],
                    price: item["price"],
                    title: item["title"],
                  ))
              .toList(),
        ),
      );
    });

    _order = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = "https://shop1-product-default-rtdb.firebaseio.com/orders.json";
    final timeStamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        "amount": total,
        "dateTime": timeStamp.toIso8601String(),
        "products": cartProducts
            .map((cp) => {
                  "id": cp.id,
                  "title": cp.title,
                  "quantity": cp.quantity,
                  "price": cp.price,
                })
            .toList(),
      }),
    );
    _order.insert(
      0,
      OrderItem(
        id: json.decode(response.body)["name"],
        amount: total,
        dateTime: timeStamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
