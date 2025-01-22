import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_project_4cs1/models/category_model.dart';
import 'package:lab_project_4cs1/models/dtos/category_dto.dart';
import 'package:lab_project_4cs1/services/network_service.dart';

class CategoryController extends GetxController {
  NetworkService nw = NetworkService();
  late int id;
  late TextEditingController nameController;

  CategoryController({
    required this.id,
    required this.nameController,
  });

  var category = Rx<Category?>(null);
  var dto = Rx(CategoryDto());
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (id != 0) {
      _loadingCat();
    } else {
      isLoading.value = false;
    }
  }

  Future<void> _loadingCat() async {
    try {
      isLoading.value = true;
      var res = await nw.get('/api/categories/$id');

      if (res.isSuccess) {
        category.value = Category.fromMap(jsonDecode(res.content));
        if (category.value != null) {
          nameController.text = category.value!.categoryName;
          dto.value.categoryName = category.value!.categoryName;
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch category details\nError Code: ${res.code}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint("Exception while fetching category: $e");
      Get.snackbar(
        'Error',
        'An error occurred while loading the category',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<bool> addCat() async {
    try {
      isLoading.value = true;
      String json = dto.value.toJson();
      var res = await nw.postJson("/api/categories", json);

      if (res.isSuccess) {
        Get.back(result: true);
        return true;
      } else {
        Get.snackbar(
          'Error',
          'Failed to add category\nError Code: ${res.code}',
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } catch (e) {
      debugPrint("Exception while adding category: $e");
      Get.snackbar(
        'Error',
        'An error occurred while adding the category',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateCat() async {
    try {
      isLoading.value = true;
      String json = dto.value.toJson();
      var res = await nw.putJson('/api/categories/$id', json);

      if (res.isSuccess) {
        Get.back(result: true);
        return true;
      } else {
        Get.snackbar(
          'Error',
          'Failed to update category\nError Code: ${res.code}',
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } catch (e) {
      debugPrint("Exception while updating category: $e");
      Get.snackbar(
        'Error',
        'An error occurred while updating the category',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
