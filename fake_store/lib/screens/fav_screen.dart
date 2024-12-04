import 'package:fake_store/model/barang.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/barang_counter.dart';
import '../provider/favorite_provider.dart';
import 'detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite',
            style: Theme.of(context).appBarTheme.titleTextStyle),
      ),
      body: Consumer<FavoriteProvider>(builder: (context, favProvider, child) {
        return favProvider.favorites.isEmpty
            ? const Center(
                child: Text(
                  'Favorite is Empty',
                ),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 4.5,
                ),
                itemCount: favProvider.favorites.length,
                itemBuilder: (context, index) {
                  Products product = favProvider.favorites[index];
                  return GestureDetector(
                    onTap: () => navToDetScreen(product),
                    child: Card(
                      color: Theme.of(context).colorScheme.tertiary,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset('assets/Dummy.jpg'),
                              /*
                              CachedNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image: AssetImage('assets/Dummy.jpg'),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              */
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name ?? 'No Name',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
      }),
    );
  }
}
