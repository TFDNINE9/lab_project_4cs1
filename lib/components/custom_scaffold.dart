import 'package:flutter/material.dart';
import 'package:lab_project_4cs1/components/drawer/custom_drawer.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final VoidCallback? onTapFloatingButton;

  const CustomScaffold(
      {super.key,
      required this.body,
      required this.title,
      this.onTapFloatingButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: FloatingActionButton(
          onPressed: onTapFloatingButton,
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: Colors.blue,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.white,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // later imp
            },
            icon: const Icon(Icons.account_circle),
            color: Colors.white,
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: body,
    );
  }
}
