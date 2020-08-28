import 'package:flutter/material.dart';
import 'package:MiNotes/services/note_model.dart';

class ViewNote extends StatefulWidget {
  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  TextEditingController noteTitleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
//          controller: noteTitleController,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
          cursorColor: Colors.white,
          initialValue: data["type"],
          textAlign: TextAlign.end,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            focusColor: Colors.white,
          ),
        ),
        backgroundColor: data["color"],
      ),
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
        child: Column(
          children: [
            Expanded(
              child: TextFormField(
                controller: noteController,
                autofocus: false,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
                maxLines: null,
                maxLength: 500,
                decoration: InputDecoration(
                  hintText: "new note",
                  labelText: data["type"],
                  labelStyle: TextStyle(
                      color: data["color"]
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey[400], height: 20.0,)),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: RaisedButton.icon(onPressed: (){
                      NoteModel note = NoteModel();
                      note.addNew(
                          NoteModel(
                              title: data["type"],
                              type: data["type"],
                              text: noteController.text
                          )
                      );
                      Navigator.pushNamed(context, "/allnotes");
                    }, icon: Icon(
                      Icons.save,
                      color: data["color"],
                    ), label: Text(
                        "Save"),
                      color: Colors.grey[300],
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
