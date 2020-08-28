import 'package:flutter/material.dart';
import 'package:MiNotes/services/note.dart';
import 'package:hive/hive.dart';
import 'package:MiNotes/services/note_model.dart';

class AllNotes extends StatefulWidget {
  @override
  _AllNotesState createState() => _AllNotesState();
}

class _AllNotesState extends State<AllNotes> {
  NoteModel noteInstance = NoteModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("All Notes"),
      ),
      body: Container(
        child: noteInstance.allNotes(context),
      ),
    );
  }
}
