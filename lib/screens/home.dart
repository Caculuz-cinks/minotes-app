import 'package:flutter/material.dart';
import 'package:MiNotes/services/note_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class CustomPopupMenu{
  String label, route;
  CustomPopupMenu({ this.label, this.route });
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
  initState(){
    super.initState();
    initNotes();
  }

  //create boxes for mitodo types
  Widget todoType(type, IconData icon){
    Color backgroundColor;
    if(type == "Work") backgroundColor  = Colors.green[600];
    else if(type == "Finance") backgroundColor  = Colors.red[600];
    else if(type == "Travel") backgroundColor  = Colors.yellow[900];
    else if(type == "Study") backgroundColor  = Colors.cyan;
    else if(type == "Personal") backgroundColor  = Colors.blue;
    else backgroundColor  = Colors.pinkAccent;
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, "/newnote", arguments: {
              "color": backgroundColor.toString(),
              "type": type,
              "isNew": true
            });
          },
          child: Container(
            width: 150.0,
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            color: backgroundColor,
            child: Center(
                child: Wrap(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                            icon,
                            color: Colors.white
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            type,
                          style: TextStyle(
                            fontSize: 20.0
                          ),
                        )
                      ],
                    )
                  ],
                )
            ),
          ),
        )
      ],
    );
  }

  List <PopupMenuEntry> choices = [PopupMenuItem(child: Text("one"), value: "One",)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("MiNotes"),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, "/profile");
            },icon: Icon(Icons.account_circle, size: 35.0,),),
          PopupMenuButton(itemBuilder: (context){
            return choices.map((item) => PopupMenuItem(
              child: Text("About"),
              value: "About",
              )
            ).toList();
          }, onSelected: (value){
            Navigator.pushNamed(context, "/about");
          },)
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Add new from",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   todoType("Work", Icons.work),
                    SizedBox(width: 8.0,),
                    todoType("Finance", Icons.credit_card),
                  ],
                ),
                SizedBox(height: 8.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    todoType("Travel", Icons.airplanemode_active),
                    SizedBox(width: 8.0,),
                    todoType("Study", Icons.library_books),
                  ],
                ),
                SizedBox(height: 8.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    todoType("Personal", Icons.person),
                    SizedBox(width: 8.0,),
                    todoType("Family",  Icons.people),
                  ],
                ),
                SizedBox(height: 8.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton.icon(
                        onPressed: (){
                          Navigator.pushNamed(context, "/allnotes");
                        },
                      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                        icon: Icon(Icons.remove_red_eye, color: Colors.white,),
                        label: Text(
                          "View All",
                          style: TextStyle(
                              color: Colors.white,
                            fontSize: 20.0
                          ),),
                        color: Colors.indigo,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
