import '../allExports.dart';

class EditarClientePage extends StatefulWidget {

  final String nombre, direccion, observaciones;
  final int numCelular, para_eliminar;
  final bool tieneTrabajos;

  const EditarClientePage(
  
    this.nombre, 
    this.numCelular, 
    this.direccion, 
    this.observaciones, 
    this.para_eliminar, 
    this.tieneTrabajos, 
    {Key? key

  }) : super(key: key);

  @override
  State<EditarClientePage> createState() => _EditarClientePageState();
}

class _EditarClientePageState extends State<EditarClientePage> {

  final clientesBloc = ClientesBloc();
  final trabajosBloc = TrabajosBloc();

  TextEditingController _cambianombre = TextEditingController();
  TextEditingController _cambiacelular = TextEditingController();
  TextEditingController _cambiadireccion = TextEditingController();
  TextEditingController _cambiaobs = TextEditingController();

  @override
  void initState() {
    _cambianombre = TextEditingController(text: widget.nombre);
    _cambiacelular = TextEditingController(text: widget.numCelular.toString());
    _cambiadireccion = TextEditingController(text: widget.direccion);
    _cambiaobs = TextEditingController(text: widget.observaciones);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
        elevation: 0,

        title: Text(widget.nombre, style: const TextStyle(

          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold
    
        ),),

        actions: [

          IconButton(

            icon: const Icon(Icons.delete_outline, color: Colors.black87),
            onPressed: () {

              showDialog(
                          
                context: context, 
                builder: (context) => AlertDialog(

                  title: const Text('Confirmar decisión'),
                  content: const Text('Está seguro que desea eliminar este cliente?'),
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
                      onPressed: () async{

                        if(widget.tieneTrabajos){

                          final listaTrabajos = await DBProviderTrabajos.db.getPersonaTrabajos(widget.nombre);

                          for(var ids in listaTrabajos){

                            trabajosBloc.eliminarTrabajo(ids.id);

                          }                          

                        }

                        clientesBloc.eliminarCliente(widget.para_eliminar);
                        showToast('Contacto eliminado exitosamente');
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(context, '/');

                      }, 

                    ),

                  ],

                ),
                
              );

            },

          ),

          IconButton(

            icon: const Icon(Icons.check_circle_outline, color: Colors.black87),
            onPressed: (){

              showDialog(
                          
                context: context, 
                builder: (context) => AlertDialog(

                  title: const Text('Confirmar decisión'),
                  content: const Text('Está seguro que desea editar la información?'),
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
                      onPressed: () => _editarCliente()

                    ),

                  ],

                ),
                
              );

            }

          ),

        ],

      ),

      body: SingleChildScrollView(

        child: SafeArea(

          child: Column(
              
            children: [
                            
              Container(

                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),  
                color: Colors.white,      
                child: Column(
        
                  mainAxisAlignment: MainAxisAlignment.center,
                      
                  children: [
                  
                    CrearCustomTxt(
                    
                      hintText: 'Cuál es su nombre?',
                      labelText: 'Nombre',
                      helperText: 'Nombre del cliente',
                      suffixIcon: const Icon(Icons.accessibility, color: Colors.blue),
                      icon: const Icon(Icons.account_circle, color: Colors.blue),
                      counterText: 'Letras: ${_cambianombre.text.length}',
                      keyboardType: TextInputType.name,
                      controlador: _cambianombre,
                      readOnly: true,
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
                      counterText: 'Letras: ${_cambiacelular.text.length}',
                      keyboardType: TextInputType.phone,
                      controlador: _cambiacelular,
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
                      counterText: 'Letras: ${_cambiadireccion.text.length}',
                      keyboardType: TextInputType.streetAddress,
                      controlador: _cambiadireccion,
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
                      
                      controlador: _cambiaobs, 
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

  void _editarCliente(){
  
    try {

      if(_cambianombre.text == '' || _cambiacelular.text == '53000000' || _cambiadireccion.text == '' || _cambiaobs.text == ''){

        showToast('Por favor, complete la información referente al cliente');

      }else {

        clientesBloc.eliminarCliente(widget.para_eliminar);

        final persona = Persona(

            nombre: _cambianombre.text,
            numCelular: int.parse(_cambiacelular.text),
            direccion: _cambiadireccion.text,
            observaciones: _cambiaobs.text

        );

        clientesBloc.agregarCliente(persona);
        showToast('Contacto editado exitosamente');
        Navigator.pushReplacementNamed(context, '/');


      }

    }catch(e){

      print(e);

    }
  
  }


}