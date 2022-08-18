import 'package:go_see_client/src/allExports.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DBProviderEventos{

  late Database _database;
  static final DBProviderEventos db = DBProviderEventos.privado();

  DBProviderEventos.privado();

  Future<Database> get database async{

    _database = await initDB();

    return _database;

  }

  initDB() async{

    Directory eventosDirectorio = await getApplicationDocumentsDirectory();

    final path = join(eventosDirectorio.path, 'EventosDB.db' );

    return await openDatabase(

      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async {

        await db.execute(

         'CREATE TABLE Eventos('

            'id TEXT,'
            'idTrabajo TEXT,'
            'nombre_cliente TEXT,'
            'titulo TEXT,'
            'fechaInicio DATE'

         ')'

        );

      }

    );

  }

  nuevoEvento(Evento evento) async{

    final db = await database;

    final res = await db.insert(

        'Eventos',
        evento.toJson()

    );

    return res;

  }

  Future<List<Evento>> getTodosEventos() async{

    final db = await database;
    final res = await db.query('Eventos');

    List<Evento> list = res.isNotEmpty
                          ? res.map((c) => Evento.fromJson(c)).toList()
                          : [];

    return list;

  }

  Future<List<Evento>> getEvento(String fecha) async{

    final db = await database;

    final res = await db.query(

        'Eventos',
        where: 'fechaInicio = ?',
        whereArgs: [fecha]

    );

    List<Evento> list = res.isNotEmpty
                          ? res.map((c) => Evento.fromJson(c)).toList()
                          : [];

    return list;

  }

  Future<int> eliminarEvento(String id) async{

    final db = await database;

    final res = await db.delete(

        'Eventos',
        where: 'id = ?',
        whereArgs: [id]

    );

    return res;

  }

}