import 'package:flutter/material.dart';
import 'package:lab_project_4cs1/components/custom_button.dart';
import 'package:lab_project_4cs1/components/custom_input.dart';

class CategoryEditDialog extends StatelessWidget {
  final int catId;
  const CategoryEditDialog({super.key, required this.catId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 40,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            CustomInput(
              labelText: 'Name',
              // controller: controller.nameController,
            ),
            const SizedBox(height: 16),
            CustomButton(
              titleButton: 'Add',
              colorButton: Colors.blue,
              height: 40,
              onTap: () {
                // Handle button action
              },
            ),
          ],
        ),
      ),
    );
  }
}
