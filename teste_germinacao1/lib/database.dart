import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:teste_germinacao1/germinacao.dart';

class DatabaseHandler {
  //cria a base de dados
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'germinacao.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE germinacao(id INTEGER PRIMARY KEY AUTOINCREMENT, sementesGerminadas REAL NOT NULL, totalSementes REAL NOT NULL, germinacao REAL NOT NULL)",
        );
      }
      version: 1,
    );
  }

  //INSERT
  Future<int> insertGerminacao(List<Germinacao> germina) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var ger in germina) {
      result = await db.insert('germinacao', ger.toMap());
    }
    return result;
  }

  //SELECT
   Future<List<Germinacao>> retrieveRep() async {
    final Database db = await initializeDB();
    final List<Map<String, Object>> queryResult = await db.query('germinacao');
    return queryResult.map((e) => Germinacao.fromMap(e)).toList();
  }

  //SELECT A SINGLE REP
  Future<List<Map<String, dynamic>>> retrieveSingleRep(int id) async {
    //Repeticao rep;
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult =
        await db.query('germinacao', where: "id = ?", whereArgs: [id]);
    return queryResult;
    }

  //DELETE
  Future<void> deleteRep(int id) async {
    final db = await initializeDB();
    await db.delete(
      'germinacao',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  //UPDATE
  Future<void> updateRepeticao(Germinacao germinacao) async {
    final db = await initializeDB();
    await db.update(
      'germinacao',
      germinacao.toMap(),
      where: "id = ?",
      whereArgs: [germinacao.id],
    );
  }

  
}
