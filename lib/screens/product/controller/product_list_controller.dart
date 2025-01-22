import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_project_4cs1/models/product_model.dart';
import 'package:lab_project_4cs1/services/network_service.dart';

class ProductListController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = false.obs;

  final NetworkService nw = NetworkService();

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      var res = await nw.get('/api/products');
      if (res.isSuccess) {
        var data = productFromJson(res.content);
        products.value = data;
        update();
      } else {
        debugPrint("Error fetch products data res code: ${res.code}");
      }
    } catch (e) {
      debugPrint("Exception caught: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteProduct(int productId) async {
    try {
      isLoading.value = true;
      var res = await nw.delete('api/products/$productId');
      if (res.isSuccess) {
        await fetchProducts();
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
