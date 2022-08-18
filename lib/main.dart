import 'src/allExports.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        title: 'Control de clientes',

        debugShowCheckedModeBanner: false,

        home: const HomePage(),
        initialRoute: '/',

        routes: <String, WidgetBuilder>{

          'allClientes'   : (context) => const AllClientesPage(),
          'allTrabajos'   : (context) => const TrabajosPage(),

          'nuevoCliente'  : (context) => const CrearClientePgae(),
          'nuevoTrabajo'  : (context) => const NuevoTrabajoPage(),
          'finalizados'  : (context) => const FinalizadosPage(),

        },

      onGenerateRoute: (settings) {
        if (settings.name == 'editarCliente') {
        
          final argumentos = settings.arguments as List;
          return MaterialPageRoute(builder: (_) => EditarClientePage(
            
            argumentos[0], 
            argumentos[1], 
            argumentos[2], 
            argumentos[3], 
            argumentos[4],
            argumentos[5]
            
          ));
        
        }else if(settings.name == 'detallesCliente'){
        
          final argumentos = settings.arguments as List;
          return MaterialPageRoute(builder: (_) => DetallesClientePage(
            
            argumentos[0], 
            argumentos[1], 
            argumentos[2], 
            argumentos[3],
            argumentos[4]
            
          ));
        
        }else if(settings.name == 'detallesTrabajo'){
        
          final argumentos = settings.arguments as List;
          return MaterialPageRoute(builder: (_) => DetallesTrabajosPage(
            
            argumentos[0], 
            argumentos[1], 
            argumentos[2], 
            argumentos[3], 
            argumentos[4],
            argumentos[5],
            argumentos[6],
                       
          ));
        
        }
        return null;
      },

    );
  }
}