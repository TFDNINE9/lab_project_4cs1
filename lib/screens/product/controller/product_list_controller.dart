import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_project_4cs1/components/searchbar/controller/searchable_mixin.dart';
import 'package:lab_project_4cs1/models/product_model.dart';
import 'package:lab_project_4cs1/services/network_service.dart';

class ProductListController extends GetxController
    with SearchableMixin<Product> {
  var isLoading = false.obs;
  final NetworkService nw = NetworkService();

  @override
  void onInit() {
    initializeSearch();
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      var res = await nw.get('/api/products');
      if (res.isSuccess) {
        var data = productFromJson(res.content);
        items.value = data;
        filteredItems.value = data;
        update();
      } else {
        debugPrint("Error fetch product data res code: ${res.code}");
      }
    } catch (e) {
      debugPrint("Exception caught: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void filterItems(String query) {
    filteredItems.value = items
        .where((product) =>
            product.productName.toLowerCase().contains(query.toLowerCase()) ||
            product.category.categoryName
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            product.unit.unitName.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> deleteProduct(int productId) async {
    try {
      isLoading.value = true;
      var res = await nw.delete('api/products/$productId');
      if (res.isSuccess) {
        fetchProducts();
      } else {
        debugPrint("Error delete product ${res.code}");
      }
    } catch (e) {
      debugPrint("Exception caught: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
