import 'package:firebase/firebase.dart';

import 'DashBoard.dart';
import '../FirebaseCustom.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';




class Login extends StatefulWidget {
  @override
  _GetLoginState createState() => _GetLoginState();
}

class _GetLoginState extends State<Login> {
  bool ShowLoadingBar = false;
  final key = new GlobalKey<ScaffoldState>();
  String Status = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String an = "Flutter Web";
  var database = fire.database;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: key,
      backgroundColor: Colors.blue[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Card(
              color: Colors.white,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('$an Admin Panel',
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: 400,
                      child:TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_circle),
                            hintText: 'Enter Email'
                        ),
                      ),
                    ),

                    SizedBox(height: 10,),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.vpn_key),
                            hintText: 'Enter Password'
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RaisedButton(
                          onPressed: (){
                            setState(() {
                              ShowLoadingBar = true;
                            });
                            GetLogin(emailController.text, passwordController.text);

                          },
                          color: Colors.blue[900],
                          child: Text('Login',
                            style: TextStyle(
                                color: Colors.white
                            ),),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Visibility(
                      visible: ShowLoadingBar,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        strokeWidth: 5,),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void GetLogin(String Email,String Password){
    if(Email == "" || Password == ""){
      Toast.show("Enter Email/Password", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      setState(() {
        ShowLoadingBar = false;
      });
    }else{
      database.ref("admin").onValue.listen((event) {
        var datasnapshot = event.snapshot;

        String AdminEmail = datasnapshot.child("email").val();
        String AdminPass = datasnapshot.child("password").val();

        if(Email == AdminEmail && Password == AdminPass){
          Toast.show("Login Success", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) =>DashBoard()));
        }else{
          Toast.show("Wrong Email or Password", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
        }
        setState(() {
          ShowLoadingBar = false;
        });
      });
    }

  }
}



