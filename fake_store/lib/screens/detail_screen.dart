import 'package:fake_store/model/user_model.dart';
import 'package:fake_store/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/barang.dart';
import '../provider/barang_counter.dart';
import '../provider/cart_provider.dart';
import 'cart_screen.dart';

class DetailScreen extends StatefulWidget {
  final User user;
  final Products products;
  final int barangCount;

  const DetailScreen({
    super.key,
    required this.products,
    required this.barangCount,
    required this.user,
  });

  @override
  State<StatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double? get price => null;

  void addToCart(BuildContext context, BarangCounter barangCounter) {
    if (barangCounter.barangCount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          width: MediaQuery.of(context).size.width * 0.6,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          showCloseIcon: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          content: Text(
            "You haven't added anything!",
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      final cart = context.read<CartProvider>();
      cart.addToCart(widget.products, barangCounter.barangCount);

      barangCounter.reset();
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        showDragHandle: true,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Awesome!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.products.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const Text(
                  'was added to cart, would you like to add more?',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.pop(context);
                          navToCart();
                        },
                        heroTag: 'toCart',
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        elevation: 0,
                        child: Text(
                          'View Cart',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        heroTag: 'pop',
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        elevation: 0,
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
    }
  }

  void navToCart() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CartScreen(user: widget.user)));
  }

  void navToFav() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: IconTheme(
            data: Theme.of(context).iconTheme,
            child: const Icon(
              Icons.arrow_circle_left_rounded,
            ),
          ),
        ),
        actions: [
          Consumer<CartProvider>(builder: (context, cartProvider, child) {
            return IconButton(
              onPressed: () {
                navToCart();
              },
              icon: IconTheme(
                data: Theme.of(context).iconTheme,
                child: Badge(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  label: Text(
                    '${cartProvider.cart.length}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  child: const Icon(
                    Icons.shopping_bag_rounded,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 70),
        child: Column(
          children: [
            Image.network(
              widget.products.image.toString(),
              width: MediaQuery.of(context).size.width,
              height: 250,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.3),
              colorBlendMode: BlendMode.darken,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/Dummy.jpg',
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.3),
                  colorBlendMode: BlendMode.darken,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.products.name.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Spacer(),
                      Text('\$${widget.products.price}',
                          style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Brand : ',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  '${widget.products.brand}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Model : ',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  '${widget.products.model}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Color : ',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  '${widget.products.color}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Category : ',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  '${widget.products.category}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.products.description.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton:
          Consumer<FavoriteProvider>(builder: (context, favProvider, child) {
        return FloatingActionButton(
          onPressed: () {
            if (favProvider.isFavorite(widget.products)) {
              favProvider.removeFavorite(widget.products);
            } else {
              favProvider.addFavorite(widget.products);
            }
          },
          tooltip: 'Add to Favorite',
          child: Icon(
            favProvider.isFavorite(widget.products)
                ? Icons.favorite_rounded
                : Icons.favorite_border_rounded,
            size: 32,
            color: favProvider.isFavorite(widget.products)
                ? Colors.red
                : Colors.grey,
          ),
        );
      }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        color: Theme.of(context).colorScheme.primary,
        height: 70,
        width: MediaQuery.sizeOf(context).width,
        child:
            Consumer<BarangCounter>(builder: (context, barangCounter, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 8),
              FloatingActionButton(
                heroTag: 'a',
                backgroundColor: Theme.of(context).colorScheme.secondary,
                elevation: 0,
                onPressed: () {
                  barangCounter.removeItem(widget.products.price!.toDouble());
                },
                child: Icon(Icons.remove,
                    color: Theme.of(context).colorScheme.onSecondary),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                heroTag: 'b',
                onPressed: () {},
                backgroundColor: Colors.transparent,
                elevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
                child: Text(
                  '${barangCounter.barangCount}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                heroTag: 'c',
                backgroundColor: Theme.of(context).colorScheme.secondary,
                elevation: 0,
                onPressed: () {
                  barangCounter.addItem(widget.products.price!.toDouble());
                },
                child: Icon(Icons.add,
                    color: Theme.of(context).colorScheme.onSecondary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FloatingActionButton(
                  heroTag: 'd',
                  onPressed: () {
                    addToCart(context, barangCounter);
                  },
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                            Text(
                              '\$${barangCounter.sumPrice}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_right_alt_rounded,
                            size: 32,
                            color: Theme.of(context).colorScheme.onSecondary),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
