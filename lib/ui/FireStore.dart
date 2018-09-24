import 'dart:async';

/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  final Firestore firestore;
  Home({this.firestore});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: FlatButton( child: new Text("Time"),
        onPressed: () { showTimePicker(
        
  initialTime:new TimeOfDay.now(),
  context: context,
        );},
      )
      
      );
  }

  _showSnak(c, id) {
    final S = new SnackBar(
      content: new Text(id),
      duration: Duration(seconds: 1),
    );
    Scaffold.of(c).showSnackBar(S);
  }
}

//----------------Add Message----------------------------------

class MyHomePage extends StatelessWidget {
  MyHomePage({this.firestore});
  final Firestore firestore;
  CollectionReference get messages => firestore.collection('users');

  Future<Null> _addMessage() async {
    final DocumentReference document = messages.document();
    document.setData({
      'ID': 'Hello world!',
    });
  
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home Page"),
      ),
      
    drawer:
     new Drawer(

  // Add a ListView to the drawer. This ensures the user can scroll
  // through the options in the Drawer if there isn't enough vertical
  // space to fit everything.
  child: ListView(
    // Important: Remove any padding from the ListView.
   
    children: <Widget>[
    
      ListTile(
        trailing:  Icon(Icons.home),
        title: Text('Item 1'),
        onTap: () {
          // Update the state of the app
          // ...
        },
      ),
      ListTile(
        title: Text('Item 2'),
        onTap: () {
          // Update the state of the app
          // ...
        },
      ),
    ],
  ),
),
    
    body: new Home(firestore: firestore,),
    );
  }

  
 
}
*/
