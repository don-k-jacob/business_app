import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:koorkabusiness/main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController user=new TextEditingController();
  TextEditingController pass=new TextEditingController();

  String msg='';

  Future<List> _login() async {
    final response = await http.post("http://koorka.in/public/login.php", body: {
      "username": user.text,
      "password": pass.text,
    });

    var datauser = json.decode(response.body);
    print(response.body);

    if(datauser.length==0){
      setState(() {
        msg="Login Fail";
      });
    } else {
      if(datauser["level"]=="client"){
        Navigator.pushReplacementNamed(context, '/ClientPage');
      } else if (datauser["level"]=="admin"){
        Navigator.pushReplacementNamed(context, '/AdminPage');
      }

      setState(() {
        username = datauser["name"];
      });
    }

    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 100.0, 0.0, 0.0),
                  child: Text(
                    'Koorka',
                    style: TextStyle(
                        fontSize: 70.0, fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 180.0, 0.0, 0.0),
                  child: Text(
                    'For Business',
                    style: TextStyle(
                        fontSize: 45.0, fontWeight: FontWeight.bold, color: Colors.greenAccent
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: user,
                  decoration: InputDecoration(
                    hintText: "Email"
                  ),
                ),
                SizedBox(height: 20.0),

                TextField(
                  controller: pass,
                  decoration: InputDecoration(
                    hintText: "Password"
                  ),
                  obscureText: true,
                ),
                Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 15.0, left: 20.0),
                  child: InkWell(
                    child: Text('Forgot Password',
                      style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                Container(
                  height: 50.0,
                  child: Material(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Colors.green,
                    elevation: 7.2,
                    child: GestureDetector(
                      onTap: (){
                        _login();
                        print(pass.text);
                      },
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(msg, style: TextStyle(fontSize: 20.0, color: Colors.red),),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

