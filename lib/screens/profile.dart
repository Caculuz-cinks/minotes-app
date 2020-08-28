import 'package:flutter/material.dart';
import 'package:MiNotes/services/check_connectivity.dart';
import 'package:MiNotes/services/user_model.dart';
import 'package:hive/hive.dart';
import 'package:MiNotes/controllers/backup.controller.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  bool _isLoading = false;

  //all notes top bar
  Widget topBar(){
    return Container(
      color: Colors.amber,
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      margin: EdgeInsets.all(0),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(
                  Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            Text(
                "Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25.0),)
          ],
        ),
      ),
    );
  }

  var userBox =Hive.box<UserModel>("currentUser").get(0);
  String email, token, name;
  bool isLoggedIn = false;

  //get current user
  getUser(){
    updateUser(){
      email = userBox.email;
      name = userBox.name;
      isLoggedIn = true;
    }
    userBox != null ? updateUser() : email = "You are not logged in";
    userBox != null ? updateUser() : name = "";
    return { "email": email, "token":token, "name":name} ;
  }

  //notes backup
  notesBackupState()async{
    setState(() {
      _isLoading = true;
    });
    var response = await backupNotes();
    setState(() {
      _isLoading = false;
    });
    print(response);
    if(response == 201 || response == 200){
      return Fluttertoast.showToast(
          msg: "Notes backed up successfully",
          backgroundColor: Colors.green,
          gravity: ToastGravity.BOTTOM,
          fontSize: 20.0
      );
    }
      else if(response == 400){
        return Fluttertoast.showToast(
            msg: "Nothing to backup",
            backgroundColor: Colors.red,
            gravity: ToastGravity.BOTTOM,
            fontSize: 20.0
        );
    }
    else{
      Fluttertoast.showToast(
          msg: "Could not backup notes at the moment",
          backgroundColor: Colors.red,
          gravity: ToastGravity.BOTTOM,
          fontSize: 20.0
      );
    }
  }

  //notes restore
  bool canRestore = true;
  notesRestoreState() async{
    if(canRestore){
      setState(() {
        _isLoading = true;
      });
      var response = await restoreNotes();
      setState(() {
        _isLoading = false;
      });
      if(response == 200) {
        Fluttertoast.showToast(
            msg: "Notes restored successfully",
            backgroundColor: Colors.green,
            gravity: ToastGravity.BOTTOM,
            fontSize: 20.0
        );
      }else if(response == 400){
        return Fluttertoast.showToast(
            msg: "nothing to restore",
            backgroundColor: Colors.red,
            gravity: ToastGravity.BOTTOM,
            fontSize: 20.0
        );
      }
      }else{
        Fluttertoast.showToast(
            msg: "Could not restore notes at the moment",
            backgroundColor: Colors.red,
            gravity: ToastGravity.BOTTOM,
            fontSize: 20.0
        );
      }
  }

  //user is not logged in
  notLoggedIn(){
    return Fluttertoast.showToast(
        msg: "You must login first!",
        backgroundColor: Colors.red,
        webShowClose: true,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
        fontSize: 20.0
    );
  }

  //when user is offline
  userOffline(){
    return Fluttertoast.showToast(
        msg: "You are offline",
        backgroundColor: Colors.red,
        webShowClose: true,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
        fontSize: 20.0
    );
  }

  //logout user
  logout()async{
    await Hive.box<UserModel>("currentUser").clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    //signout dialog
    final signOutDialog = AlertDialog(
      title: Text("Sign Out?", style: TextStyle(fontSize: 25.0, color: Colors.amber),),
      content: Text(getUser()["email"]),
      actions: [
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("No",style: TextStyle(color: Colors.blue, fontSize: 20.0))
        ),
        FlatButton(
            onPressed: (){
              logout();
              Navigator.pop(context);
            },
            child: Text("Yes", style: TextStyle(color: Colors.red, fontSize: 20.0),)
        )
      ],
    );

    return Scaffold(
      body: LoadingOverlay(
        isLoading: _isLoading,
        color: Colors.black,
        opacity: 0.5,
        progressIndicator: LinearProgressIndicator(
          backgroundColor: Colors.amber[100],
          semanticsLabel: "Backing up",
          valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
        ),
        child: Container(
          child: Column(
            children: [
              topBar(),
              SizedBox(height: 20.0,),
              Center(
                  child: CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.amber,
                    child: CircleAvatar(
                      child: Icon(Icons.person, size: 70.0,color: Colors.white,),
                      radius: 62.0,
                    ),
                  )
              ),
              SizedBox(height: 10.0,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: (MediaQuery.of(context).size.height) * 0.685
                  ),
                  child: Column(
                    children: [
                      Center(child: Text(getUser()["name"], style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w900, fontSize: 25.0),),),
                      SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(getUser()["email"],
                            style: TextStyle(
                                color: Colors.grey[700]
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0,),
                      RaisedButton.icon(
                          onPressed: () async {
                            if( await isConnected()){
                              if(email !="You are not logged in"){
                                notesBackupState();
                              }
                              else return notLoggedIn();
                            }
                            else return userOffline();
                          },
                          elevation: 10,
                          icon: Icon(Icons.backup),
                          color: Colors.white,
                          label: Text(
                            "Backup now",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey[700]
                            ),)),
                      SizedBox(height: 5.0,),
                      RaisedButton.icon(
                          onPressed: ()async {
                            if( await isConnected()){
                              if(email != "You are not logged in"){
                                notesRestoreState();
                              }
                              else return notLoggedIn();
                            }
                            else return userOffline();
                          },
                          elevation: 10,
                          icon: Icon(Icons.restore),
                          color: Colors.white,
                          label: Text("Restore Backup",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey[700]
                          ),)),
                      SizedBox(height: 20.0,),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Divider(),
                              isLoggedIn ? SizedBox(height: 1.0,) : Expanded(
                                child: FlatButton.icon(
                                  onPressed: (){
                                    Navigator.pushReplacementNamed(context, "/login");
                                  },
                                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
                                  icon: Icon(Icons.person, color: Colors.white),
                                  label: Text("Sign In", style: TextStyle(fontSize: 20.0, color: Colors.white),),
                                  color: Colors.green,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(height: 8.0,),
                              isLoggedIn ? SizedBox(height: 1.0,) : Expanded(
                                child: FlatButton.icon(
                                  onPressed: (){
                                    Navigator.pushReplacementNamed(context, "/signup");
                                  },
                                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
                                  icon: Icon(Icons.person, color: Colors.white),
                                  label: Text("Sign up", style: TextStyle(fontSize: 20.0, color: Colors.white),),
                                  color: Colors.blue,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              isLoggedIn ? Expanded(
                                child: FlatButton.icon(
                                  onPressed: (){
                                    showDialog(context: context, builder: (context)=> signOutDialog);
                                  },
                                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
                                  icon: Icon(Icons.power_settings_new, color: Colors.white),
                                  label: Text("Sign out", style: TextStyle(fontSize: 20.0, color: Colors.white),),
                                  color: Colors.red,
                                ),
                              ) : SizedBox(height: 1.0,)
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
