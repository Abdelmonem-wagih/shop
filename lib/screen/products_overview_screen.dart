import 'package:Shoop/providers/cart.dart';
import 'package:Shoop/providers/product_provider.dart';
import 'package:Shoop/screen/cart_screen.dart';
import 'package:Shoop/widgets/Provider_grid.dart';
import 'package:Shoop/widgets/appDrawer.dart';
import 'package:Shoop/widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favorite, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavoritesOnly = false;
  var _isinti = true;
  var _isLoading = false;

  @override
  void initState() {
    //Provider.of<ProductProvider>(context, listen: false).fetchAndSetProducts(); done one solation
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // anthor solation but this is safety
    if (_isinti) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isinti = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyShop"),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selecteValue) {
              setState(
                () {
                  if (selecteValue == FilterOptions.Favorite) {
                    _showFavoritesOnly = true;
                  } else {
                    _showFavoritesOnly = false;
                  }
                },
              );
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Only Favorite "),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text("Show All "),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProviderGrid(_showFavoritesOnly),
    );
  }
}
