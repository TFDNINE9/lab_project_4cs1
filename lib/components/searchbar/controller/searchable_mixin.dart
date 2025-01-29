import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin SearchableMixin<T> on GetxController {
  final searchController = TextEditingController();
  final RxList<T> items = <T>[].obs;
  final RxList<T> filteredItems = <T>[].obs;
  final RxBool isSearching = false.obs;

  void initializeSearch() {
    searchController.addListener(() {
      performSearch(searchController.text);
    });
  }

  void performSearch(String query) {
    if (query.isEmpty) {
      filteredItems.value = items;
      isSearching.value = false;
    } else {
      isSearching.value = true;
      filterItems(query);
    }
  }

  void clearSearch() {
    searchController.clear();
    performSearch('');
  }

  void filterItems(String query);

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
