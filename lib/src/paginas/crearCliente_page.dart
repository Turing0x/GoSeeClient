import '../allExports.dart';

class CrearClientePgae extends StatefulWidget {
  const CrearClientePgae({Key? key}) : super(key: key);

  @override
  State<CrearClientePgae> createState() => _CrearClientePgaeState();

}

class _CrearClientePgaeState extends State<CrearClientePgae> {

  final clientesBloc = ClientesBloc();

  final nombreCtrl = TextEditingController();
  final celularCtrl = TextEditingController();
  final direccionCtrl = TextEditingController();
  final obsCtrl = TextEditingController();

  @override
  void initState() {

    obsCtrl.text = 'Sin observaciones';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,      
      appBar: AppBar(
        
        title: titloAppBar('Crear cliente'),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,

        actions: [

          IconButton(

            onPressed: () => _crearCliente(),
            
            icon: const Icon(Icons.save_outlined, color: Colors.black,)
                    
          )

        ],
        
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
                  
                    CrearCustomTxt(
                    
                      hintText: 'Cuál es su nombre?',
                      labelText: 'Nombre',
                      helperText: 'Nombre del cliente',
                      suffixIcon: const Icon(Icons.accessibility, color: Colors.blue),
                      icon: const Icon(Icons.account_circle, color: Colors.blue),
                      counterText: 'Letras: ${nombreCtrl.text.length}',
                      keyboardType: TextInputType.name,
                      controlador: nombreCtrl,
                      readOnly: false,
                      maxLength: 25,
                      onChange: ( valor ) => setState(() {})                
                    
                    ),

                    const Divider(),
                    const SizedBox(height: 20,),

                    CrearCustomTxt(
                    
                      hintText: 'Número de celular del cliente',
                      labelText: 'Localizarlo por vía telefónica',
                      helperText: 'Número para llamadas o SMS',
                      suffixIcon: const Icon(Icons.call, color: Colors.blue),
                      icon: const Icon(Icons.phone_android, color: Colors.blue),
                      counterText: 'Letras: ${celularCtrl.text.length}',
                      keyboardType: TextInputType.phone,
                      controlador: celularCtrl,
                      readOnly: false,
                      maxLength: 8,
                      onChange: ( valor ) => setState(() {})                
                    
                    ),

                    const Divider(),
                    const SizedBox(height: 20,),

                    CrearCustomTxt(
                    
                      hintText: 'Dirección particular del cliente',
                      labelText: 'Dirección',
                      helperText: 'Donde encontrarlo...',
                      suffixIcon: const Icon(Icons.location_city, color: Colors.blue),
                      icon: const Icon(Icons.location_on, color: Colors.blue),
                      counterText: 'Letras: ${direccionCtrl.text.length}',
                      keyboardType: TextInputType.streetAddress,
                      controlador: direccionCtrl,
                      readOnly: false,
                      maxLength: 100,
                      onChange: ( valor ) => setState(() {})                
                    
                    ),

                    const Divider(),
                    const SizedBox(height: 20,),

                    const Text('Observaciones sobre el cliente:',

                      style: TextStyle(

                        color: Colors.blue,
                        fontSize: 16,

                      ),

                    ),

                    CrearTxtObs( 
                      
                      controlador: obsCtrl, 
                      maxLines: 13,
                      readOnly: false,
                      onChange: ( valor ) => setState(() {})
                      
                    ),

                  ],

                ),
            
              )
                  
            ]
              
          ),

        ),

      )  
      
    );

  }

  void _crearCliente() async{
  
    try {

      if(nombreCtrl.text == '' || celularCtrl.text == '53000000' || direccionCtrl.text == '' || obsCtrl.text == ''){

        showToast('Por favor, complete la información referente al cliente');

      }else if(await DBProviderClientes.db.saberSiExiste(int.parse(celularCtrl.text))){
      
        showToast('Ya existe un cliente con este número de celular, debe cambiarlo ');
      
      }else {

        showDialog(
                
          context: context, 
          builder: (context) => AlertDialog(

            title: const Text('Confirmar decisión'),
            content: const Text('Está seguro que desea crear el registro con los datos establecidos?'),
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
                onPressed: () {

                  final persona = Persona(

                    nombre: nombreCtrl.text,
                    numCelular: int.parse( celularCtrl.text ),
                    direccion: direccionCtrl.text,
                    observaciones: obsCtrl.text

                  );

                  clientesBloc.agregarCliente(persona);
                  showToast('Contacto creado exitosamente');
                  Navigator.pushReplacementNamed(context, '/');

                }, 

              ),

            ],

          ),
          
        );        

      }

    }catch(e){

      print(e);

    }
  
  }

}