import '../allExports.dart';

class CrearCbField extends StatelessWidget {
  
  final String labelText;
  final dropdownvalue;
  final List<DropdownMenuItem<Object>>? items;
  final Function(Object?) onChange;

  const CrearCbField(
    
    {Key? key, 
    required this.dropdownvalue, 
    required this.items, 
    required this.labelText, 
    required this.onChange
  
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.all(20),
      child: InputDecorator(

        decoration: InputDecoration(

          labelText: labelText,
          border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(5),

          ),
          contentPadding: const EdgeInsets.all(10)

        ),

        child: DropdownButton(

          value: dropdownvalue,
          isExpanded: true,
          underline: DropdownButtonHideUnderline(

            child: Container(),

          ),
          items: items,

          onChanged: onChange,

        ),

      ),

    );

  }

}