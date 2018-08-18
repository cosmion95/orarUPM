import 'package:flutter/material.dart';
import 'package:orarupm/model/Materie.dart';
import 'package:orarupm/database/DBClient.dart';
import 'package:orarupm/ModifyMaterie.dart';
import 'dart:async';

//method wich returns the list of materii from our database
Future<List<Materie>> getMateriiFromDB() async {
  DBClient db = DBClient();
  await db.create();
  //notice we are calling the getMaterii method(defined in our DBClient class) from within another method
  List<Materie> listaMaterii = await db.getMaterii();
  return listaMaterii;
}
//function which deletes a row from the materie table based on the given id
Future<int> deleteMaterie(int id) async {
  DBClient db = DBClient();
  await db.create();
  return db.deleteMaterie(id);
}
//standard page building code
class ViewMateriiScreen extends StatefulWidget {
  @override
  ViewMateriiScreenPageState createState() => new ViewMateriiScreenPageState();
}
class ViewMateriiScreenPageState extends State<ViewMateriiScreen> {
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Lista Materii'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(16.0),
        //using a future builder of type <List<Materie>> to print out all the necesary information to the screen
        child: new FutureBuilder<List<Materie>>(
          future: getMateriiFromDB(),
          //notice the snapshot
          builder: (context, snapshot) {
            //another verrification for data errors
                      if (snapshot.hasError)
            return Text("Error Occurred");
            //checking for connection to the database
             switch (snapshot.connectionState) { 
              case ConnectionState.waiting:
              //in case of loading screen display a spinning circle
              return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
              //connection is succesful, we can build our layout
              return new ListView.builder(
                //notice the snapshot and the index
                //snapshot holds our data
                //using the index we itterate through it(refers to the position in the list we received)
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //creating text boxes to display all the information about a materie object, ONE AT A TIME based on the given index
                          new Text(snapshot.data[index].nume,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text(snapshot.data[index].codSpecializare,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                          new Text(snapshot.data[index].tip.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text(snapshot.data[index].an.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text(snapshot.data[index].saptamana.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                                  new Text(snapshot.data[index].ziua.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text(snapshot.data[index].grupa.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text(snapshot.data[index].perStart.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text(snapshot.data[index].perEnd.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                                  //button that calls the method 'deleteMaterie' and also sets the state(refreshes our list)
                          new Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            child: new RaisedButton(
                              onPressed: () {
                                deleteMaterie(snapshot.data[index].id);
                                setState(() { });
                              },
                              child: new Text('Sterge'),
                            ),
                          ),
                          // CURRENTLY NOT FUNCTIONAL --- button that opens the ModifyMaterie page in order to modify a certain materie object
                          new Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            child: new RaisedButton(
                              onPressed: () {
                                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>new ModifyMaterieScreen(idMaterie: snapshot.data[index].id)),
                      );
                              },
                              child: new Text('Modifica'),
                            ),
                          ),
                          new Divider()
                        ]);
                  });
                  //in default we tell the app what to do if the connection does not meet the requrements we set above
                  //currently empty because we handled everyting that could happen: connection error, no data, pending, loading, etc
                  default:
            } 
          },
        ),
      ),
    );
  }

}
