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

    final Catcontroller = Get.put(CategoryListController());

    return CustomScaffold(
      title: "Category Management",
      onTapFloatingButton: () => openDialog(context, 0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.mic),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    hintText: "Search...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                height: 5,
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async => Catcontroller.fetchCat(),
                child: Obx(() {
                  if (Catcontroller.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    );
                  }

                  if (Catcontroller.categories.isEmpty) {
                    return Center(
                      child: Text("No Category avilable"),
                    );
                  }

                  return ListView.builder(
                    itemCount: Catcontroller.categories.length,
                    itemBuilder: (context, index) {
                      final category = Catcontroller.categories[index];
                      return Slidable(
                        key: ValueKey(category.categoryId),
                        endActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {},
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: CustomCard(
                          width: 400,
                          height: 95,
                          textBoldtitle: category.categoryName,
                          onPressed: () =>
                              openDialog(context, category.categoryId),
                        ),
                      );
                    },
                  );
                }),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
