import 'package:flutter/material.dart';
import 'package:orarupm/model/Materie.dart';
import 'package:orarupm/database/DBClient.dart';
import 'package:orarupm/ViewMateriiScreen.dart';
import 'dart:async';

//method to get the list of materii from database
Future<List<Materie>> getMaterii(String cod, int an, int sapt, int ziua) async {
  DBClient db = DBClient();
  await db.create();
  List<Materie> materii = await db.getMateriiByCodSpec(cod, an, sapt, ziua);
  return materii;
}


//standard code for page building
class ViewMateriiBySpecializariScreen extends StatefulWidget {
  final String codSpecializare;
  final String numeSpecializare;
  

  ViewMateriiBySpecializariScreen({@required this.codSpecializare, @required this.numeSpecializare});

  @override
  ViewMateriiBySpecializariScreenPageState createState() =>
      new ViewMateriiBySpecializariScreenPageState();
}

class ViewMateriiBySpecializariScreenPageState extends State<ViewMateriiBySpecializariScreen> {

  List _ani = [1,2,3,4];
List _saptamani = [1,2];
String tip;

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
          child: new Text("Anul " + an.toString())
      ));
    }
    return items;
}

List<DropdownMenuItem<int>> getDropDownMenuItemsSapt() {
    List<DropdownMenuItem<int>> items = new List();
    for (int saptamana in _saptamani) {
      items.add(new DropdownMenuItem(
          value: saptamana,
          child: new Text("Săptămâna " + saptamana.toString())
      ));
    }
    return items;
}

  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Luni"),
                Tab(text: "Marți"),
                Tab(text: "Miercuri"),
                Tab(text: "Joi"),
                Tab(text: "Vineri"),
              ],
            ),
            title: 
            new Container(
       
      child: new Row(
            children: <Widget>[
              new Text(widget.codSpecializare+":"),
              new Padding(padding: new EdgeInsets.all(8.0),),
              new DropdownButton(
                value: _currentAn,
                items: _dropDownMenuItemsAn,
                onChanged: changedDropDownItemAn,
              ),
              new DropdownButton(
                value: _currentSapt,
                items: _dropDownMenuItemsSapt,
                onChanged: changedDropDownItemSapt,
              )
            ],
          ),          
      ),
          ),
          body: TabBarView(
            children: [
              
               new Container(
        height: 550.0,
  child: 
 new FutureBuilder<List<Materie>>(
          future: getMaterii(widget.codSpecializare, _currentAn, _currentSapt, 1),
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
                  itemBuilder: (context, index)
                   {
                      if (snapshot.data[index].tip == 1) {
                            tip = "Curs";
                          }
                          else if (snapshot.data[index].tip == 2) {
                            tip = "Laborator";
                          }
                          else {
                            tip = "Seminar";
                          };
                    return new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //creating text boxes to display all the information about a materie object, ONE AT A TIME based on the given index
                          new Text("Materie: " + snapshot.data[index].nume,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)), 
                          new Text(tip,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                      new Text("Grupa: " + snapshot.data[index].grupa.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("De la: " + snapshot.data[index].perStart.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Pana la: " + snapshot.data[index].perEnd.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
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
              new Container(
        height: 550.0,
  child: 
 new FutureBuilder<List<Materie>>(
          future: getMaterii(widget.codSpecializare, _currentAn, _currentSapt, 2),
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
                          new Text("Nume: " + snapshot.data[index].nume,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Specializare: " + snapshot.data[index].codSpecializare,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                          new Text("Anul: " + snapshot.data[index].an.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Saptamana: " + snapshot.data[index].saptamana.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                                  new Text("Ziua: " + snapshot.data[index].ziua.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Grupa: " + snapshot.data[index].grupa.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Ora start: " + snapshot.data[index].perStart.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Ora final: " + snapshot.data[index].perEnd.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
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
              new Container(
        height: 550.0,
  child: 
 new FutureBuilder<List<Materie>>(
          future: getMaterii(widget.codSpecializare, _currentAn, _currentSapt, 3),
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
                          new Text("Nume: " + snapshot.data[index].nume,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Specializare: " + snapshot.data[index].codSpecializare,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                          new Text("Anul: " + snapshot.data[index].an.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Saptamana: " + snapshot.data[index].saptamana.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                                  new Text("Ziua: " + snapshot.data[index].ziua.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Grupa: " + snapshot.data[index].grupa.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Ora start: " + snapshot.data[index].perStart.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Ora final: " + snapshot.data[index].perEnd.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
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
              new Container(
        height: 550.0,
  child: 
 new FutureBuilder<List<Materie>>(
          future: getMaterii(widget.codSpecializare, _currentAn, _currentSapt, 4),
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
                          new Text("Nume: " + snapshot.data[index].nume,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Specializare: " + snapshot.data[index].codSpecializare,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                          new Text("Anul: " + snapshot.data[index].an.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Saptamana: " + snapshot.data[index].saptamana.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                                  new Text("Ziua: " + snapshot.data[index].ziua.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Grupa: " + snapshot.data[index].grupa.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Ora start: " + snapshot.data[index].perStart.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Ora final: " + snapshot.data[index].perEnd.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
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
             new Container(
        height: 550.0,
  child: 
 new FutureBuilder<List<Materie>>(
          future: getMaterii(widget.codSpecializare, _currentAn, _currentSapt, 5),
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
                          new Text("Nume: " + snapshot.data[index].nume,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Specializare: " + snapshot.data[index].codSpecializare,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                          new Text("Anul: " + snapshot.data[index].an.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Saptamana: " + snapshot.data[index].saptamana.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                                  new Text("Ziua: " + snapshot.data[index].ziua.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Grupa: " + snapshot.data[index].grupa.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Ora start: " + snapshot.data[index].perStart.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text("Ora final: " + snapshot.data[index].perEnd.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
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
            ],
          ),
        ),
      ),
    );
  }

void changedDropDownItemAn(int selectedAn) {
    setState(() {
      _currentAn = selectedAn;
    });
}

void changedDropDownItemSapt(int selectedSapt) {
    setState(() {
      _currentSapt = selectedSapt;
    });
}

}



// return MaterialApp(
//       home: DefaultTabController(
//         length: 5,
//         child:
//      new Scaffold(
//       appBar: new AppBar(
//         title: new Text(widget.numeSpecializare),
//       ),
//       body: new Column(
//         children: <Widget>[
//        new Container(
//         color: Colors.white,
//       child: new Row(
//             children: <Widget>[
//               new Text("An: "),
//               new DropdownButton(
//                 value: _currentAn,
//                 items: _dropDownMenuItemsAn,
//                 onChanged: changedDropDownItemAn,
//               ),
//               new Text("Saptamana: "),
//               new DropdownButton(
//                 value: _currentSapt,
//                 items: _dropDownMenuItemsSapt,
//                 onChanged: changedDropDownItemSapt,
//               )
//             ],
//           ),          
//       ),
//       new Container(
//         height: 550.0,
//   child: 
//  new FutureBuilder<List<Materie>>(
//           future: getMaterii(widget.codSpecializare, _currentAn, _currentSapt),
//           //notice the snapshot
//           builder: (context, snapshot) {
//             //another verrification for data errors
//                       if (snapshot.hasError)
//             return Text("Error Occurred");
//             //checking for connection to the database
//              switch (snapshot.connectionState) { 
//               case ConnectionState.waiting:
//               //in case of loading screen display a spinning circle
//               return Center(child: CircularProgressIndicator());
//               case ConnectionState.done:
//               //connection is succesful, we can build our layout
//               return new ListView.builder(
//                 //notice the snapshot and the index
//                 //snapshot holds our data
//                 //using the index we itterate through it(refers to the position in the list we received)
//                   itemCount: snapshot.data.length,
//                   itemBuilder: (context, index) {
//                     return new Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           //creating text boxes to display all the information about a materie object, ONE AT A TIME based on the given index
//                           new Text("Nume: " + snapshot.data[index].nume,
//                               style: new TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 18.0)),
//                           new Text("Specializare: " + snapshot.data[index].codSpecializare,
//                               style: new TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 14.0)),
//                           new Text("Anul: " + snapshot.data[index].an.toString(),
//                               style: new TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 18.0)),
//                           new Text("Saptamana: " + snapshot.data[index].saptamana.toString(),
//                               style: new TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 18.0)),
//                                   new Text("Ziua: " + snapshot.data[index].ziua.toString(),
//                               style: new TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 18.0)),
//                           new Text("Grupa: " + snapshot.data[index].grupa.toString(),
//                               style: new TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 18.0)),
//                           new Text("Ora start: " + snapshot.data[index].perStart.toString(),
//                               style: new TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 18.0)),
//                           new Text("Ora final: " + snapshot.data[index].perEnd.toString(),
//                               style: new TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 18.0)),
//                           new Divider()
//                         ]);
//                   });
//                   //in default we tell the app what to do if the connection does not meet the requrements we set above
//                   //currently empty because we handled everyting that could happen: connection error, no data, pending, loading, etc
//                   default:
//             } 
//           },
//         ),
// )

//       ],
//       )
//     )
//       ),
//       );  