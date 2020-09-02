import 'package:MiNotes/ui/colors/colors.dart';
import 'package:MiNotes/ui/size_config/size_config.dart';
import 'package:MiNotes/widgets/note_tile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel {
  @HiveField(0)
  String color;
  @HiveField(1)
  String type;
  @HiveField(2)
  String text;
  @HiveField(3)
  String title;
  @HiveField(4)
  bool isNew;
  @HiveField(5)
  int key;

  NoteModel(
      {this.title, this.type, this.text, this.color, this.isNew, this.key});

  Box<NoteModel> noteBox;
  intializeNotes() async {
    noteBox = await Hive.box<NoteModel>("notes");
  }

  addNew(NoteModel note) async {
    noteBox = await Hive.box<NoteModel>("notes");
    note.isNew ? noteBox.add(note) : noteBox.put(note.key, note);
  }

  Widget allNotes(context) {
    noteBox = Hive.box<NoteModel>("notes");
    return ValueListenableBuilder(
        valueListenable: noteBox.listenable(),
        builder: (context, Box<NoteModel> notes, _) {
          List keys = notes.keys.cast<int>().toList();
          keys.sort((b, a) {
            return a.compareTo(b);
          });
          //delete confirmation snackbar
          return ListView.separated(
              itemBuilder: (_, index) {
                SvgPicture image;
                final key = keys[index];

                //shoe note delete confirmation
                final dialog = AlertDialog(
                  title: Text(
                    "Delete note?",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  ),
                  content: Text(noteBox.get(key).title,
                      style:
                          TextStyle(color: Colors.grey[700], fontSize: 18.0)),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("No",
                            style:
                                TextStyle(color: Colors.blue, fontSize: 20.0))),
                    FlatButton(
                        onPressed: () {
                          this.noteBox.delete(key);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ))
                  ],
                );

                final NoteModel note = notes.get(key);
                if (note.type == "Work")
                  image = SvgPicture.asset(
                    'assets/work.svg',
                    color: AppColors.workColor.withOpacity(0.5),
                    width: 35.7,
                    height: 25,
                  );
                else if (note.type == "Finance")
                  image = SvgPicture.asset(
                    'assets/finance.svg',
                    width: 35.7,
                    height: 25,
                    color: AppColors.financeColor.withOpacity(0.5),
                  );
                else if (note.type == "Travel")
                  image = SvgPicture.asset(
                    "assets/travel.svg",
                    color: AppColors.travelColor.withOpacity(0.5),
                    width: 35.7,
                    height: 25,
                    alignment: Alignment.center,
                  );
                else if (note.type == "Study")
                  image = SvgPicture.asset(
                    'assets/study.svg',
                    color: AppColors.studyColor.withOpacity(0.5),
                    width: 35.7,
                    height: 25,
                  );
                else if (note.type == "Personal")
                  image = SvgPicture.asset(
                    'assets/personal.svg',
                    color: AppColors.personalColor.withOpacity(0.5),
                    width: 35.7,
                    height: 25,
                  );
                else if (note.type == "Family")
                  image = SvgPicture.asset(
                    'assets/family.svg',
                    color: AppColors.familyColor.withOpacity(0.5),
                    width: 28.7,
                    height: 18,
                  );
                int color;
                note.color != null
                    ? color = int.parse(
                        note.color.split("(0x")[1].split(')')[0],
                        radix: 16)
                    : color = int.parse(
                        "Color(0xFF9E9E9E)".split("(0x")[1].split(')')[0],
                        radix: 16);
                return SingleChildScrollView(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/newnote", arguments: {
                            "title": note.title,
                            "type": note.type,
                            "text": note.text,
                            "color": note.color,
                            "key": key,
                            "isNew": false
                          });
                        },
                        child: notesTile(image, note, dialog, context),),);
              },
              separatorBuilder: (_, index) => Divider(color: Colors.white),
              itemCount: notes.length);
        });
  }
}

