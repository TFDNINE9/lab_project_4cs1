import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_project_4cs1/models/product_model.dart';
import 'package:lab_project_4cs1/models/dtos/product_dto.dart';
import 'package:lab_project_4cs1/services/network_service.dart';

class ProductController extends GetxController {
  NetworkService nw = NetworkService();
  late int id;
  late TextEditingController nameController;
  late TextEditingController quantityController;
  late TextEditingController priceController;
  late TextEditingController salePriceController;

  ProductController({
    required this.id,
    required this.nameController,
    required this.quantityController,
    required this.priceController,
    required this.salePriceController,
  });

  var product = Rx<Product?>(null);
  var isLoading = false.obs;
  var selectedCategoryId = 0.obs;
  var selectedUnitId = 0.obs;

  @override
  void onInit() {
    if (id != 0) _loadProduct();
    super.onInit();
  }

  _loadProduct() async {
    try {
      isLoading.value = true;
      var res = await nw.get('/api/products/$id');
      if (res.isSuccess) {
        product.value = Product.fromMap(jsonDecode(res.content));

        if (product.value != null) {
          nameController.text = product.value!.productName;
          quantityController.text = product.value!.quantity.toString();
          priceController.text = product.value!.price.toString();
          salePriceController.text = product.value!.salePrice.toString();
          selectedCategoryId.value = product.value!.categoryId;
          selectedUnitId.value = product.value!.unitId;
        }
      } else {
        debugPrint("Error fetching product, res code: ${res.code}");
      }
    } catch (e) {
      debugPrint("Exception from fetch product by id: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<bool> addProduct() async {
    try {
      final dto = ProductDto(
        productName: nameController.text,
        quantity: int.parse(quantityController.text),
        price: int.parse(priceController.text),
        salePrice: int.parse(salePriceController.text),
        categoryId: selectedCategoryId.value,
        unitId: selectedUnitId.value,
      );

      var res = await nw.postJson("/api/products", dto.toJson());
      if (res.isSuccess) {
        Get.back(result: true);
        return true;
      } else {
        Get.snackbar('Error', 'Failed to add product ${res.code}');
        return false;
      }
    } catch (e) {
      debugPrint("Exception caught $e");
      return false;
    }
  }

  Future<bool> updateProduct() async {
    try {
      final dto = ProductDto(
        productName: nameController.text,
        quantity: int.parse(quantityController.text),
        price: int.parse(priceController.text),
        salePrice: int.parse(salePriceController.text),
        categoryId: selectedCategoryId.value,
        unitId: selectedUnitId.value,
      );

      var res = await nw.putJson('/api/products/$id', dto.toJson());
      if (res.isSuccess) {
        Get.back(result: true);
        return true;
      } else {
        Get.snackbar(
            'Error', 'Failed to Update product \nError Code: ${res.code}');
        return false;
      }
    } catch (e) {
      debugPrint("Exception caught $e");
      return false;
    }
  }
}
