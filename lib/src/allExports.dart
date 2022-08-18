export 'package:flutter/material.dart';
export 'package:uuid/uuid.dart';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

export 'paginas/detallesTrabajos_page.dart';
export 'paginas/detallesCliente_page.dart';
export 'paginas/editarCliente_page.dart';
export 'paginas/nuevoTrabajo_page.dart';
export 'paginas/crearCliente_page.dart';
export 'paginas/allClientes_page.dart';
export 'paginas/finalizados_page.dart';
export 'paginas/calendario_page.dart';
export 'paginas/trabajos_page.dart';
export 'paginas/home_page.dart';

export 'widgets/txtField.dart';
export 'widgets/cbField.dart';

export 'base_datos/clientes/dbClientes_provider.dart';
export 'base_datos/clientes/Clientes_model.dart';

export 'base_datos/trabajos/dbTrabajos_provider.dart';
export 'base_datos/trabajos/Trabajos_model.dart';

export 'base_datos/eventos/dbEventos_provider.dart';
export 'base_datos/eventos/eventos_model.dart';

export 'bloc/clientes_bloc.dart';
export 'bloc/trabajos_bloc.dart';

void showToast(String msg) => Fluttertoast.showToast(

  msg: msg,
  toastLength: Toast.LENGTH_SHORT,

);

void hacerLlamada(String numero) async{

  await FlutterPhoneDirectCaller.callNumber(numero);

}

void mensajeInfo(BuildContext context, String texto){

  showDialog(
                          
    context: context, 
    builder: (context) => AlertDialog(

      title: const Text('Información'),
      content: Text(texto),
      actions: [

        ElevatedButton.icon(
        
          style: ElevatedButton.styleFrom(primary: Colors.green[400], elevation: 2),
          icon: const Icon(Icons.thumb_up_alt_outlined), 
          label: const Text('Entiendo'),
          onPressed: () => Navigator.pop(context), 

        ),       

      ],

    ),
    
  );

}

Widget titloAppBar(String texto){

  return Text(texto, style: const TextStyle(
                
    color: Colors.black87,
    fontSize: 20,
    fontWeight: FontWeight.bold

  ));
  
}