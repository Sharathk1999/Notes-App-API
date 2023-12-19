import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app_005/model/note_model.dart';
import 'package:notes_app_005/view/home_page.dart';

class DatabaseController extends GetxController {
  final String url = "https://657ea4b93e3f5b189463eb69.mockapi.io/note";

  RxList<NoteModel> notesList = RxList<NoteModel>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleDetails = TextEditingController();
  TextEditingController descriptionDetails = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getNotes();
  }

  Future<void> getNotes() async {
    try {
      var response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        var notes = jsonDecode(response.body);

        for (var note in notes) {
          notesList.add(NoteModel.fromJson(note));
        }
        log("Fetch notes successful...✅");
      }
    } catch (e) {
      log("Error occurred during fetching the notes...⚠️");
    }
  }

  Future<void> addNewNote() async {
    var newNote = NoteModel(
        title: titleController.text,
        description: descriptionController.text,
        date: DateTime.now().toString(),
        time: "");
    try {
      if (titleController.text.isNotEmpty ||
          descriptionController.text.isNotEmpty) {
        var response = await http.post(
          Uri.parse(url),
          body: jsonEncode(newNote.toJson()),
          headers: {"Content-Type": "application/json"},
        );
        if (response.statusCode == 201) {
          titleController.clear();
          descriptionController.clear();
          log("Post successful");
          Get.snackbar(
            "New Note",
            "Your note added successfully...",
            backgroundColor: Colors.green.withAlpha(
              40,
            ),
          );
          notesList.clear();
          Get.to(() => const HomePage());
          getNotes();
        }
      } else {
        Get.snackbar("Empty Fields", "Bro fill title or description");
      }
    } catch (e) {
      log("Error occurred =>$e");
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      final response = await http.delete(
        Uri.parse("https://657ea4b93e3f5b189463eb69.mockapi.io/note/$noteId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Task successfully deleted
        log("Task with ID '$noteId' deleted successfully...✅");
        Get.snackbar(
          "Note Delete",
          "Your note deleted",
          backgroundColor: Colors.red.withAlpha(
            40,
          ),
        );
        notesList.clear();
        await getNotes();
        Get.to(() => const HomePage());
      }
    } catch (e) {
      log("Error occurred while deleting task: $e");
    }
  }

  Future<void> updateNote(String noteId) async {
    var newUrl = "https://657ea4b93e3f5b189463eb69.mockapi.io/note/$noteId";
    var updatedNote = NoteModel(
      title: titleDetails.text,
      description: descriptionDetails.text,
    );
    try {
        var response = await http.put(
          Uri.parse(newUrl),
          body: jsonEncode(updatedNote.toJson()),
          headers: {"Content-Type": "application/json"},
        );
        if (response.statusCode == 200) {
          log("Put successful");
          Get.snackbar(
            "Update Successful",
            "Your note updated successfully...",
            backgroundColor: Colors.green.withAlpha(
              40,
            ),
          );
          notesList.clear();
          getNotes();
        }
      
    } catch (e) {
      log("Error occurred =>$e");
    }
  }
}
