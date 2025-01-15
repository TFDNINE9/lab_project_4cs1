import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lab_project_4cs1/components/custom_card.dart';
import 'package:lab_project_4cs1/components/custom_scaffold.dart';
import 'package:lab_project_4cs1/screens/category/views/category_edit_dialog.dart';

class CategoryPage extends StatelessWidget {
  static String id = "/category";
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> openDialog(BuildContext context, String accountId) =>
        showDialog(
          context: context,
          builder: (context) {
            return CategoryEditDialog();
          },
        );

    return CustomScaffold(
      title: "Category Management",
      onTapFloatingButton: () => openDialog(context, ""),
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
                  child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Slidable(
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
                      onPressed: () => openDialog(context, "text-id-cat"),
                    ),
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
