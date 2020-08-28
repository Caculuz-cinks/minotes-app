import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("About"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Image(
                  image: AssetImage("assets/logo_round.png"),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("MiNotes",
                    style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w900
                    ),)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("v1.0.0", style: TextStyle(color: Colors.indigo),)
                ],
              ),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("by", style: TextStyle(color: Colors.indigo),)],
              ),
              SizedBox(height: 5.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Code2geda", style: TextStyle(color: Colors.indigo),)],
              ),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Developers:", style: TextStyle(color: Colors.indigo),)],
              ),
              SizedBox(height: 5.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Micah Elijah", style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),)],)
            ],
          ),
        ),
      ),
    );
  }
}
