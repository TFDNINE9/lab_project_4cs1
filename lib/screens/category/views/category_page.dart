import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lab_project_4cs1/components/custom_card.dart';
import 'package:lab_project_4cs1/components/custom_scaffold.dart';
import 'package:lab_project_4cs1/screens/category/controller/category_list_controller.dart';
import 'package:lab_project_4cs1/screens/category/views/category_edit_dialog.dart';

class CategoryPage extends StatelessWidget {
  static String id = "/category";
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> openDialog(BuildContext context, int catId) => showDialog(
          context: context,
          builder: (context) {
            return CategoryEditDialog(
              catId: catId,
            );
          },
        );

    final catcontroller = Get.put(CategoryListController());

    return CustomScaffold(
      title: "Category Management",
      onTapFloatingButton: () => openDialog(context, 0),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // ignore: deprecated_member_use
            colors: [Colors.blue.withOpacity(0.1), Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Colors.blue),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.mic, color: Colors.blue),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    hintText: "Search categories...",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => catcontroller.fetchCat(),
                  child: Obx(() {
                    if (catcontroller.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      );
                    }

                    if (catcontroller.categories.isEmpty) {
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
                      itemCount: catcontroller.categories.length,
                      itemBuilder: (context, index) {
                        final category = catcontroller.categories[index];
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
                                    catcontroller
                                        .deleteCat(category.categoryId);
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
