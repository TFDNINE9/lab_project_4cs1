import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_project_4cs1/components/searchbar/controller/searchable_mixin.dart';
import 'package:lab_project_4cs1/models/unit_model.dart';
import 'package:lab_project_4cs1/services/network_service.dart';

class UnitListController extends GetxController with SearchableMixin<Unit> {
  var isLoading = false.obs;
  final NetworkService nw = NetworkService();

  @override
  void onInit() {
    initializeSearch();
    fetchUnits();
    super.onInit();
  }

  Future<void> fetchUnits() async {
    try {
      isLoading.value = true;
      var res = await nw.get('/api/units');
      if (res.isSuccess) {
        var data = unitFromJson(res.content);
        items.value = data;
        filteredItems.value = data;
        update();
      } else {
        debugPrint("Error fetch unit data res code: ${res.code}");
      }
    } catch (e) {
      debugPrint("Exception caught: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  @override
  void filterItems(String query) {
    filteredItems.value = items
        .where(
            (unit) => unit.unitName.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> deleteUnit(int unitId) async {
    try {
      isLoading.value = true;
      var res = await nw.delete('api/units/$unitId');
      if (res.isSuccess) {
        await fetchUnits();
      } else {
        debugPrint("Error delete unit ${res.code}");
      }
    } catch (e) {
      debugPrint("Exception caught: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
