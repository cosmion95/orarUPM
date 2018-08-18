import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:orarupm/model/Materie.dart';
import 'package:orarupm/model/Specializare.dart';

final String columnId = "id";

class DBClient {

Database _db;

//create and give acces to the database
  Future create() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "database.db");

    _db = await openDatabase(dbPath, version: 1,
        onCreate: this._create);
  }

//create the database tables
   Future _create(Database db, int version) async {
    await db.execute("""
            CREATE TABLE specializare (
              id INTEGER PRIMARY KEY, 
              nume TEXT NOT NULL,
              cod TEXT NOT NULL UNIQUE,
              descriere TEXT NOT NULL
            )""");

    await db.execute("""
            CREATE TABLE materie (
              id INTEGER PRIMARY KEY,
              nume TEXT NOT NULL,
              cod_specializare TEXT NOT NULL,
              tip INTEGER NOT NULL,
              an INTEGER NOT NULL,
              saptamana INTEGER NOT NULL,
              ziua INTEGER NOT NULL,
              grupa INTEGER NOT NULL,
              per_start INTEGER NOT NULL,
              per_end INTEGER NOT NULL,
              FOREIGN KEY(cod_specializare) REFERENCES specializare(cod)
            )""");
  }

//function that inserts or updates a row in the Specializare table based on the passed Specializare object
  Future<Specializare> upsertSpecializare(Specializare specializare) async {
    if (specializare.id == null) {
      specializare.id = await _db.insert("specializare", specializare.toMap());
      int x = specializare.id;
      print("adaugat in db: $x");
    } else {
      await _db.update("specializare", specializare.toMap(), where: "id = ?", whereArgs: [specializare.id]);
    }
    return specializare;
  }

  //function that inserts or updates a row in the Materie table based on the passed Materie object
  Future<Materie> upsertMaterie(Materie materie) async {
    if (materie.id == null) {
      materie.id = await _db.insert("materie", materie.toMap());
      int x = materie.id;
      print("adaugat in db: $x");
    } else {
      await _db.update("materie", materie.toMap(), where: "id = ?", whereArgs: [materie.id]);
    }
    return materie;
  }

//return a list of objects type Specializare
//interoghez tabela specializari si returnez o lista cu ce contine; 
//lista returnata va contine obiecte de tip Specializare
  Future<List<Specializare>> getSpecializari() async {
    try{
    //List<Map> results = await _db.query("specializare", columns: Specializare.columns);
    List<Map> results = await _db.rawQuery('SELECT * FROM "specializare"');
    int x = results.length;
    print("marime lista rezultata: $x");
    List<Specializare> specializari = new List();
    results.forEach((result) {
      Specializare specializare = Specializare.fromMap(result);
      String nume = specializare.nume;
      print("nume spec: $nume");
      specializari.add(specializare);
    });
    return specializari;
  }
    catch(e) {
      print(e);
      return null;
    }
  }

//return a list of objects type Materie
  Future<List<Materie>> getMaterii() async {
    try{
    //List<Map> results = await _db.query("specializare", columns: Specializare.columns);
    List<Map> results = await _db.rawQuery('SELECT * FROM "materie"');
    int x = results.length;
    print("marime lista rezultata: $x");
    List<Materie> materii = new List();
    results.forEach((result) {
      Materie materie = Materie.fromMap(result);
      materii.add(materie);
    });
    return materii;
  }
    catch(e) {
      print(e);
      return null;
    }
  }

  //returns only the materii which a cod_specializare like the one in the parameter
  Future<List<Materie>> getMateriiByCodSpec(String cod, int an, int sapt, int ziua) async {
    try{
    //List<Map> results = await _db.query("specializare", columns: Specializare.columns);
    List<Map> results = await _db.query("materie",columns: ["nume","cod_specializare", "tip","an","saptamana","ziua","grupa","per_start","per_end"], where: '"cod_specializare" = ? and "an" = ? and "saptamana" = ? and "ziua" = ?', whereArgs: [cod,an,sapt,ziua], orderBy: 'per_start');
    int x = results.length;
    print("marime lista rezultata: $x");
    List<Materie> materii = new List();
    results.forEach((result) {
      Materie materie = Materie.fromMap(result);
      materii.add(materie);
    });
    return materii;
  }
    catch(e) {
      print(e);
      return null;
    }
  }

//return an object of type Specializare from the database(table name: specializare) based on the given id
  Future<Specializare> getSpecializare(int id) async {
    String columnID = "id";
    List<Map> maps = await _db.query("specializare",
        columns: ["nume", "cod", "descriere"],
        where: "$columnID = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return new Specializare.fromMap(maps.first);
    }
    return null;
  }

//return an object of type Materie from the database(table name: materie) based on the given id
  Future<Materie> getMaterie(int id) async {
    String columnID = "id";
    List<Map> maps = await _db.query("materie",
        columns: ["nume", "cod_specializare", "an","saptamana", "ziua", "grupa","per_start","per_end"],
        where: "$columnID = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return new Materie.fromMap(maps.first);
    }
    return null;
  }

//delete a row from the database(table: materie) based on the given id
  Future<int> deleteMaterie(int id) async {
    return await _db.delete("materie", where: "$columnId = ?", whereArgs: [id]);
  }

}