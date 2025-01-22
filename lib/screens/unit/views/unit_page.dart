import 'package:flutter/material.dart';
import 'package:lab_project_4cs1/components/custom_scaffold.dart';

class UnitPage extends StatelessWidget {
  const UnitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Unit Mangement",
      body: Center(
        child: Text("Unit Mangement Pages"),
      ),
    );
  }
}
