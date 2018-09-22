import 'dart:async';
import 'dart:io';
import './ChangeTime.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  var c;
  TextEditingController UserName = new TextEditingController();
  TextEditingController Password = new TextEditingController();
  TextEditingController Time = new TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var index = 0;
  Future<FirebaseUser> _handleSignIn(cont) async {
    FirebaseUser user = await _auth.signInWithEmailAndPassword(
      email: UserName.text,
      password: Password.text,
    );

    debugPrint("signed in " + user.email);
    setState(() {
      index = 1;
    });
    /*
    Navigator.push(
      cont,
      MaterialPageRoute(builder: (context) => changeTime()),
    );
    */
    if (user.providerData.isEmpty) {
      debugPrint("Null email");
    }
  }

  @override
  Widget build(BuildContext context) {
    var form = [
      <Widget>[
        new Container(
            alignment: Alignment.center,
            child: new TextField(
                controller: UserName,
                decoration: InputDecoration(
                    hintText: "إسم المستخدم", icon: Icon(Icons.person)))),
        new Container(
            alignment: Alignment.center,
            child: new TextField(
                obscureText: true,
                controller: Password,
                decoration: InputDecoration(
                    hintText: "كلمة المرور", icon: Icon(Icons.vpn_key)))),
        new Container(
            padding: EdgeInsets.only(top: 20.0, left: 30.0),
            child: new FlatButton(
              child: new Text("تسجيل الدخول"),
              onPressed: () {
                _handleSignIn(context);
              },
              color: Colors.lightBlue,
            ))
      ],
      <Widget>[
        new Container(
            alignment: Alignment.center,
            child: new TextField(
                keyboardType: TextInputType.datetime,
                controller: Time,
                decoration: InputDecoration(
                    hintText: "وقت بدء الدرس", icon: Icon(Icons.watch)))),
        new Container(
            padding: EdgeInsets.only(top: 20.0, left: 30.0),
            child: new FlatButton(
              color: Colors.lightBlue,
                child: new Text("حفظ"),
                onPressed: () {
                  _askedToLead();
                }
                ))
      ]
    ];

    UserName.text = "admin@hajar.bh";
    Password.text = "abc123";

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new ListView(
            padding: EdgeInsets.only(top: 90.0, left: 30.0, right: 30.0),
            children: form[index]));
  }

  _SignIn() {
    debugPrint(UserName.text);
    debugPrint(Password.text);
  }

  _saveTime() {}

  Future<Null> _askedToLead() async {
  return showDialog(
    context: context,
    builder: (context) {
       return new AlertDialog(
        title: new Text('Rewind and remember'),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text('You will never be satisfied.'),
              new Text('You\’re like me. I’m never satisfied.'),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Regret'),
            onPressed: () {
              debugPrint("Regret pressed");
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
 
  );
  } 

}
