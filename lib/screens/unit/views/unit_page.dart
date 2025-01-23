// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lab_project_4cs1/components/custom_card.dart';
import 'package:lab_project_4cs1/components/custom_scaffold.dart';
import 'package:lab_project_4cs1/screens/unit/controller/unit_list_controller.dart';
import 'package:lab_project_4cs1/screens/unit/views/unit_edit_dialog.dart';

class UnitPage extends StatelessWidget {
  static String id = "/unit";
  const UnitPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> openDialog(BuildContext context, int unitId) => showDialog(
          context: context,
          builder: (context) => UnitEditDialog(unitId: unitId),
        );

    final unitController = Get.put(UnitListController());

    return CustomScaffold(
      title: "Unit Management",
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
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
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
                    hintText: "Search units...",
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
                  onRefresh: () => unitController.fetchUnits(),
                  child: Obx(() {
                    if (unitController.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      );
                    }

                    if (unitController.units.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.square_foot_outlined,
                                size: 64, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text(
                              "No Units Available",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Tap the + button to add a new unit",
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
                      itemCount: unitController.units.length,
                      itemBuilder: (context, index) {
                        final unit = unitController.units[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Slidable(
                            key: ValueKey(unit.unitId),
                            endActionPane: ActionPane(
                              motion: const DrawerMotion(),
                              extentRatio: 0.25,
                              children: [
                                CustomSlidableAction(
                                  padding: EdgeInsets.zero,
                                  onPressed: (context) {
                                    unitController.deleteUnit(unit.unitId);
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
                              textBoldtitle: unit.unitName,
                              textDetailtitle:
                                  "Created at: ${unit.createdAt.toString().split(' ')[0]}",
                              textDetailColor: Colors.grey[600]!,
                              onPressed: () => openDialog(context, unit.unitId),
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
