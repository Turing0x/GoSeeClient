import 'dart:async';

import '../allExports.dart';
import '../base_datos/clientes/dbClientes_provider.dart' as dbClientes_provider;


class DetallesTrabajosPage extends StatefulWidget {
  
  final String nombre_cliente, direccion, id;
  final String observaciones, tipo_trabajo, fecha;
  String estado_actual;

  DetallesTrabajosPage(
  
    this.id, 
    this.estado_actual, 
    this.nombre_cliente, 
    this.tipo_trabajo, 
    this.direccion, 
    this.observaciones, 
    this.fecha, 
    {Key? key

  }) : super(key: key);

  @override
  State<DetallesTrabajosPage> createState() => _DetallesTrabajosPage();
}

class _DetallesTrabajosPage extends State<DetallesTrabajosPage> {

  String numCelular = 'Seleccione un cliente';

  final Color? _colorRojo = Colors.red[100];
  final Color? _colorAzul = Colors.blue[100];

  final Icon _pendiente = const Icon(Icons.pending_actions_sharp, color: Colors.black);
  final Icon _cumplido  =  const Icon(Icons.check_box_outlined, color: Colors.black);

  final trabajosBloc = TrabajosBloc();

  @override
  void initState() {
    
    _getInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        
        title: titloAppBar('Detalles del trabajo'),
        automaticallyImplyLeading: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,   
        
      ),

      body: SingleChildScrollView(

        child: SafeArea(

          child: Column(
            
            children: [

              Container(

                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),        
                child: Column(
        
                  mainAxisAlignment: MainAxisAlignment.center,
                      
                  children: [
                  
                    Card(

                      elevation: 2,
                      color: (widget.estado_actual == 'Aún pendiente')
                              ? _colorRojo
                              : _colorAzul,
                       
                      shape: const RoundedRectangleBorder(

                        borderRadius: BorderRadius.only(

                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(20),

                        )
                    
                      ),

                      child: ListTile(
                      
                        title: Text(widget.estado_actual, style: const TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: const Text('Estado actual'),
                        trailing: (widget.estado_actual == 'Aún pendiente')
                                    ? _pendiente
                                    : _cumplido
                      
                      ),

                    ),

                    const Divider(),

                    ListTile(
                    
                      title: Text(widget.nombre_cliente, style: const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: const Text('Nombre del cliente'),
                      trailing: Icon(Icons.people_alt_outlined, color: Colors.blue[400]), 
                      
                    ),

                    ListTile(
                      
                      title: Text(numCelular, style: const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: const Text('Número para llamadas'),
                      trailing: GestureDetector(
                        
                        child: Icon(Icons.call, color: Colors.blue[400]),
                        onTap: () => hacerLlamada(numCelular), 
                      
                      )
                      
                    ),

                    const Divider(color: Colors.black,),

                    ListTile(
                    
                      title: Text(widget.tipo_trabajo, style: const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: const Text('Tipo de trabajo'),
                      trailing: Icon(Icons.work_outline, color: Colors.blue[400]), 
                      
                    ),

                    const Divider(),

                    ListTile(
                    
                      title: Text(widget.direccion, style: const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: const Text('Dirección establecida'),
                      trailing: Icon(Icons.location_on_outlined, color: Colors.blue[400]), 
                      
                    ),

                    const Divider(),

                    ListTile(
                    
                      title: Text(widget.fecha, style: const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: const Text('Fecha configurada'),
                      trailing: Icon(Icons.calendar_today_outlined, color: Colors.blue[400]), 
                      
                    ),

                    const Divider(),

                    ListTile(
                    
                      title: const Text('Observaciones sobre el trabajo:', style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(widget.observaciones),
                      trailing: Icon(Icons.info_outline, color: Colors.blue[400]), 
                      
                    ),

                    const Divider(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06,),

                    Row(mainAxisAlignment: MainAxisAlignment.center,
                    
                      children: [

                        ElevatedButton.icon(
                              
                          style: ElevatedButton.styleFrom(primary: Colors.red[400], elevation: 3),
                          icon: const Icon(Icons.delete_forever_outlined), 
                          label: const Text('Cancelar'),
                          onPressed: (widget.estado_actual == 'Cumplido')
                          ? null
                          :() {

                            showDialog(
                          
                              context: context, 
                              builder: (context) => AlertDialog(

                                title: const Text('Confirmar decisión'),
                                content: const Text('Está seguro que desea cancelar este trabajo?'),
                                actions: [

                                  ElevatedButton.icon(
                                  
                                    style: ElevatedButton.styleFrom(primary: Colors.red[400], elevation: 2),
                                    icon: const Icon(Icons.cancel_outlined), 
                                    label: const Text('Cancelar'),
                                    onPressed: () => Navigator.pop(context), 

                                  ),

                                  ElevatedButton.icon(
                                  
                                    style: ElevatedButton.styleFrom(primary: Colors.green[400], elevation: 2),
                                    icon: const Icon(Icons.thumb_up_off_alt_outlined), 
                                    label: const Text('Ok'),
                                    onPressed: () => _cancelarTrabajo(), 

                                  ),

                                ],

                              ),
                              
                            );

                          } 

                        ),

                        SizedBox(width: MediaQuery.of(context).size.width * 0.1,),

                        ElevatedButton.icon(
                              
                          style: ElevatedButton.styleFrom(primary: Colors.blue[400], elevation: 3),
                          icon: const Icon(Icons.library_add_check_outlined), 
                          label: const Text('Cumplido'),
                          onPressed: (widget.estado_actual == 'Cumplido')
                          ? null
                          :() {
                            
                            showDialog(
                          
                              context: context, 
                              builder: (context) => AlertDialog(

                                title: const Text('Confirmar decisión'),
                                content: const Text('Está seguro que desea marcar como cumplido este trabajo?'),
                                actions: [

                                  ElevatedButton.icon(
                                  
                                    style: ElevatedButton.styleFrom(primary: Colors.red[400], elevation: 2),
                                    icon: const Icon(Icons.cancel_outlined), 
                                    label: const Text('Cancelar'),
                                    onPressed: () => Navigator.pop(context), 

                                  ),

                                  ElevatedButton.icon(
                                  
                                    style: ElevatedButton.styleFrom(primary: Colors.green[400], elevation: 2),
                                    icon: const Icon(Icons.thumb_up_off_alt_outlined), 
                                    label: const Text('Ok'),
                                    onPressed: () => _marcarFinalizado(), 

                                  ),

                                ],

                              ),
                              
                            );

                          }

                        )

                      ],
                    
                    )

                  ],

                ),
            
              )

            ],

          )

        ),

      )  
      
    );

  }

  _getInfo() async{
                          
    final info = await dbClientes_provider.DBProviderClientes.db.getPersona(widget.nombre_cliente);

    if(info.isNotEmpty) setState(() => numCelular = info[0].numCelular.toString());

  }

  _marcarFinalizado(){

    final trabajo = Trabajo(
        
      id            : widget.id,
      estado_actual : 'Cumplido',
      nombre_cliente: widget.nombre_cliente,
      tipo_trabajo  : widget.tipo_trabajo,
      direccion     : widget.direccion,
      fecha         : widget.fecha,
      observaciones : widget.observaciones

    );

    trabajosBloc.actualizarTrabajo(trabajo);
    showToast('Registro de trabajo editado exitosamente');
    Navigator.pushReplacementNamed(context, '/');

    setState(() {
      widget.estado_actual = 'Cumplido';
    });

  }

  _cancelarTrabajo() async{

    trabajosBloc.eliminarTrabajo(widget.id);
    showToast('Registro de trabajo cancelado exitosamente');
    Navigator.pushReplacementNamed(context, '/');

  }

}