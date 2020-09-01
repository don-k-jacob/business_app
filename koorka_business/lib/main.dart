import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:koorkabusiness/adminPage.dart';
import 'package:koorkabusiness/clientPage.dart';
import 'package:koorkabusiness/login_page.dart';
import 'package:koorkabusiness/memberPage.dart';

void main()=> runApp(new MyApp());

String username='';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Koorka',
      home: new LoginPage(),
      routes: <String, WidgetBuilder>{
          '/AdminPage' : (BuildContext context)=> new AdminPage(),
          '/ClientPage' : (BuildContext context)=> new ClientPage(username: username,),
          '/LoginPage' : (BuildContext context)=> new LoginPage(),
        },
      );
   }
}

