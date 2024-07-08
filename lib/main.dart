import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';

import 'routes.dart';
import 'theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: AppTheme.lightTheme(context),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}