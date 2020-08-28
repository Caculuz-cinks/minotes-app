import 'package:flutter/material.dart';
import 'package:MiNotes/controllers/user.controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import  'package:MiNotes/services/check_connectivity.dart';
import 'package:http/http.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();

}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  //intialize user class
  User user = User();

  userLogin(email, password, context) async{
    Response response = await user.login(email, password, context);
    if(response != null  && response.statusCode != 200){
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.amber,
        body: LoadingOverlay(
          isLoading: _isLoading,
          color: Colors.black,
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: Colors.orange,
            strokeWidth: 5.0,
          ),
          child: SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 70.0),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child:
                        SizedBox(child: Image(
                          image: AssetImage("assets/logo_round.png"),
                        ),height: 150.0,
                        ),
                      ),
                      Center(child: Text("Sign In", style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold
                      ),)),
                      SizedBox(height: 40.0,),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  fontSize: 20.0
                              ),
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red, width: 3.0)
                                ),
                                hintText: "Email address",
                                labelText: "Email",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.amber,width: 3.0)
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide()
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 4.0, color: Colors.amber)
                                )
                              ),
                              validator: (email){
                                return email.length < 10 ? "email cannot be less than 10 characters" : null;
                              },
                            ),
                            SizedBox(height: 20.0,),
                            TextFormField(
                              style: TextStyle(
                                fontSize: 20.0
                              ),
                              obscureText: true,
                              obscuringCharacter: "*",
                              controller: passwordController,
                              maxLength: 16,
                              validator: (password){
                                return password.length < 6 ? "password cannot be less than 6 characters" : null;
                              },
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  labelText: "Password",
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red, width: 3.0)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.amber,width: 3.0)
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 5.0)
                                  )
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              children: [
                                Expanded(
                                    child: RaisedButton.icon(
                                        onPressed: ()async {
                                          if(_formKey.currentState.validate() && await isConnected()){
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            userLogin(emailController.text, passwordController.text, context);
                                          }else{
                                            Fluttertoast.showToast(
                                                msg: "You are offline",
                                                backgroundColor: Colors.red,
                                                webShowClose: true,
                                                gravity: ToastGravity.BOTTOM,
                                                toastLength: Toast.LENGTH_LONG,
                                                fontSize: 20.0
                                            );
                                          }
                                        },
                                        color: Colors.indigo,
                                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12.0),
                                        icon: Icon(Icons.send, color: Colors.white),
                                        label: Text("Sign in", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),))
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Divider(color: Colors.indigo,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: FlatButton(
                                    onPressed: (){
                                      Navigator.pushReplacementNamed(context, "/signup");
                                    },
                                    child: Text("Sign up", style: TextStyle(fontSize: 18.0, color: Colors.indigo),),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
