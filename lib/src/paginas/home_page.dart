import '../allExports.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _callPage(currentIndex),

      bottomNavigationBar: _crearbarranavegacion(),

    );
  }

  Widget _crearbarranavegacion(){

    return BottomNavigationBar(

      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: const [

        BottomNavigationBarItem(
          icon: Icon(Icons.work_outline_rounded),
          label: 'Trabajos',
        ),

        BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            label: 'Clientes'
        ),

        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calendario'
        ),

      ],

    );

  }

  Widget _callPage(int paginaActual){

    switch(paginaActual){

      case 0: return const TrabajosPage();
      case 1: return const AllClientesPage();
      case 2: return const CalendarioPage();
      default: return const TrabajosPage();

    }

  }

}
