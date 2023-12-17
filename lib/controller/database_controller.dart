import 'package:get/get.dart';
import 'package:notes_app_005/model/note_model.dart';

class DatabaseController extends GetxController {
  final String url = "https://657ea4b93e3f5b189463eb69.mockapi.io/note";

  RxList<NoteModel> notesList = RxList<NoteModel>();
}