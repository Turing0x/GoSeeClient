import 'package:go_see_client/src/base_datos/trabajos/Trabajos_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DBProviderTrabajos{

  late Database _database;
  static final DBProviderTrabajos db = DBProviderTrabajos.privado();

  DBProviderTrabajos.privado();

  Future<Database> get database async{

    _database = await initDB();

    return _database;

  }

  initDB() async{

    Directory trabajosDirectorio = await getApplicationDocumentsDirectory();

    final path = join(trabajosDirectorio.path, 'TrabajosDB.db' );

    return await openDatabase(

      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async {

        await db.execute(

         'CREATE TABLE Trabajos('

            'id TEXT,'
            'estado_actual TEXT,'
            'tipo_trabajo TEXT,'
            'nombre_cliente TEXT,'
            'direccion TEXT,'
            'observaciones TEXT,'
            'fecha TEXT'

         ')'

        );

      }
    );

  }

  Future<int> nuevoTrabajo(Trabajo trabajo) async{

    final db = await database;

    final res = await db.insert(

      'Trabajos',
      trabajo.toJson()

    );

    return res;

  }

  Future<int> actualizarTrabajo(Trabajo trabajo) async{

    final db = await database;

    final res = await db.update(

      'Trabajos', trabajo.toJson(),
      where: 'id = ?',
      whereArgs: [trabajo.id]

    );

    return res;

  }

  Future<List<Trabajo>> getTodosTrabajos() async{

    final db = await database;
    final res = await db.query('Trabajos');

    List<Trabajo> list = res.isNotEmpty
                          ? res.map((c) => Trabajo.fromJson(c)).toList()
                          : [];

    return list;

  }

  Future<List<Trabajo>> getPersonaTrabajos(String nombre) async{

    final db = await database;
    final res = await db.query(
      
      'Trabajos',
      where: 'nombre_cliente = ?',
      whereArgs: [nombre]
      
    );

    List<Trabajo> list = res.isNotEmpty
                          ? res.map((c) => Trabajo.fromJson(c)).toList()
                          : [];

    return list;

  }

  Future<int> eliminarTrabajo(String id) async{

    final db = await database;

    final res = await db.delete(

      'Trabajos',
      where: 'id = ?',
      whereArgs: [id]

    );

    return res;

  }

  Future<List<Trabajo>> getPendientes() async{

    final db = await database;
    final res = await db.query(
      
      'Trabajos',
      where: 'estado_actual = ?',
      whereArgs: ['Aún pendiente']
      
    );

    List<Trabajo> list = res.isNotEmpty
                          ? res.map((c) => Trabajo.fromJson(c)).toList()
                          : [];

    return list;

  }

  Future<List<Trabajo>> getFinalizados() async{

    final db = await database;
    final res = await db.query(
      
      'Trabajos',
      where: 'estado_actual = ?',
      whereArgs: ['Cumplido']
      
    );

    List<Trabajo> list = res.isNotEmpty
                          ? res.map((c) => Trabajo.fromJson(c)).toList()
                          : [];

    return list;

  }

}