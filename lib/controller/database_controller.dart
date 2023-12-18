import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app_005/model/note_model.dart';

class DatabaseController extends GetxController {
  final String url = "https://657ea4b93e3f5b189463eb69.mockapi.io/note";

  RxList<NoteModel> notesList = RxList<NoteModel>();

  @override
  void onInit(){
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
}
