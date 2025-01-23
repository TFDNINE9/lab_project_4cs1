// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_project_4cs1/components/custom_button.dart';
import 'package:lab_project_4cs1/components/custom_input.dart';
import 'package:lab_project_4cs1/screens/product/controller/product_controller.dart';
import 'package:lab_project_4cs1/screens/product/controller/product_list_controller.dart';
import 'package:lab_project_4cs1/screens/category/controller/category_list_controller.dart';
import 'package:lab_project_4cs1/screens/unit/controller/unit_list_controller.dart';

class ProductEditDialog extends StatelessWidget {
  final int productId;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController salePriceController = TextEditingController();

  ProductEditDialog({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<ProductController>()) {
      Get.delete<ProductController>();
    }

    var productList = Get.put(ProductListController());
    var categoryList = Get.put(CategoryListController());
    var unitList = Get.put(UnitListController());

    var controller = Get.put(
      ProductController(
        id: productId,
        nameController: nameController,
        quantityController: quantityController,
        priceController: priceController,
        salePriceController: salePriceController,
      ),
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 600),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.blue.withOpacity(0.8)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Obx(() {
              if (controller.isLoading.value) {
                return const SizedBox(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                );
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productId == 0 ? 'Add Product' : 'Edit Product',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 24,
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  CustomInput(
                    labelText: 'Product Name',
                    hintText: 'Enter product name',
                    controller: nameController,
                    borderRadius: 15,
                    borderColor: Colors.blue.withOpacity(0.3),
                    focusedBorderColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    suffixIcon: Icon(
                      Icons.inventory_2_outlined,
                      color: Colors.blue.withOpacity(0.5),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomInput(
                          labelText: 'Quantity',
                          hintText: 'Enter quantity',
                          controller: quantityController,
                          borderRadius: 15,
                          borderColor: Colors.blue.withOpacity(0.3),
                          focusedBorderColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Unit',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: Colors.blue.withOpacity(0.3)),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<int>(
                                    isExpanded: true,
                                    value: controller.selectedUnitId.value == 0
                                        ? null
                                        : controller.selectedUnitId.value,
                                    hint: const Text('Select unit'),
                                    items: unitList.units
                                        .map((unit) => DropdownMenuItem(
                                              value: unit.unitId,
                                              child: Text(unit.unitName),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        controller.selectedUnitId.value = value;
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomInput(
                          labelText: 'Price',
                          hintText: 'Enter price',
                          controller: priceController,
                          borderRadius: 15,
                          borderColor: Colors.blue.withOpacity(0.3),
                          focusedBorderColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomInput(
                          labelText: 'Sale Price',
                          hintText: 'Enter sale price',
                          controller: salePriceController,
                          borderRadius: 15,
                          borderColor: Colors.blue.withOpacity(0.3),
                          focusedBorderColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Category',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border:
                                Border.all(color: Colors.blue.withOpacity(0.3)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              isExpanded: true,
                              value: controller.selectedCategoryId.value == 0
                                  ? null
                                  : controller.selectedCategoryId.value,
                              hint: const Text('Select Category'),
                              items: categoryList.categories
                                  .map((category) => DropdownMenuItem(
                                        value: category.categoryId,
                                        child: Text(category.categoryName),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.selectedCategoryId.value = value;
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    titleButton:
                        productId == 0 ? 'Add Product' : 'Update Product',
                    colorButton: Colors.blue,
                    height: 50,
                    borderRadius: 15,
                    elevation: 2,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    onTap: () async {
                      bool success = productId == 0
                          ? await controller.addProduct()
                          : await controller.updateProduct();
                      if (!success) return;
                      await productList.fetchProducts();
                    },
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
