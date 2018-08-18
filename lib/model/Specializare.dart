import 'dart:convert';

//thiss is the Specializare class wich we use to create all the necesary Specializare type objects

class Specializare {

  //all the data a Specializare object must have
  int id;
  String nume;
  String cod;
  String descriere;


  //default constructor wich takes no input
  Specializare();

//standard mapping code for sqlite to work with
//this is found in the documentation
  Map toMap() {
    Map<String, dynamic> map = {
    "nume": nume,
     "cod": cod,
     "descriere": descriere,
     };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }


  Specializare.fromMap(Map map) {
    id = map["id"];
    nume = map["nume"];
    cod = map["cod"];
    descriere = map["descriere"];
  }
}

