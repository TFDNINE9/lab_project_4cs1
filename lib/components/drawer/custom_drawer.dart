// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_project_4cs1/screens/product/views/product_page.dart';
import 'package:lab_project_4cs1/screens/unit/views/unit_page.dart';
import '../../../screens/category/views/category_page.dart';

class CustomDrawer extends GetView<DrawerController> {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DrawerController());

    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[400]!, Colors.blue[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.shopping_cart,
                        size: 40,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Lab Flutter 4CS1",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                children: [
                  _buildDrawerItem(
                    icon: Icons.category_outlined,
                    text: 'Category',
                    route: CategoryPage.id,
                  ),
                  const SizedBox(height: 8),
                  _buildDrawerItem(
                    icon: Icons.inventory_2_outlined,
                    text: 'Product',
                    route: ProductPage.id,
                  ),
                  const SizedBox(height: 8),
                  _buildDrawerItem(
                    icon: Icons.inventory_2_outlined,
                    text: 'Unit',
                    route: UnitPage.id,
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.settings_outlined,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required String route,
  }) {
    return Obx(() {
      final isSelected = controller.currentRoute.value == route;
      return Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                  )
                ]
              : null,
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: isSelected ? Colors.white : Colors.grey[700],
          ),
          title: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[800],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onTap: () {
            controller.updateRoute(route);
            Get.offNamed(route);
          },
        ),
      );
    });
  }
}

class DrawerController extends GetxController {
  final currentRoute = ''.obs;

  void updateRoute(String route) {
    currentRoute.value = route;
  }
}
