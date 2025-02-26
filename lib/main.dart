import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_project_4cs1/screens/category/controller/category_list_controller.dart';
import 'package:lab_project_4cs1/screens/category/views/category_page.dart';
import 'package:lab_project_4cs1/screens/product/views/product_page.dart';
import 'package:lab_project_4cs1/screens/unit/views/unit_page.dart';

void main() {
  Get.put(CategoryListController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: CategoryPage.id,
      getPages: [
        GetPage(
          name: CategoryPage.id,
          page: () => CategoryPage(),
        ),
        GetPage(
          name: ProductPage.id,
          page: () => ProductPage(),
        ),
        GetPage(
          name: UnitPage.id,
          page: () => UnitPage(),
        ),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
    ),
  );
}
