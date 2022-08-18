import 'package:go_see_client/src/allExports.dart';
import 'package:go_see_client/src/base_datos/eventos/dbEventos_provider.dart';
import 'package:go_see_client/src/bloc/eventos_bloc.dart';
import 'package:intl/intl.dart';

import '../base_datos/clientes/dbClientes_provider.dart' as dbClientes_provider;

class NuevoTrabajoPage extends StatefulWidget {
  const NuevoTrabajoPage({Key? key}) : super(key: key);

  @override
  State<NuevoTrabajoPage> createState() => _NuevoTrabajoPageState();
}

class _NuevoTrabajoPageState extends State<NuevoTrabajoPage> {

  final trabajosBloc = TrabajosBloc();
  final eventosBloc = EventosBloc();

  var uuid = const Uuid();

  String dropdownvalue_nombres = '';

  final trabajoCtrl = TextEditingController();
  final direccionCtrl = TextEditingController();
  final obsCtrl = TextEditingController();

  String numCelular = 'Seleccione un cliente';
  
  String _selectedFecha = DateFormat.yMMMd().format(DateTime.now());
  String _paraEvento = DateFormat.yMd().format(DateTime.now());

  final List<DropdownMenuItem<String>>? nombres = [
  
    const DropdownMenuItem(
    
      value: '',
    
      child: Text(''),
      
    )
  
  ];

  @override
  void initState() {
    
    getClientes();

    obsCtrl.text = 'Sin observaciones';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(

        title: titloAppBar('Nuevo trabajo'),
        automaticallyImplyLeading: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [

          IconButton(

            icon: const Icon(Icons.check_circle_outline, color: Colors.black87),
            onPressed: () {

              if(dropdownvalue_nombres == '' || trabajoCtrl.text == '' || direccionCtrl.text == '' || obsCtrl.text == ''){

                showToast('Por favor, complete la información referente al trabajo');

              }else {

                showDialog(
                  
                  context: context, 
                  builder: (context) => AlertDialog(

                    title: const Text('Confirmar decisión'),
                    content: const Text('Está seguro que desea añadir este trabajo a la lista de pendientes?'),
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
                        onPressed: () => _crearTrabajo()

                      ),

                    ],

                  ),
                  
                );
                
              }

            }

          ),

        ],

      ),

      body: SingleChildScrollView(
      
        child: SafeArea(

          child: Column(
          
            children: [

              Container(

                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),        
                child: Column(
        
                  mainAxisAlignment: MainAxisAlignment.center,
                                        
                  children: [

                    CrearCbField(
                
                      dropdownvalue: dropdownvalue_nombres, 
                      items: nombres, 
                      labelText: 'Seleccione un cliente:', 
                      onChange: ( valor ) => setState(() {

                        dropdownvalue_nombres = valor.toString();

                        if(dropdownvalue_nombres != '') getInfo(); 
                      
                      })    
                      
                    ),
                    
                    ListTile(
                    
                      title: Text(numCelular, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                      subtitle: const Text('Número de celular'),
                      trailing: IconButton(
                      
                        icon: Icon(Icons.call, color: Colors.blue[400]), 
                        color: Colors.blue[400],
                        onPressed: (numCelular == 'Seleccione un cliente')
                                    ? null
                                    : () => hacerLlamada(numCelular), 
                        
                      ),
                    
                    ),

                    CrearCustomTxt(
                    
                      hintText: 'Qué haremos?', 
                      labelText: 'Trabajo a realizar', 
                      helperText: '', 
                      counterText: 'Letras: ${trabajoCtrl.text.length}',
                      icon: Icon(Icons.work_outline, color: Colors.blue[400]), 
                      suffixIcon: Icon(Icons.precision_manufacturing_rounded, color: Colors.blue[400]), 
                      keyboardType: TextInputType.text, 
                      controlador: trabajoCtrl, 
                      readOnly: false,
                      maxLength: 30,
                      onChange: ( valor ) => setState(() {})  
                      
                    ),

                    const Divider(),

                    CrearCustomTxt(
                    
                      hintText: 'A donde iremos?', 
                      labelText: 'Dirección', 
                      helperText: '', 
                      counterText: 'Letras: ${direccionCtrl.text.length}',
                      icon: Icon(Icons.location_on, color: Colors.blue[400],),
                      suffixIcon: Icon(Icons.location_city, color: Colors.blue[400]), 
                      keyboardType: TextInputType.text, 
                      controlador: direccionCtrl, 
                      readOnly: false,
                      maxLength: 100,
                      onChange: ( valor ) => setState(() {})  
                      
                    ),

                    const Divider(),

                    ListTile(
                    
                      title: Text(_selectedFecha.toString(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                      subtitle: const Text('Establece la fecha para el trabajo'),
                      trailing: IconButton(
                      
                        icon: Icon(Icons.calendar_today_outlined, color: Colors.blue[400]), 
                        color: Colors.blue[400],
                        onPressed: (){ showDatePicker(
                        
                          context: context, 
                          initialDate: DateTime.now(), 
                          firstDate: DateTime(2022), 
                          lastDate: DateTime(2030),                          

                        ).then((DateTime? fecha) {
                        
                          if(fecha != null){

                            setState(() {

                              _selectedFecha = DateFormat.yMMMMd().format(fecha);
                              _paraEvento = DateFormat.yMd().format(fecha);

                            });
                          
                          }                        
                        
                        });
                        
                        }
                             
                      ),
                    
                    ),

                    const Divider(),
                                      
                    const Text('Observaciones sobre el trabajo:',

                      style: TextStyle(

                        color: Colors.blue,
                        fontSize: 16,

                      ),

                    ),

                    CrearTxtObs( 
                      
                      controlador: obsCtrl, 
                      maxLines: 8,
                      readOnly: false,
                      onChange: ( valor ) => setState(() {})
                      
                    ),

                  ],

                ),
            
              )

            ],
          
          ),

        ),
      
      )

    );

  }

  getClientes() async{

    List<Persona> personas = await dbClientes_provider.DBProviderClientes.db.getTodasPersonas();

    for(int i = 0; i < personas.length; i++){

      nombres?.add(DropdownMenuItem(
      
        value: personas[i].nombre,
      
        child: Text(personas[i].nombre),
        
      ));

    }

  }

  getInfo() async{
                          
    final info = await dbClientes_provider.DBProviderClientes.db.getPersona(dropdownvalue_nombres);

    direccionCtrl.text = info[0].direccion;

    setState(() => numCelular = info[0].numCelular.toString());

  }

  void _crearTrabajo() async{

    String id = uuid.v1();
  
    try {

      final trabajo = Trabajo(
      
        id            : id,
        estado_actual : 'Aún pendiente',
        nombre_cliente: dropdownvalue_nombres,
        tipo_trabajo  : trabajoCtrl.text,
        direccion     : direccionCtrl.text,
        fecha         : _selectedFecha,
        observaciones : obsCtrl.text

      );

      final evento = Evento(

        id            : id,
        nombre_cliente: dropdownvalue_nombres,
        titulo        : trabajoCtrl.text,
        fechaInicio   : _paraEvento,

      );

      trabajosBloc.agregarTrabajo(trabajo);
      eventosBloc.agregarEvento(evento);

      showToast('El registro de trabajo y la programación del evento para la fecha seleccionada han sido creados exitosamente');
      Navigator.pushReplacementNamed(context, '/');

    }catch(e){

      print(e);

    }
  
  }

}
