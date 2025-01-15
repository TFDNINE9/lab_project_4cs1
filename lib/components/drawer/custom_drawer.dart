import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_project_4cs1/components/drawer/controller/drawer_controller.dart';
import 'package:lab_project_4cs1/screens/product/views/product_page.dart';
import '../../../screens/category/views/category_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final DrawerControllerX controller = Get.put(DrawerControllerX());

    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: Obx(() => ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: SizedBox(
                    child: Text(
                      "Lab Flutter 4CS1",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                _buildDrawerItem(
                  icon: Icons.category,
                  text: 'Category',
                  route: CategoryPage.id,
                  controller: controller,
                ),
                _buildDrawerItem(
                  icon: Icons.production_quantity_limits,
                  text: 'Product',
                  route: ProductPage.id,
                  controller: controller,
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required String route,
    required DrawerControllerX controller,
  }) {
    bool isSelected = controller.selectedRoute.value == route;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Material(
        color: isSelected ? const Color(0xFF6686f6) : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        child: ListTile(
          splashColor: Colors.transparent,
          leading: Icon(icon, color: isSelected ? Colors.white : Colors.black),
          title: Text(
            text,
            style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onTap: () {
            if (route != controller.selectedRoute.value) {
              controller.updateRoute(route);
              Future.delayed(const Duration(milliseconds: 200), () {
                Get.offNamed(route);
              });
            }
          },
        ),
      ),
    );
  }
}
