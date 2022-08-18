import 'dart:async';
import '../allExports.dart';

class EventosBloc{

  static final EventosBloc _singleton = EventosBloc._internal();

  factory EventosBloc(){ return _singleton; }

  EventosBloc._internal(){

    getTodosEventos();

  }

  final _eventosControlador = StreamController<List<Evento>>.broadcast();

  Stream<List<Evento>> get eventosStream => _eventosControlador.stream;

  getTodosEventos() async{

    _eventosControlador.sink.add( await DBProviderEventos.db.getTodosEventos());

  }

  agregarEvento(Evento evento) {

    DBProviderEventos.db.nuevoEvento(evento);
    getTodosEventos();
        
  } 

  eliminarEvento(String id) {

    DBProviderEventos.db.eliminarEvento(id);
    getTodosEventos();
        
  } 


  dispose(){

    _eventosControlador.close();

  }
}