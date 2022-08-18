import 'package:go_see_client/src/base_datos/clientes/Clientes_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DBProviderClientes{

  late Database _database;
  static final DBProviderClientes db = DBProviderClientes.privado();

  DBProviderClientes.privado();

  Future<Database> get database async{

    _database = await initDB();

    return _database;

  }

  initDB() async{

    Directory perosnasDirectorio = await getApplicationDocumentsDirectory();

    final path = join(perosnasDirectorio.path, 'PersonasDB.db' );

    return await openDatabase(

      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async {

        await db.execute(

         'CREATE TABLE Personas('

            'nombre TEXT,'
            'numCelular INTEGER,'
            'direccion TEXT,'
            'observaciones TEXT'

         ')'

        );

      }

    );

  }

  nuevaPersona(Persona persona) async{

    final db = await database;

    final res = await db.insert(

        'Personas',
        persona.toJson()

    );

    return res;

  }

  Future<List<Persona>> getPersona(String nombre) async{

    final db = await database;

    final res = await db.query(

        'Personas',
        where: 'nombre = ?',
        whereArgs: [nombre]

    );

    List<Persona> list = res.isNotEmpty
                          ? res.map((c) => Persona.fromJson(c)).toList()
                          : [];

    return list;

  }

  Future<List<Persona>> getTodasPersonas() async{

    final db = await database;
    final res = await db.query('Personas');

    List<Persona> list = res.isNotEmpty
                          ? res.map((c) => Persona.fromJson(c)).toList()
                          : [];

    return list;

  }

  Future<bool> saberSiExiste(int numCelular) async{

    bool existe = false;
    final db = await database;

    final res = await db.query(

        'Personas',
        where: 'numCelular = ?',
        whereArgs: [numCelular]

    );

    res.isNotEmpty ? existe = true : existe = false;

    return existe;

  }

  Future<int> eliminarPersona(int numCelular) async{

    final db = await database;

    final res = await db.delete(

        'Personas',
        where: 'numCelular = ?',
        whereArgs: [numCelular]

    );

    return res;

  }

}