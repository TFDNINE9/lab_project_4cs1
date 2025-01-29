import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_project_4cs1/components/searchbar/controller/searchable_mixin.dart';
import 'package:lab_project_4cs1/models/category_model.dart';
import 'package:lab_project_4cs1/services/network_service.dart';

class CategoryListController extends GetxController
    with SearchableMixin<Category> {
  var isLoading = false.obs;
  final NetworkService nw = NetworkService();

  @override
  void onInit() {
    initializeSearch();
    fetchCat();
    super.onInit();
  }

  Future<void> fetchCat() async {
    try {
      isLoading.value = true;
      var res = await nw.get('/api/categories');
      if (res.isSuccess) {
        var data = categoryFromJson(res.content);
        items.value = data;
        filteredItems.value = data;
        update();
      } else {
        debugPrint("Error fetch cat data res code: ${res.code}");
      }
    } catch (e) {
      debugPrint("Unexception caught: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void filterItems(String query) {
    filteredItems.value = items
        .where((category) =>
            category.categoryName.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> deleteCat(int catId) async {
    try {
      isLoading.value = true;
      var res = await nw.delete('api/categories/$catId');
      if (res.isSuccess) {
        debugPrint("success");
        fetchCat();
      } else {
        debugPrint("Error delete cat ${res.code}");
      }
    } catch (e) {
      debugPrint("exception caught: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
