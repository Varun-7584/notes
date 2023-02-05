import 'package:flutter/material.dart';
import 'package:notes/Screens/note_screen.dart';
import 'package:notes/Services/db_helper.dart';
import 'package:notes/Widgets/note_widget.dart';

import '../Model/note_model.dart';

class Notes extends StatelessWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NoteScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Note>?>(
        future: DbHelper.getAllNotes(),
        builder: (context, AsyncSnapshot<List<Note>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data != null) {
              return ListView.builder(
                itemBuilder: (context, index) => NoteWidget(
                  note: snapshot.data![index],
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NoteScreen(
                                  note: snapshot.data![index],
                                )));
                  },
                  onLongPress: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete the note ? '),
                          actions: [
                            ElevatedButton(
                              onPressed: () async {
                                await DbHelper.delete(snapshot.data![index]);
                                Navigator.pop(context);
                              },
                              child: Text('Yes'),
                            ),

                            ///elevated button for no
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('No'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                itemCount: snapshot.data!.length,
              );
            }
            return const Center(
              child : Text('No Notes Yet '),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
