import 'package:flutter/material.dart';
import 'package:orarupm/model/Materie.dart';
import 'package:orarupm/model/Specializare.dart';
import 'package:orarupm/database/DBClient.dart';
import 'package:orarupm/ViewSpecializariScreen.dart';
import 'package:orarupm/ViewMateriiScreen.dart';
import 'dart:async';


//screen where we can modify an already saved row in the materie table

// --------------- NOT WORKING YET !!!!!!!!! --------------



//method to get the row from our database based on the id
Future<Materie> getMaterie(var idMaterie) async {
  DBClient db = DBClient();
  await db.create();
  Materie materie = await db.getMaterie(idMaterie);
  return materie;
}


//standard code for page building
class ModifyMaterieScreen extends StatefulWidget {
  final int idMaterie;
  

  ModifyMaterieScreen({@required this.idMaterie});

  @override
  ModifyMaterieScreenPageState createState() =>
      new ModifyMaterieScreenPageState();
}

class ModifyMaterieScreenPageState extends State<ModifyMaterieScreen> {
  
//using controllers to get the values from the text fields
  TextEditingController testController;

  final codSpecializareController = TextEditingController();
  final anController = TextEditingController();
  final saptamanaController = TextEditingController();
  final grupaController = TextEditingController();
  final perStartController = TextEditingController();
  final perEndController = TextEditingController();


//testing method --- TO BE REMOVED
  TextEditingController returnNumeController(String text){
    TextEditingValue value = TextEditingValue(text: text);
    testController = TextEditingController.fromValue(value);
    return testController;
  }

//testing
  Materie materieField;

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('modifica materia'),
        ),
        body: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new FutureBuilder<Materie>(
              future: getMaterie(widget.idMaterie),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text("Error Occurred");
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    //display data here
                    return new Form(
                        child: new Column(
                      children: [
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(labelText: 'Nume'),
                          initialValue: snapshot.data.nume,
                          controller: returnNumeController(snapshot.data.nume),
                        ),
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(labelText: 'Cod specializare'),
                          initialValue: snapshot.data.codSpecializare,
                        ),
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(labelText: 'An'),
                          initialValue: snapshot.data.an.toString(),
                        ),
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(labelText: 'Saptamana'),
                          initialValue: snapshot.data.saptamana.toString(),
                        ),
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(labelText: 'Grupa'),
                          initialValue: snapshot.data.grupa.toString(),
                        ),
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(labelText: 'Ora inceput'),
                          initialValue: snapshot.data.perStart.toString(),
                        ),
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(labelText: 'Ora final'),
                          initialValue: snapshot.data.perEnd.toString(),
                        ),
                        new Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: new RaisedButton(
                            onPressed: _submit,
                            child: new Text('Adauga Materie'),
                          ),
                        ),
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
                    ));

                  default:
                }
              }),
        ));
  }

  void _submit() async {
    //Materie materie = new Materie();

    var nume = testController.text.trim();
    //var nume = materieField.nume;
    print("text din nume controller este: $nume");
   // materie.nume = nume;

    // var codSpecializare = codSpecializareController.text.trim().toUpperCase();
    // print("text din cod controller este: $codSpecializare");
    // materie.codSpecializare = codSpecializare;

    // var an = int.parse(anController.text);
    // print("text din an controller este: $an");
    // materie.an = an;

    // var saptamana = int.parse(saptamanaController.text);
    // print("text din sapt controller este: $saptamana");
    // materie.saptamana = saptamana;

    // var grupa = int.parse(grupaController.text);
    // print("text din grupa controller este: $grupa");
    // materie.grupa = grupa;

    // var perStart = int.parse(perStartController.text);
    // print("text din ora inceput controller este: $perStart");
    // materie.perStart = perStart;

    // var perEnd = int.parse(perEndController.text);
    // print("text din ora final controller este: $perEnd");
    // materie.perEnd = perEnd;

    // numeController.clear();
    // codSpecializareController.clear();
    // anController.clear();
    // saptamanaController.clear();
    // grupaController.clear();
    // perStartController.clear();
    // perEndController.clear();

    // DBClient db = DBClient();

    // try {
    //   await db.create();
    //   materie = await db.upsertMaterie(materie);
    //   // _showSnackBar("Data saved successfully");
    // } catch (e) {
    //   print('am prins o exceptie');
    //   print(e);
    // }
  }
}
