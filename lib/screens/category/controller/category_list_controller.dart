import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_project_4cs1/models/category/category_model.dart';
import 'package:lab_project_4cs1/services/network_service.dart';

class CategoryListController extends GetxController {
  var categories = <Category>[].obs;
  var isLoading = false.obs;

  final NetworkService nw = NetworkService();

  @override
  void onInit() {
    fetchCat();
    super.onInit();
  }

  Future<void> fetchCat() async {
    try {
      isLoading.value = true;
      var res = await nw.get('/api/categories');
      if (res.isSuccess) {
        var data = categoryFromJson(res.content);
        categories.value = data;
        update();
        isLoading.value = false;
      } else {
        debugPrint("Error fetch cat data res code: ${res.code}");
        isLoading.value = false;
      }
    } catch (e) {
      debugPrint("Unexception caught: $e");
      isLoading.value = false;
    }
  }
}
