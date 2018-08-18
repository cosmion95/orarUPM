import 'package:flutter/material.dart';
import 'package:orarupm/model/Materie.dart';
import 'package:orarupm/model/Specializare.dart';
import 'package:orarupm/database/DBClient.dart';
import 'package:orarupm/ViewSpecializariScreen.dart';
import 'package:orarupm/ViewMateriiScreen.dart';
import 'dart:async';

//this is the screen from where we can add new objects of type Materie to our database, in the materie table
class AddMaterieScreen extends StatefulWidget {
  @override
  AddMaterieScreenPageState createState() => new AddMaterieScreenPageState();
}

class AddMaterieScreenPageState extends State<AddMaterieScreen> {

  //using text controllers to retrieve the values of the text fields
  final numeController = TextEditingController();
  final codSpecializareController = TextEditingController();
  final tipController = TextEditingController();
  final anController = TextEditingController();
  final saptamanaController = TextEditingController();
  final ziuaController = TextEditingController();
  final grupaController = TextEditingController();
  final perStartController = TextEditingController();
  final perEndController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    numeController.dispose();
    codSpecializareController.dispose();
    tipController.dispose();
    anController.dispose();
    saptamanaController.dispose();
    grupaController.dispose();
    perStartController.dispose();
    perEndController.dispose();
    super.dispose();
  }

//standard build function
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Adauga o Materie'),
        ),
        body: new SingleChildScrollView(
          child:
        new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new Form(
                child: new Column(
              children: [
                //adding all the necesary text input fields to create a Materie object
                //this includes everything except for the id, as that will be given automatically when we add the object to the database
                new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(labelText: 'Nume'),
                  controller: numeController,
                ),
                new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration:
                      new InputDecoration(labelText: 'Cod specializare'),
                  controller: codSpecializareController,
                ),
                new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration:
                      new InputDecoration(labelText: '1-Curs // 2-Laborator 3-Seminar:'),
                  controller: tipController,
                ),
                new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(labelText: 'An'),
                  controller: anController,
                ),
                new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(labelText: 'Saptamana'),
                  controller: saptamanaController,
                ),
                new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(labelText: 'Ziua'),
                  controller: ziuaController,
                ),
                new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(labelText: 'Grupa'),
                  controller: grupaController,
                ),
                new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(labelText: 'Ora inceput'),
                  controller: perStartController,
                ),
                new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(labelText: 'Ora final'),
                  controller: perEndController,
                ),

                //added a button that calls the function _submit and contains the text 'adauga materie'
                new Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: new RaisedButton(
                    onPressed: _submit,
                    child: new Text('Adauga Materie'),
                  ),
                ),

                //added a button with a link to the ViewMateriiScreen
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
                )
              ],
            )))));
    
  }


//this function retrieves the values of all the text fields and constructs a Materie type object
  void _submit() async {
    //constructing the object
    Materie materie = new Materie();
    //retrieving the values and adding them to our materie object
    //using .trim on 'nume' to get rid of all the unnecesary white spaces that might occur while typing
    var nume = numeController.text.trim();
    materie.nume = nume;
    //using .toUpperCase to capitalize all letters in codSpecializare before insertion
    var codSpecializare = codSpecializareController.text.trim().toUpperCase();
    materie.codSpecializare = codSpecializare;
    //changing the type of values retrieved from string(text) to a number we can use(int) using the function int.parse
    var tip = int.parse(tipController.text);
    materie.tip = tip;
    var an = int.parse(anController.text);
    materie.an = an;
    var saptamana = int.parse(saptamanaController.text);
    materie.saptamana = saptamana;
    var ziua = int.parse(ziuaController.text);
    materie.ziua = ziua;
    var grupa = int.parse(grupaController.text);
    materie.grupa = grupa;
    var perStart = int.parse(perStartController.text);
    materie.perStart = perStart;
    var perEnd = int.parse(perEndController.text);
    materie.perEnd = perEnd;
    //clearing the text fields values after the user has pressed the 'adauga materie' button
    numeController.clear();
    codSpecializareController.clear();
    ziuaController.clear();
    tipController.clear();
    anController.clear();
    saptamanaController.clear();
    grupaController.clear();
    perStartController.clear();
    perEndController.clear();
    //variable that makes the connection to our database
    DBClient db = DBClient();
    //using try-catch to catch all the exceptions that might occur, so that the screen remains clean
    try {
      //create the connection
      await db.create();
      //inserting the materie object defined earlier into our database, using the upsertMaterie method defined in the DBClient class
      materie = await db.upsertMaterie(materie);
     // _showSnackBar("Data saved successfully"); -- to be defined. so a pop up message will appear when we succesfully make an insertion in our db
    } catch (e) {
      //if an exception is caught, print it to the terminal
      print('am prins o exceptie');
      print(e);
    }
  
    
  }
}
