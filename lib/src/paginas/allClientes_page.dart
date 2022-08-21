import 'package:flutter_svg/flutter_svg.dart';
import '../allExports.dart';

class AllClientesPage extends StatefulWidget {
  const AllClientesPage({Key? key}) : super(key: key);

  @override
  State<AllClientesPage> createState() => _AllClientesPage();
}

class _AllClientesPage extends State<AllClientesPage> {

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Persona>>(

			future: DBProviderClientes.db.getTodasPersonas(),
			builder: (BuildContext context, AsyncSnapshot<List<Persona>> snapshot) {
        
				if (!snapshot.hasData) {
          
					return Scaffold(

            floatingActionButton: FloatingActionButton.extended(

              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 2,
              onPressed: () => Navigator.pushReplacementNamed(context, 'nuevoCliente'),
              label: Row(
                
                children: const [

                  Icon(Icons.person_add_alt, color: Colors.white),

                  SizedBox(width: 10),

                  Text('Nuevo cliente')

                ]

              ),

            ),

            backgroundColor: Colors.white,
            appBar: AppBar(
              
              title: titloAppBar('Listado de clientes'),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,            
              
            ),

            body: SingleChildScrollView(

              child: SafeArea(

                child: Center(
                    
                  child: Column(

                    children: [

                      SizedBox(height: MediaQuery.of(context).size.height * 0.15),

                      Container(

                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.only(top: 60),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.38,
                        child: SvgPicture.asset('lib/images/empty..clientes.svg'),

                      ),
                      
                      const Text('Cuando crees un nuevo cliente aparecerá aquí')

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
            onPressed: () => Navigator.pushReplacementNamed(context, 'nuevoCliente'),
            label: Row(
              
              children: const [

                Icon(Icons.person_add_alt, color: Colors.white),

                SizedBox(width: 10),

                Text('Nuevo cliente')

              ]

            ),

          ),

          backgroundColor: Colors.white,
          appBar: AppBar(
            
            title: titloAppBar('Listado de clientes'),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,            
            
          ),
				
					body: SingleChildScrollView(
					
						child: SafeArea(
					
							child: Column(
					
								children: [						
					
                  (scans!.isEmpty) 
                  ? Center(
                    
                    child: Column(

                      children: [

                        SizedBox(height: MediaQuery.of(context).size.height * 0.15),

                        Container(

                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.only(top: 60),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.38,
                          child: SvgPicture.asset('lib/images/empty..clientes.svg'),

                        ),
                        
                        const Text('Cuando crees un nuevo cliente aparecerá aquí')

                      ],

                    )
                    
                  )
                  : Container(

                    padding: const EdgeInsets.only(top: 20),
                    height:  MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width * 0.98,
                    child: ListView.builder(
                                    
                      itemCount: scans.length,
                      itemBuilder: (context, i) => Card(
                            
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        elevation: 2,
                        child: ListTile(
                            
                          leading: const Icon(Icons.account_circle_outlined),
                          title: Text(scans[i].nombre, style: const TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Text(scans[i].numCelular.toString()),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          iconColor: Colors.black87,
                            
                          onTap: () async{

                            List<Trabajo> encontrados = await DBProviderTrabajos.db.getPersonaTrabajos(scans[i].nombre);
                            
                            // ignore: use_build_context_synchronously
                            Navigator.pushNamed(context, 'detallesCliente',
                  
                              arguments: [
                          
                                scans[i].nombre,
                                scans[i].numCelular,
                                scans[i].direccion,
                                scans[i].observaciones,
                                encontrados
                                      
                              ]
                            
                            );
                            
                          },
                            
                        ),
                            
                      )
                            
                    ),

                  ),
					
								],
					
							)
					
						),

					),

				);

			}

    );

  }

}