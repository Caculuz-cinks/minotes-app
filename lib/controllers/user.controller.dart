import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:http/http.dart';
import 'package:MiNotes/services/user_model.dart';
import 'package:hive/hive.dart';
import 'package:fluttertoast/fluttertoast.dart';

class User {
  String email, name, password;
  User();
  String base_url  = "https://minotes-api.herokuapp.com/";

  Future <Response> login(email, password, context) async{
    Response response = await post(join(base_url, "login"), body: {"email": await email, "password": password});
    var strBody = response.body;
    Map body = jsonDecode(strBody);
    String message = body["message"];

    if(response.statusCode == 200){
      Map data = body["data"]["user"];
      await Hive.box<UserModel>("currentUser").clear();
      await Hive.box<UserModel>("currentUser").add(
          UserModel(name: data["name"], email: data["email"], password: data["password"], token: data["token"], user_ref_id: data["_id"])
      );
      Navigator.pushReplacementNamed(context, "/profile");
    }else{
      print(response.body);
      Fluttertoast.showToast(
          msg: message,
          backgroundColor: Colors.red,
          webShowClose: true,
          gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
        fontSize: 19.0
      );
      return response;
    }
  }

  Future<Response>signup(name, email, password, context) async{
    Response response = await post(join(base_url, "register"), body: {"name": name, "email": await email, "password": password});

    var strBody = response.body;
    Map body = jsonDecode(strBody);
    String message = body["message"];

    if(response.statusCode == 201){
      Map data = body["data"]["user"];
      await Hive.box<UserModel>("currentUser").clear();
      await Hive.box<UserModel>("currentUser").add(
          UserModel(name: data["name"], email: data["email"], password: data["password"], token: data["token"], user_ref_id: data["_id"])
      );
      Navigator.pushReplacementNamed(context, "/profile");
    }else{
      Fluttertoast.showToast(
          msg: message,
          backgroundColor: Colors.red,
          webShowClose: true,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        fontSize: 19.0
      );
      return response;
    }
  }
}