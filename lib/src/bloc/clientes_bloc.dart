import 'dart:async';
import '../allExports.dart';

class ClientesBloc{

  static final ClientesBloc _singleton = ClientesBloc._internal();

  factory ClientesBloc(){ return _singleton; }

  ClientesBloc._internal(){

    getTodosClientes();

  }

  final _clientesControlador = StreamController<List<Persona>>.broadcast();

  Stream<List<Persona>> get clientesStream => _clientesControlador.stream;

  getTodosClientes() async{

    _clientesControlador.sink.add( await DBProviderClientes.db.getTodasPersonas());

  }

  agregarCliente(Persona persona) {

    DBProviderClientes.db.nuevaPersona(persona);
    getTodosClientes();
        
  } 

  eliminarCliente(int numCelular) {

    DBProviderClientes.db.eliminarPersona(numCelular);
    getTodosClientes();
        
  } 


  dispose(){

    _clientesControlador.close();

  }
}