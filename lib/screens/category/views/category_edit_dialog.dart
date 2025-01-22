import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_project_4cs1/components/custom_button.dart';
import 'package:lab_project_4cs1/components/custom_input.dart';
import 'package:lab_project_4cs1/screens/category/controller/category_controller.dart';
import 'package:lab_project_4cs1/screens/category/controller/category_list_controller.dart';

class CategoryEditDialog extends StatelessWidget {
  final int catId;
  final TextEditingController nameController = TextEditingController();
  CategoryEditDialog({super.key, required this.catId});

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<CategoryController>()) {
      Get.delete<CategoryController>();
    }
    var cList = Get.put(CategoryListController());

    var c = Get.put(
      CategoryController(
        id: catId,
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
            if (c.isLoading.value) {
              return const SizedBox(
                height: 200, // Fixed height for loading state
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
                      catId == 0 ? 'Add Category' : 'Edit Category',
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
                  labelText: 'Category Name',
                  hintText: 'Enter category name',
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
                  titleButton: catId == 0 ? 'Add Category' : 'Update Category',
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
                    c.dto.value.categoryName = nameController.text;
                    bool success =
                        catId == 0 ? await c.addCat() : await c.updateCat();
                    if (!success) return;
                    await cList.fetchCat();
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
