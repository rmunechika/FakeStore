import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double price = 0;
    double sumPrice = 0;
    double serviceFee = 2;

    return Consumer<CartProvider>(builder: (context, value, child) {
      for (var cartModel in value.cart) {
        price = double.parse(cartModel.quantity.toString()) *
            double.parse(cartModel.price.toString());
        sumPrice = price;
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
          actions: [
            IconButton(
                onPressed: () {
                  value.clearCart();
                  setState(() {
                    price = 0;
                    sumPrice = 0;
                  });
                },
                icon: const Row(
                  children: [
                    Text('Clear Cart'),
                    SizedBox(width: 10),
                    Icon(Icons.delete),
                  ],
                ))
          ],
        ),
        body: value.cart.isEmpty
            ? const Center(child: Text('Cart is Empty'))
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: value.cart.length,
                    itemBuilder: (context, index) {
                      final barang = value.cart[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.onSurface,
                                width: 2,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                    image: AssetImage('assets/Dummy.jpg'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            title: Row(children: [
                              Container(
                                width: 230,
                                child: Text(
                                  barang.name.toString(),
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
                                    value.removeItem(value.cart[index]);
                                    if (value.cart.isEmpty) {
                                      price = 0;
                                      sumPrice = 0;
                                      setState(() {});
                                    } else {
                                      context.read<CartProvider>();
                                    }
                                  },
                                  icon: const Icon(Icons.delete_rounded))
                            ]),
                            subtitle: Row(
                              children: [
                                Text('\$${barang.price}'),
                                Spacer(),
                                Text(' x' '${barang.quantity}'),
                                const SizedBox(width: 14),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
        bottomNavigationBar: price == 0
            ? null
            : Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
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
                              Text('IDR ' '$price'),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total Price'),
                              Text('IDR ' '$sumPrice'),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: MaterialButton(
                        onPressed: () {},
                        color: Colors.red,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pay Now',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
      );
    });
  }
}
