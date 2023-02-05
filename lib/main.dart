import 'package:flutter/material.dart';
import 'package:notes/Screens/note_screen.dart';
void main() {
  runApp(Notes());
}
class Notes extends StatefulWidget {


  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
          initialRoute: NoteScreen.id,
          routes: {
            NoteScreen.id: (context) => NoteScreen(),
            // LoginScreen.id: (context) => LoginScreen(),
            // RegistrationScreen.id: (context) => RegistrationScreen(),
            // ChatScreen.id: (context) => ChatScreen(),
            // home : MyHomePage()
          }
      );
  }
}


