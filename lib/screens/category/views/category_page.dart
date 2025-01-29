// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lab_project_4cs1/components/custom_card.dart';
import 'package:lab_project_4cs1/components/custom_scaffold.dart';
import 'package:lab_project_4cs1/components/searchbar/custom_search_field.dart';
import 'package:lab_project_4cs1/screens/category/controller/category_list_controller.dart';
import 'package:lab_project_4cs1/screens/category/views/category_edit_dialog.dart';

class CategoryPage extends StatelessWidget {
  static String id = "/category";
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> openDialog(BuildContext context, int catId) => showDialog(
          context: context,
          builder: (context) => CategoryEditDialog(catId: catId),
        );

    final controller = Get.put(CategoryListController());

    return CustomScaffold(
      title: "Category Management",
      onTapFloatingButton: () => openDialog(context, 0),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.withOpacity(0.1), Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              CustomSearchField(
                controller: controller.searchController,
                hintText: "Search categories...",
                onClear: controller.clearSearch,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => controller.fetchCat(),
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      );
                    }

                    final displayedItems = controller.filteredItems;

                    if (displayedItems.isEmpty) {
                      if (controller.isSearching.value) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search_off,
                                  size: 64, color: Colors.grey[400]),
                              const SizedBox(height: 16),
                              Text(
                                "No matching categories found",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.category_outlined,
                                size: 64, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text(
                              "No Categories Available",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Tap the + button to add a new category",
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: 100),
                      itemCount: displayedItems.length,
                      itemBuilder: (context, index) {
                        final category = displayedItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Slidable(
                            key: ValueKey(category.categoryId),
                            endActionPane: ActionPane(
                              motion: const DrawerMotion(),
                              extentRatio: 0.25,
                              children: [
                                CustomSlidableAction(
                                  padding: EdgeInsets.zero,
                                  onPressed: (context) {
                                    controller.deleteCat(category.categoryId);
                                  },
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.red,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                        size: 24,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: Colors.red.shade400,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            child: CustomCard(
                              width: double.infinity,
                              height: 100,
                              textBoldtitle: category.categoryName,
                              textDetailtitle:
                                  "Created at: ${category.createdAt.toString().split(' ')[0]}",
                              textDetailColor: Colors.grey[600]!,
                              onPressed: () =>
                                  openDialog(context, category.categoryId),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
