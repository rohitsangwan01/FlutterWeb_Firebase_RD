import 'package:flutter/material.dart';
import 'package:flutterweb_firebase/Demo/DashBoard.dart';
import 'package:flutterweb_firebase/Demo/Login.dart';
import 'package:flutterweb_firebase/FirebaseCustom.dart';





void main() {
  FirebaseHelper.initDatabase();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login()
  ));
}