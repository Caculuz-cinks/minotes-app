import 'package:hive/hive.dart';
import 'package:MiNotes/services/note_model.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:MiNotes/services/user_model.dart';

String token = Hive.box<UserModel>("currentUser").get(0).token;
String user_ref_id = Hive.box<UserModel>("currentUser").get(0).user_ref_id;

var noteBox = Hive.box<NoteModel>("notes");

Future <int> backupNotes()async{
  List <Map> notes = [];
  List noteKeys = await Hive.box<NoteModel>("notes").keys.cast<int>().toList();
  for(int i = 0; i < noteKeys.length; i++){
    var note = noteBox.get(noteKeys[i]);
    notes.add({"title": note.title, "text": note.text, "color": note.color, "type": note.type, "user_ref_id": user_ref_id });
  }
  String url = "https://minotes-api.herokuapp.com/backup";
  if(notes.length > 0){
    Response response = await post(url, headers: {"token": token}, body: {"note": jsonEncode(notes)});
    return response.statusCode;
  }
  else return 400;
}

Future<int> restoreNotes() async{
  await noteBox.clear();
  String url = "https://minotes-api.herokuapp.com/restore";
  Response response = await get(url, headers: { "token": token });

  List userNotes = await jsonDecode(response.body)["data"]["userNotes"];
  print(user_ref_id);
  if(userNotes.length > 0){
    for(int i = 0; i < userNotes.length; i++){
      noteBox.add(NoteModel(
          title: userNotes[i]["title"],
          text: userNotes[i]["text"],
          type: userNotes[i]["type"],
          color: userNotes[i]["color"],
          key: userNotes[i]["key"],
          isNew: true)
      );
    }
    await userNotes.map((note) => {
      noteBox.add(NoteModel(
          title: note["title"],
          type: note["type"],
          color: note["color"],
          key: note["key"],
          isNew: true))
    });
    return response.statusCode;
  }
  else return 400;
}