import 'package:flutter/material.dart';
import 'package:lab_project_4cs1/components/custom_scaffold.dart';

class ProductPage extends StatelessWidget {
  static String id = "/product";
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      title: "product management",
      body: Center(
        child: Text(
          "product page",
        ),
      ),
    );
  }
}
