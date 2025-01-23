import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_project_4cs1/components/custom_button.dart';
import 'package:lab_project_4cs1/components/custom_input.dart';
import 'package:lab_project_4cs1/models/dtos/unit_dto.dart';
import 'package:lab_project_4cs1/screens/unit/controller/unit_controller.dart';
import 'package:lab_project_4cs1/screens/unit/controller/unit_list_controller.dart';

class UnitEditDialog extends StatelessWidget {
  final int unitId;
  final TextEditingController nameController = TextEditingController();

  UnitEditDialog({super.key, required this.unitId});

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<UnitController>()) {
      Get.delete<UnitController>();
    }
    var unitList = Get.put(UnitListController());

    var controller = Get.put(
      UnitController(
        id: unitId,
        nameController: nameController,
      ),
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
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
                      unitId == 0 ? 'Add Unit' : 'Edit Unit',
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
                  labelText: 'Unit Name',
                  hintText: 'Enter unit name',
                  controller: nameController,
                  borderRadius: 15,
                  borderColor: Colors.blue.withOpacity(0.3),
                  focusedBorderColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  suffixIcon: Icon(
                    Icons.category_outlined,
                    color: Colors.blue.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  titleButton: unitId == 0 ? 'Add Unit' : 'Update Unit',
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
                    controller.dto.value =
                        UnitDto(unitName: nameController.text);
                    bool success = unitId == 0
                        ? await controller.addUnit()
                        : await controller.updateUnit();
                    if (!success) return;
                    await unitList.fetchUnits();
                  },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
