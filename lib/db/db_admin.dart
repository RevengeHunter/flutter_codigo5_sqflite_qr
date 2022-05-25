import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/vaccine_card_model.dart';

class DBAdmin {
  Database? myDatabase;

  static final DBAdmin db = DBAdmin._();
  DBAdmin._();

  Future<Database?> getCheckDatabase() async{
    if (myDatabase != null) return myDatabase;
    myDatabase = await initDB(); //Creacion de la base de datos
    return myDatabase;
  }

  Future<Database> initDB() async {
    Directory directory =
    await getApplicationDocumentsDirectory(); //Lo maneja el path provider
    String path = join(directory.path, "VaccineRecord.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int v) async {
        await db.execute("CREATE TABLE VACCINE_RECORD(id INTEGER PRIMARY KEY AUTOINCREMENT, urlVaccineCard TEXT, fullName TEXT, dni TEXT)");
      },
    );
  }

  //READ - Realizar consultas a la tabla
  Future<List> getVaccineCardsRaw() async{
    final Database? databaseDB = await getCheckDatabase();
    List res = await databaseDB!.rawQuery("SELECT * FROM VACCINE_RECORD ORDER BY id DESC");
    return res;
  }

  Future<List<VaccineCardModel>> getVaccineCards() async{
    List<VaccineCardModel> res = [];
    final Database? databaseDB = await getCheckDatabase();
    List getRes = await databaseDB!.query("VACCINE_RECORD",orderBy: "id DESC");
    res = getRes.map<VaccineCardModel>((e) => VaccineCardModel.fromJson(e)).toList();

    return res;
  }

  Future<List<VaccineCardModel>> getVaccineCardsSearch(String textSearch) async{
    List<VaccineCardModel> res = [];
    final Database? databaseDB = await getCheckDatabase();
    List getRes = await databaseDB!.query("VACCINE_RECORD",where: "UPPER(fullName) LIKE '%$textSearch%'" ,orderBy: "id DESC");
    res = getRes.map<VaccineCardModel>((e) => VaccineCardModel.fromJson(e)).toList();

    return res;
  }

  //CREATE - Realizar insersiones a la tabla
  insertVaccineCardRaw() async{
    final Database? databaseDB = await getCheckDatabase();
    int res = await databaseDB!.rawInsert("INSERT INTO VACCINE_RECORD(urlVaccineCard,fullName,dni) VALUES('https://images-na.ssl-images-amazon.com/images/I/413G5MbAewL._SX331_BO1,204,203,200_.jpg','J. L. D. Barnett','89565986')");
    print(res);
  }

  insertVaccineCard(VaccineCardModel VaccineCard) async{
    final Database? databaseDB = await getCheckDatabase();
    int res = await databaseDB!.insert("VACCINE_RECORD",VaccineCard.toJson()
    );
    print(res);
    return res;
  }

  //UPDATE - Realizar actualizaciones a la tabla
  Future<int> updateVaccineCardRaw(VaccineCardModel VaccineCard) async{
    final Database? databaseDB = await getCheckDatabase();
    int res = await databaseDB!.rawUpdate("UPDATE VACCINE_RECORD SET urlVaccineCard = ${VaccineCard.urlVaccineCard}, fullName = ${VaccineCard.fullName}, dni = ${VaccineCard.dni}}  WHERE dni = ${VaccineCard.dni}");
    print(res);
    return res;
  }

  updateVaccineCard(VaccineCardModel VaccineCard) async{
    final Database? databaseDB = await getCheckDatabase();
    int res = await databaseDB!.update("VACCINE_RECORD",VaccineCard.toJson(), where: "dni = ${VaccineCard.dni}");
    print(res);
    return res;
  }

  //DELETE - Realizar eliminaciones a la tabla
  Future<int> deleteVaccineCardRaw(int idVaccineCard) async{
    final Database? databaseDB = await getCheckDatabase();
    int res = await databaseDB!.rawDelete("DELETE FROM VACCINE_RECORD WHERE dni = $idVaccineCard");
    print(res);
    return res;
  }

  deleteVaccineCard(int idVaccineCard) async{
    final Database? databaseDB = await getCheckDatabase();
    int res = await databaseDB!.delete("VACCINE_RECORD", where: "dni = $idVaccineCard");
    print(res);
    return res;
  }

}