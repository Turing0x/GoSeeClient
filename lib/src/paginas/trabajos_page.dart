import 'package:flutter_svg/flutter_svg.dart';
import '../allExports.dart';

class TrabajosPage extends StatefulWidget {
  const TrabajosPage({Key? key}) : super(key: key);

  @override
  State<TrabajosPage> createState() => _TrabajosPageState();
}

class _TrabajosPageState extends State<TrabajosPage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<List<Trabajo>>(

			future: DBProviderTrabajos.db.getPendientes(),
			builder: (BuildContext context, AsyncSnapshot<List<Trabajo>> snapshot) {

        if (!snapshot.hasData) {

					return Scaffold(

            floatingActionButton: FloatingActionButton.extended(

              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 2,
              onPressed: null,
              label: Row(
                
                children: const [

                  Icon(Icons.handyman_outlined, color: Colors.white),

                  SizedBox(width: 10),

                  Text('Nuevo trabajo')

                ]

              ),

            ),

            appBar: AppBar(
            
              title: titloAppBar('Trabajos pendientes'),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,            

            ),

            body: SingleChildScrollView(

              child: SafeArea(

                child: Center(
                    
                  child: Column(

                    children: [

                      SizedBox(height: MediaQuery.of(context).size.height * 0.13),

                      Container(

                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.only(top: 60),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.43,
                        child: SvgPicture.asset('lib/images/empty..trabajos.svg'),

                      ),
                      
                      const Text('Cuando crees un nuevo trabajo aparecerá aquí')

                    ],

                  )
                  
                ),

              ),

            ),

          );

				}

				final scans = snapshot.data;

				return Scaffold(

          floatingActionButton: FloatingActionButton.extended(

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2,
            onPressed: _pasar,
            label: Row(
              
              children: const [

                Icon(Icons.handyman_outlined, color: Colors.white),

                SizedBox(width: 10),

                Text('Nuevo trabajo')

              ]

            ),

          ),

          backgroundColor: Colors.white,
          appBar: AppBar(
            
            title: titloAppBar('Trabajos pendientes'),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [

              IconButton(
					
                icon: const Icon(Icons.swipe_outlined, color: Colors.black87),
                onPressed: () => Navigator.pushNamed(context, 'finalizados')
                
              ),

            ],

          ),
				
					body: SingleChildScrollView(
					
						child: SafeArea(
					
							child: Column(
					
								children: [	

                  (scans!.isEmpty) 
                  ? Center(
                    
                    child: Column(

                      children: [

                        SizedBox(height: MediaQuery.of(context).size.height * 0.13),

                        Container(

                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.only(top: 60),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.43,
                          child: SvgPicture.asset('lib/images/empty..trabajos.svg'),

                        ),
                        
                        const Text('Cuando crees un nuevo trabajo aparecerá aquí')

                      ],

                    )
                    
                  )
                  : Container(

                  padding: const EdgeInsets.only(top: 20),
                  height: 700,
                  width: MediaQuery.of(context).size.width * 0.98,
                  child: 
                
                    ListView.builder(
          
                      itemCount: scans.length,
                      itemBuilder: (context, i) => Card(
            
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        elevation: 3,                        
                        child: ListTile(
                          
                          leading: const Icon(Icons.pending_actions_outlined),
                          title: Text(scans[i].tipo_trabajo, style: const TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Text(scans[i].nombre_cliente.toString()),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          iconColor: Colors.black87,

                          onTap: () {
                            
                            Navigator.pushNamed(context, 'detallesTrabajo',

                              arguments: [

                                scans[i].id,
                                scans[i].estado_actual,
                                scans[i].nombre_cliente,
                                scans[i].tipo_trabajo,
                                scans[i].direccion,
                                scans[i].observaciones,
                                scans[i].fecha,
                                      
                              ]
                            
                            );
                            
                          },                                                

                        ),
            
                      )
          
                    ),
                
                  )
      
                ],
      
              )
      
            ),

					),

				);

			}

    );

  }

  void _pasar() async{

    final cant = await DBProviderClientes.db.getTodasPersonas();

    (cant.isNotEmpty)
    ? Navigator.pushNamed(context, 'nuevoTrabajo')
    : mensajeInfo(context, 'Debe crear al menos un cliente antes de realizar esta acción');

  }

}
