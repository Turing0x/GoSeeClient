import 'dart:async';

import '../allExports.dart';

class DetallesClientePage extends StatefulWidget {
  
  final String nombre, direccion, observaciones;
  final int numCelular;
  List<Trabajo> encontrados;


  DetallesClientePage(
  
    this.nombre, 
    this.numCelular, 
    this.direccion, 
    this.observaciones, 
    this.encontrados, 
    {Key? key

  }) : super(key: key);


  @override
  State<DetallesClientePage> createState() => _DetallesClientePageState();
}

class _DetallesClientePageState extends State<DetallesClientePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        
        title: titloAppBar('Detalles del cliente'),
        automaticallyImplyLeading: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,

        actions: [

          IconButton(
      
            icon: const Icon(Icons.edit_outlined,),
            onPressed: () {

              Navigator.pushNamed(context, 'editarCliente', 

                arguments: [
                  
                  widget.nombre, 
                  widget.numCelular, 
                  widget.direccion, 
                  widget.observaciones, 
                  widget.numCelular, 
                  (widget.encontrados.isEmpty)
                  ? false
                  : true

                ]
              
              );

            }, 
            
          ),

        ],
        
      ),

      body: SingleChildScrollView(

        child: SafeArea(

          child: Column(
              
            children: [              
              
              Container(

                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
        
                  crossAxisAlignment: CrossAxisAlignment.start,
                      
                  children: [

                    ListTile(
                    
                      title: Text(widget.nombre, style: const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: const Text('Nombre del cliente'),
                      trailing: Icon(Icons.person_outline, color: Colors.blue[400]),
                    
                    ),

                    const Divider(),
                  
                    ListTile(
                    
                      title: Text(widget.numCelular.toString(), style: const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: const Text('Número de celular'),
                      trailing: IconButton(
                          
                          icon: const Icon(Icons.call_outlined), color: Colors.blue[400], 
                          onPressed: () => hacerLlamada(widget.numCelular.toString()),
                          splashColor: Colors.red,
                          splashRadius: 20,
                          constraints: const BoxConstraints(maxWidth: 33),
                          
                        ), 
                    
                    ),

                    const Divider(),

                    ListTile(
                    
                      title: Text(widget.direccion, style: const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: const Text('Dirección particular'),
                      trailing: Icon(Icons.location_on_outlined, color: Colors.blue[400]),
                    
                    ),

                    const Divider(),

                    ListTile(
                    
                      title: const Text('Observaciones sobre el cliente', style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(widget.observaciones),
                      trailing: Icon(Icons.info_outline, color: Colors.blue[400]),
                    
                    ),

                    const Divider(),

                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [

                      const SizedBox(width: 16),

                      const Text('Historial de trabajos:',

                        style: TextStyle(

                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold

                        ),

                      ),

                      SizedBox(width: MediaQuery.of(context).size.width * 0.36),

                      IconButton(
                        
                        icon: const Icon(Icons.my_library_books_outlined),
                        color: Colors.blue[400],
                        onPressed: (){}
                        
                      )

                    ],),

                    (widget.encontrados.isEmpty)
                    ? const Center(child: Text('No existen registros de trabajos'))
                    : SizedBox(

                      height: 340,
                      child: ListView.builder(
                      
                        itemCount: widget.encontrados.length,
                        itemBuilder: (context, i) {

                          return Card(

                            elevation: 2,
                            // color: Colors.green[100],
                            shape: const RoundedRectangleBorder(

                              borderRadius: BorderRadius.only(

                                topLeft: Radius.circular(30),
                                bottomRight: Radius.circular(20),

                              )

                            ),

                            child: ListTile(

                              contentPadding: const EdgeInsets.symmetric(horizontal: 30),

                              title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [

                                Text(widget.encontrados[i].tipo_trabajo, style: const TextStyle(fontWeight: FontWeight.bold),),

                                const SizedBox(width: 5,),

                                (widget.encontrados[i].estado_actual == 'Aún pendiente')
                                ? Icon(Icons.cancel_outlined, color: Colors.red[500],)
                                : Icon(Icons.check_circle_outline, color: Colors.green[500],)                                

                              ],), 

                              subtitle: Text(widget.encontrados[i].fecha),                              
                              trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.black,),
                              

                              onTap: () {
                            
                                Navigator.pushNamed(context, 'detallesTrabajo',
                      
                                  arguments: [
                              
                                    widget.encontrados[i].id,
                                    widget.encontrados[i].estado_actual,
                                    widget.encontrados[i].nombre_cliente,
                                    widget.encontrados[i].tipo_trabajo,
                                    widget.encontrados[i].direccion,
                                    widget.encontrados[i].observaciones,
                                    widget.encontrados[i].fecha,
                                          
                                  ]
                                
                                );
                                
                              },      

                            ),

                          );

                        }
                          
                      ),

                    )            

                  ],

                ),
            
              )
                  
            ]
              
          ),

        ),

      )  
      
    );

  }

}