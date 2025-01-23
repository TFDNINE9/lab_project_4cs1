import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_project_4cs1/models/unit_model.dart';
import 'package:lab_project_4cs1/models/dtos/unit_dto.dart';
import 'package:lab_project_4cs1/services/network_service.dart';

class UnitController extends GetxController {
  NetworkService nw = NetworkService();
  late int id;
  late TextEditingController nameController;

  UnitController({
    required this.id,
    required this.nameController,
  });

  var unit = Rx<Unit?>(null);
  var dto = Rx<UnitDto?>(null);
  var isLoading = false.obs;

  @override
  void onInit() {
    _loadingUnit();
    super.onInit();
  }

  _loadingUnit() async {
    try {
      isLoading.value = true;
      var res = await nw.get('/api/units/$id');
      if (res.isSuccess) {
        unit.value = Unit.fromMap(jsonDecode(res.content));
      } else {
        debugPrint("Error fetching unit id, res code: ${res.code}");
      }

      if (unit.value != null) {
        nameController.text = unit.value!.unitName;
        dto.value = UnitDto(unitName: unit.value!.unitName);
      }
      isLoading.value = false;
      update();
    } catch (e) {
      debugPrint("Exception from fetch unit by id: $e");
      isLoading.value = false;
    }
  }

  Future<bool> addUnit() async {
    try {
      if (dto.value == null) return false;
      String json = dto.value!.toJson();
      var res = await nw.postJson("/api/units", json);
      if (res.isSuccess) {
        Get.back(result: true);
        return true;
      }
      Get.snackbar('Error', 'Failed to add unit ${res.code}');
      return false;
    } catch (e) {
      debugPrint("Exception caught $e");
      return false;
    }
  }

  Future<bool> updateUnit() async {
    try {
      if (dto.value == null) return false;
      String json = dto.value!.toJson();
      var res = await nw.putJson('/api/units/$id', json);
      if (res.isSuccess) {
        Get.back(result: true);
        return true;
      }
      Get.snackbar('Error', 'Failed to Update unit \nError Code: ${res.code}');
      return false;
    } catch (e) {
      debugPrint("Exception caught $e");
      return false;
    }
  }
}
