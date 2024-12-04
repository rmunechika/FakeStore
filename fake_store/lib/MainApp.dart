import 'package:fake_store/provider/scroll_home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/barang_counter.dart';
import 'provider/barang_provider.dart';
import 'provider/cart_provider.dart';
import 'provider/favorite_provider.dart';
import 'provider/theme_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BarangProvider()),
        ChangeNotifierProvider(create: (_) => BarangCounter()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProxyProvider<BarangProvider, ScrollProvider>(
          create: (context) => ScrollProvider(
            Provider.of<BarangProvider>(context, listen: false),
          ),
          update: (context, barangProvider, previousScrollProvider) =>
              ScrollProvider(barangProvider),
        ),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'FakeStoreApp',
      theme: themeProvider.lightTheme,
      darkTheme: themeProvider.darkTheme,
      themeMode: themeProvider.themeMode,
      home: SplashScreen(),
    );
  }
}
