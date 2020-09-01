import 'package:MiNotes/ui/colors/colors.dart';
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
  Widget todoType(type, IconData icon) {
    Color backgroundColor;
    if (type == "Work")
      backgroundColor = AppColors.workColor.withOpacity(0.5);
    else if (type == "Finance")
      backgroundColor = AppColors.financeColor.withOpacity(0.5);
    else if (type == "Travel")
      backgroundColor = AppColors.travelColor.withOpacity(0.5);
    else if (type == "Study")
      backgroundColor = AppColors.studyColor.withOpacity(0.5);
    else if (type == "Personal")
      backgroundColor = AppColors.personalColor.withOpacity(0.5);
    else
      backgroundColor = AppColors.familyColor.withOpacity(0.5);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/newnote", arguments: {
              "color": backgroundColor.toString(),
              "type": type,
              "isNew": true
            });
          },
          child: Container(
            width: 145.0,
            height: 160.0,
            // padding: EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: Colors.white),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      type,
                      style: TextStyle(fontSize: 20.0),
                    )
                  ],
                )
              ],
            )),
          ),
        )
      ],
    );
  }

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
                  todoType("Work", Icons.work),
                  SizedBox(
                    width: 20.0,
                  ),
                  todoType("Finance", Icons.credit_card),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  todoType("Travel", Icons.airplanemode_active),
                  SizedBox(
                    width: 20.0,
                  ),
                  todoType("Study", Icons.library_books),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  todoType("Personal", Icons.person),
                  SizedBox(
                    width: 20.0,
                  ),
                  todoType("Family", Icons.people),
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
                        onPressed: () {},
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
