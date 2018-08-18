import 'dart:convert';

//thiss is the Materie class wich we use to create all the necesary Materie type objects
class Materie {

//constructor wich takes no input
Materie();

//all the data a Materie object must have
int id;
String nume;
String codSpecializare;
int tip;
int an;
int saptamana;
int ziua;
int grupa;
int perStart;
int perEnd;

//columns for our database
static final columns = ["id", "nume", "cod_specializare", "tip", "an", "saptamana", "ziua", "grupa", "per_start", "per_end"];


//standard mapping code for sqlite to work with
//this is found in the documentation
Map toMap() {
    Map<String, dynamic> map = {
      "nume": nume,
      "cod_specializare": codSpecializare,
      "tip": tip,
      "an": an,
      "saptamana": saptamana,
      "ziua": ziua,
      "grupa": grupa,
      "per_start": perStart,
      "per_end": perEnd,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

   Materie.fromMap(Map map) {
    id = map["id"];
    nume = map["nume"];
    codSpecializare = map["cod_specializare"];
    tip = map["tip"];
    an = map["an"];
    saptamana = map["saptamana"];
    ziua = map["ziua"];
    grupa = map["grupa"];
    perStart = map["per_start"];
    perEnd = map["per_end"];
  }

}