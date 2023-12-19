import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app_005/controller/database_controller.dart';
import 'package:notes_app_005/model/note_model.dart';

class NoteDetailsPage extends StatelessWidget {
  final NoteModel note;
  const NoteDetailsPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
  final DatabaseController databaseController = Get.put(DatabaseController());
    databaseController.titleDetails.text = note.title.toString();
    databaseController.descriptionDetails.text = note.description.toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'N O T E',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              databaseController.updateNote(note.id!);
            },
            icon:const Icon(
              Icons.check,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
             
              databaseController.deleteNote(note.id!);
            },
            icon:const Icon(
              Icons.delete,
              color: Colors.black,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          TextFormField(
            controller: databaseController.titleDetails,
            decoration: const InputDecoration(
              hintText: "Title",
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: const TextStyle(
              fontSize: 24,
                fontWeight: FontWeight.bold,
            ),
          ),
          TextFormField(
            controller: databaseController.descriptionDetails,
            maxLines: 20,
            decoration: const InputDecoration(
              hintText: "Description",
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: 20,
              ),
            ),
             style: const TextStyle(
              fontSize: 18,
                fontWeight: FontWeight.w400,
            ),
          ),
          
        ]),
      ),
    );
  }
}