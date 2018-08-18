import 'package:flutter/material.dart';
import 'package:orarupm/model/Materie.dart';
import 'package:orarupm/model/Specializare.dart';
import 'package:orarupm/database/DBClient.dart';
import 'package:orarupm/ViewSpecializariScreen.dart';
import 'dart:async';


//standard code for building our page
class AddSpecializareScreen extends StatefulWidget {
  @override
  AddSpecializareScreenPageState createState() =>
      new AddSpecializareScreenPageState();
}

class AddSpecializareScreenPageState extends State<AddSpecializareScreen> {
  //using controllers to retrieve the data from the text fields
  final numeController = TextEditingController();
  final codController = TextEditingController();
  final descriereController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    numeController.dispose();
    codController.dispose();
    descriereController.dispose();
    super.dispose();
  }


  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Adauga o specializare'),
        ),
        body: new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new Form(
                child: new Column(
              children: [
                //add the text fields required to create a specializare object (nume, cod, descriere)
                new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(labelText: 'Nume'),
                  controller: numeController,
                ),
                new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(labelText: 'Cod'),
                  controller: codController,
                ),
                new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(labelText: 'Descriere'),
                  controller: descriereController,
                ),

                //button wich calls the submit method to add specializare to our database
                new Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: new RaisedButton(
                    onPressed: _submit,
                    child: new Text('Adauga specializare'),
                  ),
                ),

                //button wich takes us to the viewSpecializariScreen
                new Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: new RaisedButton(
                    onPressed:
                     () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewSpecializariScreen()),
                      );
                    }
                    ,
                    child: new Text('Vezi specializari'),
                  ),
                )
              ],
            ))));
  }

//this function retrieves the values of all the text fields and constructs a Specializare type object
  void _submit() async {
    Specializare specializare = new Specializare();

    var nume = numeController.text.trim();
    specializare.nume = nume;
    var cod = codController.text.trim().toUpperCase();
    specializare.cod = cod;
    specializare.descriere = descriereController.text;

    numeController.clear();
    codController.clear();
    descriereController.clear();

    //variable that makes the connection to our database
    DBClient db = DBClient();

    //using try-catch to catch all the exceptions that might occur, so that the screen remains clean
    try {
      //create the connection
      await db.create();

      //inserting the specializare object defined earlier into our database, using the upsertSpecializare method defined in the DBClient class
      specializare = await db.upsertSpecializare(specializare);
     // _showSnackBar("Data saved successfully"); -- to be defined. so a pop up message will appear when we succesfully make an insertion in our db
    } catch (e) {
      //if an exception is caught, print it to the terminal
      print('am prins o exceptie');
      print(e);
    }
  }
}