import 'package:flutter/material.dart';
import 'package:orarupm/model/Materie.dart';
import 'package:orarupm/model/Specializare.dart';
import 'package:orarupm/database/DBClient.dart';
import 'package:orarupm/ViewMateriiBySpecializariScreen.dart';
import 'dart:async';


//method wich returns the list of specializari from our database
Future<List<Specializare>> getSpecializariFromDB() async {
  DBClient db = DBClient();
  await db.create();
  //notice we are calling the getSpecializari method(defined in our DBClient class) from within another method
  List<Specializare> listaSpecializari = await db.getSpecializari();
  return listaSpecializari;
}

//standard page building code
class ViewSpecializariScreen extends StatefulWidget {
  @override
  ViewSpecializariScreenPageState createState() =>
      new ViewSpecializariScreenPageState();
}

class ViewSpecializariScreenPageState extends State<ViewSpecializariScreen> {
  
List _ani = [1,2,3,4];
List _saptamani = [1,2];

 List<DropdownMenuItem<int>> _dropDownMenuItemsAn;
int _currentAn;
 List<DropdownMenuItem<int>> _dropDownMenuItemsSapt;
int _currentSapt;
   @override
  void initState() {
    _dropDownMenuItemsAn = getDropDownMenuItemsAn();
    _dropDownMenuItemsSapt = getDropDownMenuItemsSapt();
    _currentAn = _dropDownMenuItemsAn[0].value;
    _currentSapt = _dropDownMenuItemsSapt[0].value;
    super.initState();
}

List<DropdownMenuItem<int>> getDropDownMenuItemsAn() {
    List<DropdownMenuItem<int>> items = new List();
    for (int an in _ani) {
      items.add(new DropdownMenuItem(
          value: an,
          child: new Text(an.toString())
      ));
    }
    return items;
}

List<DropdownMenuItem<int>> getDropDownMenuItemsSapt() {
    List<DropdownMenuItem<int>> items = new List();
    for (int saptamana in _saptamani) {
      items.add(new DropdownMenuItem(
          value: saptamana,
          child: new Text(saptamana.toString())
      ));
    }
    return items;
}

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Lista specializari'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(16.0),
        //creating a future builder for our list of specializari
        child: new FutureBuilder<List<Specializare>>(
          future: getSpecializariFromDB(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                //in case of loading screen display a spinning circle
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                //connection is succesful, we can start building our layout
                //our data comes from the snapshot and we itterate through it using an index(refers to the position in the list we received)
                return new ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ViewMateriiBySpecializariScreen(
                                            codSpecializare:  snapshot.data[index].cod,
                                            numeSpecializare: snapshot.data[index].nume),
                                  ),
                                );
                              },
                              child: new Text(snapshot.data[index].nume,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0)),
                            ),
                            new Divider()
                          ]);
                    });
            }
          },
        ),
      ),
    );
  }
}
