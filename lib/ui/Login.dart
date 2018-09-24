import 'dart:async';
import 'dart:io';
import './ChangeTime.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  var c;
  var _visible = true;

  TextEditingController UserName = new TextEditingController();
  TextEditingController Password = new TextEditingController();
  TextEditingController Message = new TextEditingController();
  TextEditingController Time = new TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var index = 0;
  Future<FirebaseUser> _handleSignIn(cont) async {
    
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        index = 2;
      });
      FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: UserName.text,
        password: Password.text,
      );
      return user;
    } else
      Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text("لايوجد اتصال بالانترنت "),
    ));
/*
    setState(() {
      index = 2;
    });
    FirebaseUser user = await _auth.signInWithEmailAndPassword(
      email: UserName.text,
      password: Password.text,
    );
    return user;
*/
    /*
    Navigator.push(
      cont,
      MaterialPageRoute(builder: (context) => changeTime()),
    );
    */
  }

  @override
  Widget build(BuildContext context) {
    var form = [
      //------------------- Login form --------------------
      <Widget>[
        new Container(
            padding: EdgeInsets.only(top: 90.0),
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
                _handleSignIn(context).then((FirebaseUser user) {
                  print(user);
                  if (user.email!="null") {
                    setState(() {
                      index = 1;
                      //_visible = false;
                    });
                  }
                }).catchError((e) => print(e));
              },
              color: Colors.lightBlue,
            )),
      ],
      <Widget>[
        //------------------- Time & notification form --------------------

        new Container(
            margin: EdgeInsets.only(left: 20.0, bottom: 25.0),
            alignment: Alignment.center,
            child: new Text(
              "الوقت",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            )),
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
                  _askedToLead(0,context);
                })),
        new Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 40.0, left: 20.0, bottom: 15.00),
            child: new Text(
              "الاشعارات",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            )),
        new Container(

            //color: Colors.white10,
            padding: EdgeInsets.only(left: 15.0),
            child: new Column(children: [
              new TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 7,
                controller: Message,
                decoration: InputDecoration(
                  hintText:
                      "مثال: يبدأ الدرس الاسبوع القادم الموافق\n 24/9/2018",
                  icon: Icon(Icons.message),
                ),
              )
            ])),
        new Container(
            padding: EdgeInsets.only(top: 25.0, left: 30.0),
            child: new FlatButton(
                color: Colors.lightBlue,
                child: new Text("إرسال الاشعار "),
                onPressed: () {
                  _askedToLead(1,context);
                })),
      ],
      [
        //------------------- Loding screen --------------------
        Container(
          margin: EdgeInsets.only(top: 250.0),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              new Text(" ...يجري تسجيل الدخول يرجى الانتظار"),
              CircularProgressIndicator()
            ],
          ),
        )
      ]
    ];

    UserName.text = "admin@hajar.bh";
    Password.text = "abc123";

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new ListView(
            padding: EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
            children: form[index]));
  }

  _SignIn() {
    debugPrint(UserName.text);
    debugPrint(Password.text);
  }

  _saveTime() {}

  Future<Null> _askedToLead(id,cxt) async {
    var mess ; 

    switch(id){
      case(0):mess="هل تريد حفظ وقت الدرس؟";
      break;
      case(1):
      mess="هل تريد إرسال الاشعار ؟";
    }
    
    return showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(

            title: new Text('حفظ التغيرات',textAlign: TextAlign.right),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  new Text(mess,textAlign: TextAlign.right),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('نعم'),
                onPressed: () {
                   Scaffold.of(cxt).showSnackBar(new SnackBar(
      content: new Text("تم إرسال الاشعار ")));
                  Navigator.of(context).pop();
                },
              ),
               new FlatButton(
                child: new Text('لا'),
                onPressed: () {
                  debugPrint("لا");
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
