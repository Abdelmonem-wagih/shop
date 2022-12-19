import 'package:Shoop/providers/product_provider.dart';
import 'package:Shoop/screen/edit_product_screen.dart';
import 'package:Shoop/widgets/appDrawer.dart';
import 'package:Shoop/widgets/user_products_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routName = "/user-products";

  Future<void> _refreshProducts(BuildContext context) async {
    try {
      await Provider.of<ProductProvider>(context, listen: false)
          .fetchAndSetProducts();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products "),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        backgroundColor: Colors.black,
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.item.length,
            itemBuilder: (_, i) => Column(
              children: [
                UserProductsItem(
                  productsData.item[i].id,
                  productsData.item[i].title,
                  productsData.item[i].imageUrl,
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
