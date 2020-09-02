import 'package:MiNotes/ui/colors/colors.dart';
import 'package:MiNotes/widgets/todo_type.dart';
import 'package:flutter/material.dart';
import 'package:MiNotes/services/note_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class CustomPopupMenu {
  String label, route;
  CustomPopupMenu({this.label, this.route});
}

class _HomeState extends State<Home> {
  //call the init function i NoteModel
  initNotes() {
    NoteModel noteinstance = NoteModel();
    noteinstance.intializeNotes();
  }

  AlertDialog alert = AlertDialog(
    content: Text("Testing alert"),
    title: Text("About"),
  );

  @override
  initState() {
    super.initState();
    initNotes();
  }

  //create boxes for mitodo types

  List<PopupMenuEntry> choices = [
    PopupMenuItem(
      child: Text("one"),
      value: "One",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffffffff),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/profile");
            },
            child: SvgPicture.asset(
              'assets/profile.svg',
              semanticsLabel: 'profile icon',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0, right: 25.0),
            child: PopupMenuButton(
              child: SvgPicture.asset(
                'assets/options.svg',
                semanticsLabel: 'profile icon',
              ),
              itemBuilder: (context) {
                return choices
                    .map((item) => PopupMenuItem(
                          child: Text("About"),
                          value: "About",
                        ))
                    .toList();
              },
              onSelected: (value) {
                Navigator.pushNamed(context, "/about");
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 55,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MiNotes',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add New ",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  todoType("Work", 'assets/work.svg', context),
                  SizedBox(
                    width: 20.0,
                  ),
                  todoType("Finance", "assets/finance.svg", context),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  todoType("Travel", "assets/travel.svg", context),
                  SizedBox(
                    width: 20.0,
                  ),
                  todoType("Study", "assets/study.svg", context),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  todoType("Personal", "assets/personal.svg", context),
                  SizedBox(
                    width: 20.0,
                  ),
                  todoType("Family", "assets/family.svg", context),
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTheme(
                    height: 55,
                    minWidth: 172,
                    child: FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/allnotes");
                        },
                        color: AppColors.primaryColor,
                        child: Text(
                          'View All',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
