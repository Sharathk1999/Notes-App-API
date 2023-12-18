
class NoteModel {
  String? title;
  String? description;
  String? date;
  String? time;
  String? id;

  NoteModel({this.title, this.description, this.date, this.time, this.id});

  NoteModel.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    description = json["description"];
    date = json["date"];
    time = json["time"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["description"] = description;
    data["date"] = date;
    data["time"] = time;
    data["id"] = id;
    return data;
  }
}