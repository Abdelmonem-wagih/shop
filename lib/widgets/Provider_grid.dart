import 'package:Shoop/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:Shoop/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProviderGrid extends StatelessWidget {
  final bool showFav;
  ProviderGrid(this.showFav);
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final products = showFav ? productData.favoriteItems : productData.item;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 3 / 2,
      ),
    );
  }
}
