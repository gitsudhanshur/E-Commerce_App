import 'package:flutter/material.dart';
import 'package:e_commerce_app/components/product_card.dart';
import 'package:e_commerce_app/models/product.dart';

import '../details/details_screen.dart';

class SmartphonesScreen extends StatelessWidget {
  const SmartphonesScreen({super.key});

  static String routeName = "/smartphones";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SmartPhones"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            itemCount: smartphones.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.7,
              mainAxisSpacing: 20,
              crossAxisSpacing: 16,
            ),
            itemBuilder: (context, index) => ProductCard(
              product: smartphones[index],
              onPress: () => Navigator.pushNamed(
                context,
                DetailsScreen.routeName,
                arguments:
                    ProductDetailsArguments(product: smartphones[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}