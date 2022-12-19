import 'package:Shoop/providers/auth.dart';
import 'package:Shoop/providers/cart.dart';
import 'package:Shoop/providers/order.dart';
import 'package:Shoop/screen/cart_screen.dart';
import 'package:Shoop/screen/edit_product_screen.dart';
import 'package:Shoop/screen/orders_screen.dart';
import 'package:Shoop/screen/product_detail_screen.dart';
import 'package:Shoop/screen/products_overview_screen.dart';
import 'package:Shoop/screen/user_prodcuts_screen.dart';
import 'package:provider/provider.dart';
import 'package:Shoop/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:Shoop/screen/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: ProductProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: "MyShop",
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: "Lato",
          ),
          home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routName: (ctx) => CartScreen(),
            OrderScreen.routName: (ctx) => OrderScreen(),
            UserProductScreen.routName: (ctx) => UserProductScreen(),
            EditProductScreen.routName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
