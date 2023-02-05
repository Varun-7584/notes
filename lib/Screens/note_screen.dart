import 'package:notes/Services/db_helper.dart';

import '';
import 'package:flutter/material.dart';

import '../Model/note_model.dart';

class NoteScreen extends StatelessWidget {
  static const String id = 'note_screen';
  final Note? note;
  const NoteScreen({Key? key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    if (note != null) {
      titleController.text = note!.title;
      descriptionController.text = note!.description;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'Write a note' : 'Edit Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Column(
          children: [
            const Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Center(
                  child: Text(
                'description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40.0),
              child: TextField(
                controller: titleController,
                maxLines: 2,
                decoration: InputDecoration(
                    hintText: 'Title',
                    labelText: 'Note Title',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    )),
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                  hintText: 'Type the note',
                  labelText: 'Note Description',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
              ),
              keyboardType: TextInputType.multiline,
              onChanged: (str){},
              maxLines: 10,
            ),
            const Spacer(),
            Padding(padding: EdgeInsets.only(bottom: 20.0),
            child: SizedBox(
              height: 45.0,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: ()async{
                  final title = titleController.value.text;
                  final description = descriptionController.value.text;

                  if (title.isNotEmpty || description.isEmpty){
                    return ;
                  }
                  
                  final Note model = Note(title: title, description: description , id : note?.id );
                  if (note == null){
                    await DbHelper.addNote(model);
                  }
                  else{
                    await DbHelper.updateNote(model);
                  }
                  Navigator.pop(context);
              }, child: Text(note == null?
              'Save'
                :'Edit Note', style: TextStyle(
                fontSize: 20.0 ,
                fontWeight: FontWeight.bold,
              ),),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      side:BorderSide(
                        color :Colors.white,
                        width: 1.0 ,
                      ),
                      borderRadius: BorderRadius.all(
                       Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),)

          ],
        ),
      ),
    );
  }
}
