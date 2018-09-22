import 'dart:async';
import './ui/Login.dart';
import './ui/Settings.dart';
import './ui/HomePage.dart';
import './ui/ChangeTime.dart';
import 'package:flutter/material.dart';

import 'package:taeleem_hajar/ui/FireStore.dart';

void main() {
  runApp( MaterialApp(
    home: new Home(),
    routes: <String, WidgetBuilder> { //5
        //7
      }
  ));
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  var drawerIndex = 0;
  var ScafTitle = "الصفحة الرئيسية";
  getIndex(drawerIndex) {
    switch (drawerIndex) {
      case (0):
        return new HomePage();
      case (1):
        return new Login();
      case (2):
        return new Settings();
    }
  }

  var drawerItems = [
    {"DTitle": "الصفحة الرئيسية", "DIcon": Icons.home},
    {"DTitle": "تسجيل الدخول", "DIcon": Icons.vpn_key},
    {"DTitle": "الإعدادات", "DIcon": Icons.settings}
  ];

  @override
  Widget build(BuildContext context) {
    var drawers = <Widget>[new Padding(padding: EdgeInsets.only(top: 30.0))];
    for (var i = 0; i < drawerItems.length; i++) {
      debugPrint(i.toString());
      drawers.add(new ListTile(
          leading: new Icon(drawerItems[i]["DIcon"]),
          title: new Text(drawerItems[i]['DTitle']),
          selected: i == drawerIndex,
          onTap: () {
            debugPrint(context.toString());
            Navigator.pop(context);
            setState(() {
              changeIndex(i, drawerItems[i]['DTitle']);
              getIndex(i);
            });
          }));
    }

    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(ScafTitle),
      ),
      drawer: Drawer(
          child: new Column(children:drawers)),
      body: getIndex(drawerIndex),
    );
      
    dismiss(context) {
    Navigator.of(context).pop();
  }

  
  }
  changeIndex(index, title) {
    drawerIndex = index;
    ScafTitle = title;
  }
  }




/*
Future<void> main() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'test',
    options: const FirebaseOptions(
      googleAppID: '1:46798060175:android:6344c9d3d4ce8234',
      gcmSenderID: '46798060175',
      apiKey: 'AIzaSyBeEehhInPRWPxhp_kORtyYj3zKPFKTvTg',
      projectID: 'taleemhajar',
    ),
  );
  final Firestore firestore = new Firestore(app: app);

  runApp(new MaterialApp(
      title: 'Firestore Example', home: new MyHomePage(firestore: firestore)));
}
*/
