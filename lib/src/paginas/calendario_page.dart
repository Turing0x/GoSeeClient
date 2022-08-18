import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../allExports.dart';

class CalendarioPage extends StatefulWidget {
  const CalendarioPage({Key? key}) : super(key: key);

  @override
  State<CalendarioPage> createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {

  final List<Evento> lista_eventos = [];
  final List<Evento> eventosDiarios = [];

  final CalendarController _calendarController = CalendarController();

  @override
  void initState() {

    getEventos();

    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      body: SingleChildScrollView(

        child: SafeArea(
          
          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
      
            children: [
      
              Container(
      
                margin: const EdgeInsets.all(10),
                width: double.infinity,
                height: 510,
                child: _calendario()

              ),

              const SizedBox(height: 20),

              Container(margin: const EdgeInsets.only(left: 23),

                child: const Text('Eventos programados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                
              ),
      
              Container(

                margin: const EdgeInsets.all(10),
                width: double.infinity,
                height: 190,
                child: (eventosDiarios.isEmpty)
                        ? const Center(child: Text('Sin eventos'),)
                        : _crearLista(eventosDiarios)

              )
      
            ],
      
          )
          
        ),

      ),

    );

  }

  Widget _crearLista (List<Evento> evento) {

    return ListView.builder(

      itemCount: evento.length,
      itemBuilder: (context, i) => Card(

        elevation: 2,
        shape: const RoundedRectangleBorder(

          borderRadius: BorderRadius.only(

            topLeft: Radius.circular(30),
            bottomRight: Radius.circular(20),

          )

        ),

        child: ListTile(

          title: Text(evento[i].titulo),
          subtitle: Text(evento[i].nombre_cliente),

        )
      
      )

    );

  }

  Widget _calendario() {

    return SfCalendar(
                
      view: CalendarView.month,
      controller: _calendarController,                    
      dataSource: _getCalendarDataSource(),
      onSelectionChanged: ((calendarSelectionDetails) => eventosDiarios.clear()),
      onTap: (calendarTapDetails) async{
        
        String fecha = DateFormat.yMd().format(calendarTapDetails.date!); 

        final enFecha = await DBProviderEventos.db.getEvento(fecha);

        if(enFecha.isNotEmpty){

          for (var cadaUno in enFecha) {

            eventosDiarios.add(

              Evento(
                
                id: cadaUno.id,
                nombre_cliente: cadaUno.nombre_cliente,
                titulo: cadaUno.titulo , 
                fechaInicio: cadaUno.fechaInicio, 
                
              )

            );
            
          }

        }

        setState(() {
          
        });

      },

    );
    
  }

  getEventos() async{

    final lista = await DBProviderEventos.db.getTodosEventos();

    if(lista.isNotEmpty){

      for (var cadaUno in lista) {

        lista_eventos.add(

          Evento(
            
            id: cadaUno.id,
            nombre_cliente: cadaUno.nombre_cliente,
            titulo: cadaUno.titulo , 
            fechaInicio: cadaUno.fechaInicio,
            
          )

        );

        print(lista_eventos[0].fechaInicio);
      
      }

    }   

  }

  DataSource _getCalendarDataSource() {

    List<Appointment> appointments = <Appointment>[];

    int mes;
    int dia;
    int anno;

    for(int i = 0; i < lista_eventos.length; i++){
      
      mes = int.parse(lista_eventos[i].fechaInicio.split('/')[0]);
      dia = int.parse(lista_eventos[i].fechaInicio.split('/')[1]);
      anno = int.parse(lista_eventos[i].fechaInicio.split('/')[2]);

      appointments.add(
          
        Appointment(

          startTime: DateTime(anno, mes, dia),
          endTime: DateTime(anno, mes, dia).add(const Duration(hours: 2)),
          subject: lista_eventos[i].titulo,
          color: Colors.blue,
          startTimeZone: '',
          endTimeZone: '',

        )
      
      );

    }

    return DataSource(appointments);

  }

}

class DataSource extends CalendarDataSource {
 DataSource(List<Appointment> source) {
   appointments = source;
 }
}

