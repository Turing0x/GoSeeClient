import 'package:flutter_svg/flutter_svg.dart';
import '../allExports.dart';

class FinalizadosPage extends StatefulWidget {
  const FinalizadosPage({Key? key}) : super(key: key);

  @override
  State<FinalizadosPage> createState() => _FinalizadosPageState();
}

class _FinalizadosPageState extends State<FinalizadosPage> {

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<List<Trabajo>>(

			future: DBProviderTrabajos.db.getFinalizados(),
			builder: (BuildContext context, AsyncSnapshot<List<Trabajo>> snapshot) {

        if (!snapshot.hasData) {
					return const Center(child: CircularProgressIndicator());
				}

				final scans = snapshot.data;

				return Scaffold(

          backgroundColor: Colors.white,
          appBar: AppBar(
            
            title: titloAppBar('Trabajos finalizados'),
            automaticallyImplyLeading: true,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,
            
          ),
				
					body: SingleChildScrollView(
					
						child: SafeArea(
					
							child: Column(
					
								children: [
					        
                  const SizedBox(height: 20,),

                  (scans!.isEmpty) 
                  ? Center(
                    
                    child: Column(

                      children: [

                        SizedBox(height: MediaQuery.of(context).size.height * 0.13),

                        Container(

                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.only(top: 60),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: SvgPicture.asset('lib/images/empty..finalizados.svg'),

                        ),
                        
                        const Text('Finaliza alguno de tus trabajos y aparecerá aquí')

                      ],

                    )
                    
                  )
                  : SizedBox(

                  height: 700,
                  width: MediaQuery.of(context).size.width * 0.98,
                  child: 
                
                    ListView.builder(
          
                      itemCount: scans.length,
                      itemBuilder: (context, i) => Card(
            
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        elevation: 2,
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

}
