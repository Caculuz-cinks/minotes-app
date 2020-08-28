import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:MiNotes/services/note_model.dart';
import 'package:MiNotes/services/user_model.dart';
import 'package:MiNotes/ui/appTheme.dart';
import 'package:MiNotes/screens/note.dart';
import 'package:MiNotes/screens/home.dart';
import 'package:MiNotes/screens/profile.dart';
import 'package:MiNotes/screens/allnotes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:MiNotes/screens/viewnote.dart';
import 'package:MiNotes/screens/login.dart';
import 'package:MiNotes/screens/signup.dart';
import 'package:MiNotes/screens/about.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(join(document.path, "services"));
  Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<NoteModel>("notes");
  await Hive.openBox<UserModel>("currentUser");
  runApp(TodoApp());
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    //prevent display rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => Home(),
        "/newnote": (context) => Todo(),
        "/profile": (context) => Profile(),
        "/allnotes": (context) => AllNotes(),
        "/viewnote": (context) => ViewNote(),
        "/login": (context) => Login(),
        "/signup": (context) => SignUp(),
        "/about": (context) => About()
      },
      theme: primaryTheme,
    );
  }
  @override
  void dispose() {
    super.dispose();
    Hive.box("notes").close();
  }
}
