import 'package:fake_store/model/barang.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navToPayment() {}

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cartProvider, child) {
      double sumPrice = 0;
      double serviceFeeInit = 2;
      double serviceFee = 0;
      double sumPayment = 0;
      for (var cartModel in cartProvider.cart) {
        sumPrice += double.parse(cartModel.quantity.toString()) *
            double.parse(cartModel.price.toString());
      }
      serviceFee = sumPrice + serviceFeeInit;
      sumPayment = sumPrice + serviceFee;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
          actions: [
            IconButton(
              onPressed: () {
                cartProvider.clearCart();
                setState(() {
                  sumPrice = 0;
                  serviceFee = 0;
                  sumPayment = 0;
                });
              },
              icon: Row(
                children: [
                  Text(
                    'Clear Cart',
                    style: Theme.of(context).appBarTheme.titleTextStyle,
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.delete),
                ],
              ),
            ),
          ],
        ),
        body: cartProvider.cart.isEmpty
            ? const Center(child: Text('Cart is Empty'))
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: cartProvider.cart.length,
                  itemBuilder: (context, index) {
                    final product = cartProvider.cart[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onSurface,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'Loading...',
                                image: cartProvider.cart[index].image!,
                                fit: BoxFit.cover,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/Dummy.jpg',
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                          title: Row(
                            children: [
                              Container(
                                width: 230,
                                child: Text(
                                  product.name.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: true,
                                    applyHeightToLastDescent: true,
                                    leadingDistribution:
                                        TextLeadingDistribution.proportional,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  cartProvider
                                      .removeItem(cartProvider.cart[index]);
                                  if (cartProvider.cart.isEmpty) {
                                    setState(() {
                                      sumPrice = 0;
                                      serviceFee = 0;
                                      sumPayment = 0;
                                    });
                                  }
                                },
                                icon: const Icon(Icons.delete_rounded),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text('\$${product.price}'),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  cartProvider.addToCart(
                                    Products(
                                      name: product.name,
                                      price: int.parse(product.price ?? '0'),
                                      image: product.image,
                                    ),
                                    1,
                                  );
                                },
                                icon: const Icon(Icons.add_circle_rounded),
                              ),
                              const SizedBox(width: 8),
                              Text(' x ${product.quantity}'),
                              const SizedBox(width: 8),
                              IconButton(
                                onPressed: () {
                                  cartProvider.decreaseQty(
                                    Products(
                                      name: product.name,
                                      price: int.parse(product.price ?? '0'),
                                      image: product.image,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.remove_circle_rounded),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
        bottomNavigationBar: sumPrice == 0
            ? null
            : Container(
                color: Theme.of(context).colorScheme.surface,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onSurface,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Price'),
                              Text('\$$sumPrice'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Service Fee \$$serviceFeeInit'),
                              Text('\$$serviceFee'),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total Price'),
                              Text('\$$sumPayment'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: MaterialButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isDismissible: false,
                            backgroundColor:
                                Theme.of(context).colorScheme.surfaceContainer,
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.all(16),
                                width: MediaQuery.sizeOf(context).width,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Are you sure ?',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      'Please check properly before proceeding',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: FloatingActionButton(
                                            onPressed: () {},
                                            heroTag: 'unsure',
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            elevation: 0,
                                            child: Text(
                                              'No',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: FloatingActionButton(
                                            onPressed: () {
                                              navToPayment();
                                            },
                                            heroTag: 'pop',
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            elevation: 0,
                                            child: Text(
                                              'Yes',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary,
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
                        },
                        color: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pay Now',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
      );
    });
  }
}
