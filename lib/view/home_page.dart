import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app_005/controller/database_controller.dart';
import 'package:notes_app_005/view/new_note_page.dart';
import 'package:notes_app_005/view/note_details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseController databaseController = Get.put(DatabaseController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "N O T E S",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Obx(
        () => Visibility(
          visible: databaseController.notesList.isNotEmpty,
          replacement:const Center(
            child: Text("No Notes yet man..! \n add some.."),
          ),
          child: GridView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: databaseController.notesList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(()=>NoteDetailsPage(note: databaseController.notesList[index],),);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withAlpha(50),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              databaseController.notesList[index].title!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              databaseController.notesList[index].description!,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewNotePage(),
            ),
          );
        },
        child: const Icon(
          Icons.add_circle_rounded,
          color: Colors.black,
        ),
      ),
    );
  }
}
