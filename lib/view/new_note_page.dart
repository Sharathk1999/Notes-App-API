import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app_005/controller/database_controller.dart';

class NewNotePage extends StatelessWidget {
  const NewNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseController databaseController = Get.put(DatabaseController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Note..."),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: (){
              
              databaseController.addNewNote();
              
              
            },
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: (){
              Get.back();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: databaseController.titleController,
              decoration: const InputDecoration(
                labelText: "Title",
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: databaseController.descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Description",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
