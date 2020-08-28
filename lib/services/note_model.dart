import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel{
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

  NoteModel({this.title, this.type, this.text, this.color, this.isNew, this.key});

  Box <NoteModel> noteBox;
  intializeNotes()async{
    noteBox = await Hive.box<NoteModel>("notes");
  }

  addNew(NoteModel note)async{
    noteBox = await Hive.box<NoteModel>("notes");
    note.isNew ? noteBox.add(note) : noteBox.put(note.key, note);
  }

  Widget allNotes(context){
    noteBox =  Hive.box<NoteModel>("notes");
    return ValueListenableBuilder(
        valueListenable: noteBox.listenable(),
        builder: (context, Box<NoteModel> notes, _){

          List keys = notes.keys.cast<int>().toList();
          keys.sort((b, a){
            return a.compareTo(b);
          });
          //delete confirmation snackbar
          return ListView.separated(
              itemBuilder: (_, index) {
                IconData noteIcon;
                final key = keys[index];

                //shoe note delete confirmation
                final dialog = AlertDialog(
                  title: Text("Delete note?", style: TextStyle(color: Colors.amber, fontSize: 25.0),),
                  content: Text(noteBox.get(key).title, style: TextStyle(color: Colors.grey[700], fontSize: 18.0)),
                  actions: [
                    FlatButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("No",style: TextStyle(color: Colors.blue, fontSize: 20.0))
                    ),
                    FlatButton(
                        onPressed: (){
                          this.noteBox.delete(key);
                          Navigator.pop(context);
                        },
                        child: Text("Yes", style: TextStyle(color: Colors.red, fontSize: 20.0),)
                    )
                  ],
                );

                final NoteModel note = notes.get(key);
                if(note.type == "Work") noteIcon  = Icons.work;
                else if(note.type  == "Finance") noteIcon  = Icons.credit_card;
                else if(note.type  == "Travel") noteIcon  = Icons.airplanemode_active;
                else if(note.type  == "Study") noteIcon  = Icons.library_books;
                else if(note.type  == "Personal") noteIcon  = Icons.person;
                else if(note.type  == "Family") noteIcon = Icons.people;
                int color;
                note.color != null ? color = int.parse(note.color.split("(0x")[1].split(')')[0], radix: 16) : color =   int.parse("Color(0xFF9E9E9E)".split("(0x")[1].split(')')[0], radix: 16);
                return ListTile(
                  onTap: (){
                    Navigator.pushNamed(context, "/newnote", arguments: {
                      "title": note.title,
                      "type": note.type,
                      "text": note.text,
                      "color": note.color,
                      "key": key,
                      "isNew": false
                    });
                  },
                  leading: Icon(noteIcon,color: Color(color),),
                  trailing: PopupMenuButton(itemBuilder: (context){
                    return [PopupMenuItem(child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        showDialog(context: context, builder: (context){
                          return dialog;
                        });
                      },
                        child: Text("Delete", style: TextStyle(color: Colors.red),)))];
                  }),
                  title: Text(
                      note.title,
                    style: TextStyle(
                      color: Colors.grey
                    ),
                  ),
                  subtitle: Text(
                      note.text,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 19.0
                    ),
                  ),
                );
              },
              separatorBuilder: (_, index)=> Divider(),
              itemCount: notes.length);
        });
  }
}