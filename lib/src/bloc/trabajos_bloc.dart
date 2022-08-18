import 'dart:async';
import '../allExports.dart';

class TrabajosBloc{

  static final TrabajosBloc _singleton = TrabajosBloc._internal();


  factory TrabajosBloc(){ return _singleton; }

  TrabajosBloc._internal(){

    getTodosTrabajos();

  }

  final _trabajosControlador = StreamController<List<Trabajo>>.broadcast();

  Stream<List<Trabajo>> get trabajosStream{

    return _trabajosControlador.stream;

  }
  
  getTodosTrabajos() async{

    _trabajosControlador.sink.add( await DBProviderTrabajos.db.getTodosTrabajos());

  }

  agregarTrabajo(Trabajo trabajo) {

    DBProviderTrabajos.db.nuevoTrabajo(trabajo);
    getTodosTrabajos();

  } 

  actualizarTrabajo(Trabajo trabajo) {

    DBProviderTrabajos.db.actualizarTrabajo(trabajo);
    DBProviderEventos.db.eliminarEvento(trabajo.id);
    getTodosTrabajos();

  } 

  eliminarTrabajo(String id) {

    DBProviderTrabajos.db.eliminarTrabajo(id);
    DBProviderEventos.db.eliminarEvento(id);

    getTodosTrabajos();

  }

  dispose(){

    _trabajosControlador.close();

  }
}