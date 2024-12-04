import 'package:fake_store/screens/fav_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/barang.dart';
import '../provider/barang_counter.dart';
import '../provider/cart_provider.dart';
import '../provider/scroll_home_provider.dart';
import '../provider/theme_provider.dart';
import 'cart_screen.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final String user;

  const HomeScreen({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          width: MediaQuery.of(context).size.width * 0.5,
          backgroundColor:
              Theme.of(context).colorScheme.secondary.withOpacity(0.8),
          showCloseIcon: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          content: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.green,
                  size: 30,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Welcome ${widget.user} !',
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Provider.of<ScrollProvider>(context, listen: false).loadMoreProducts();
    }
  }

  void navToDetScreen(Products product) {
    final barangCounter = Provider.of<BarangCounter>(context, listen: false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          products: product,
          barangCount: barangCounter.barangCount,
        ),
      ),
    );
  }

  void navToCart() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CartScreen()));
  }

  void navToFav() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FavoriteScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 0,
          iconTheme: Theme.of(context).appBarTheme.iconTheme,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FakeStoreApp',
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
              Row(
                children: [
                  IconTheme(
                    data: Theme.of(context).iconTheme,
                    child: const Icon(
                      Icons.location_on,
                      size: 14,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Jakarta, Indonesia',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              )
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                navToFav();
              },
              tooltip: 'Favorite',
              icon: IconTheme(
                  data: Theme.of(context).iconTheme,
                  child: const Icon(Icons.favorite_rounded)),
              color: Theme.of(context).iconTheme.color,
            ),
            const SizedBox(width: 8),
            Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
              return IconButton(
                  onPressed: () {
                    themeProvider.toggleTheme(
                        themeProvider.themeMode != ThemeMode.light);
                  },
                  tooltip: 'Light/Dark',
                  icon: IconTheme(
                    data: Theme.of(context).iconTheme,
                    child: Icon(
                      themeProvider.themeMode == ThemeMode.light
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                    ),
                  ));
            }),
            const SizedBox(width: 16),
          ],
        ),
        body: Consumer<ScrollProvider>(
          builder: (context, scrollProvider, child) {
            return scrollProvider.isLoading && scrollProvider.products.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(8),
                    child: Stack(
                      children: [
                        GridView.builder(
                          controller: _scrollController,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 4.5,
                          ),
                          itemCount: scrollProvider.products.length,
                          itemBuilder: (context, index) {
                            Products product = scrollProvider.products[index];
                            return GestureDetector(
                              onTap: () => navToDetScreen(product),
                              child: Card(
                                color: Theme.of(context).colorScheme.tertiary,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/Dummy.jpg'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.name ?? 'No Name',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                            const SizedBox(height: 16),
                                            Row(
                                              children: [
                                                const Spacer(),
                                                Text(
                                                  'Price: \$${product.price}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        if (scrollProvider.isLoading)
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ],
                    ),
                  );
          },
        ),
        floatingActionButton: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            return FloatingActionButton(
              onPressed: () {
                navToCart();
              },
              tooltip: 'Cart',
              child: IconTheme(
                data: Theme.of(context).iconTheme,
                child: Stack(
                  children: [
                    const Icon(
                      Icons.shopping_bag_rounded,
                      size: 32,
                    ),
                    if (cartProvider.cart.isNotEmpty)
                      Positioned(
                        right: 0,
                        child: Badge(
                          backgroundColor: Theme.of(context).colorScheme.error,
                          label: Text(
                            '${cartProvider.cart.length}',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
