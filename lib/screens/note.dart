import 'package:MiNotes/ui/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:MiNotes/services/note_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  String _noteTitle, _noteText;
  int color;
  bool canChange = true;

  TextEditingController noteTitleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //get arguments from previous route
    Map data = ModalRoute.of(context).settings.arguments;
    //the below logic makes sure that the text is not reset on rebuild
    canChange
        ? setState(() {
            _noteTitle = data["title"] != null ? data["title"] : data["type"];
            _noteText = data["text"];

            //set  default values of controllers
            noteTitleController.text = _noteTitle;
            noteController.text = _noteText;

            color = int.parse(data["color"].split("(0x")[1].split(')')[0],
                radix: 16);
            canChange = false;
          })
        : null;

    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: noteTitleController,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
          cursorColor: Colors.white,
          textAlign: TextAlign.end,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: Icon(
              Icons.edit,
              color: AppColors.primaryColor,
            ),
            focusColor: Colors.white,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset('assets/back.svg')),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
          child: Column(
            children: [
              Expanded(
                child: TextFormField(
                  controller: noteController,
                  autofocus: false,
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0),
                  maxLines: null,
                  maxLength: 500,
                  decoration: InputDecoration(
                    hintText: "New Note",
                    labelText: data["type"],
                    labelStyle: TextStyle(color: Color(color)),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Divider(
                    color: Colors.grey[400],
                    height: 20.0,
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ButtonTheme(
                      height: 55,
                      child: FlatButton(
                        onPressed: () {
                          NoteModel notemodel = NoteModel();
                          if (noteController.text != null &&
                              noteController.text != "") {
                            final note = NoteModel(
                                title: noteTitleController.text,
                                type: data["type"],
                                text: noteController.text,
                                color: data["color"].toString(),
                                isNew: data["isNew"],
                                key: data["key"]);
                            notemodel.addNew(note);
                            if (note.isNew)
                              return Navigator.pushReplacementNamed(
                                  context, "/allnotes");
                            else
                              Navigator.pop(context);
                          }
                        },
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
                        color: AppColors.primaryColor,
                        child: Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
