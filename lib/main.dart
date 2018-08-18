import 'package:flutter/material.dart';
import 'package:orarupm/model/Materie.dart';
import 'package:orarupm/model/Specializare.dart';
import 'package:orarupm/database/DBClient.dart';
import 'package:orarupm/ViewSpecializariScreen.dart';
import 'package:orarupm/ViewMateriiScreen.dart';
import 'package:orarupm/AddSpecializareScreen.dart';
import 'package:orarupm/AddMaterieScreen.dart';
import 'dart:async';


//this is our home page
//standard code for creating a page
void main() {
  runApp(new MaterialApp(
    home: new HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
 

 //standard function for building our layout
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Home page'),
        ),
        body: new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new Center(
                child: new Column(
              children: [

                //added a button with a link to AddMaterieScreen
                new Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: new RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddMaterieScreen()),
                      );
                    },
                    child: new Text('Adauga materie'),
                  ),
                ),

                //added a button with a link to ViewMateriiScreen
                new Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: new RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewMateriiScreen()),
                      );
                    },
                    child: new Text('Vezi materii'),
                  ),
                ),

                //added a button with a link to AddSpecializareScreen
                new Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: new RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddSpecializareScreen()),
                      );
                    },
                    child: new Text('Adauga specializare'),
                  ),
                ),
                
                //added a button with a link to ViewSpecializariScreen
                new Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: new RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewSpecializariScreen()),
                      );
                    },
                    child: new Text('Vezi specializari'),
                  ),
                )
              ],
            ))));
  }

}
