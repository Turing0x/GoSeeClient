import 'package:flutter/material.dart';

class CrearCustomTxt extends StatelessWidget {
  
  final String hintText;
  final String labelText;
  final String helperText;
  final String counterText;
  final bool readOnly;
  final int maxLength;

  final Widget icon;
  final Widget suffixIcon;

  final TextInputType keyboardType;

  final TextEditingController controlador;

  final Function(String?) onChange;

  const CrearCustomTxt({Key? key, 
    
    required this.hintText, 
    required this.labelText, 
    required this.helperText, 
    required this.counterText,  
    required this.readOnly,  
    required this.icon, 
    required this.suffixIcon, 
    required this.keyboardType,
    required this.controlador,
    required this.maxLength,
    required this.onChange
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextField(

      textCapitalization: TextCapitalization.sentences,

      decoration: InputDecoration(

        border: OutlineInputBorder(

          borderRadius: BorderRadius.circular(20),

        ),

        hintText    : hintText,
        labelText   : labelText,
        helperText  : helperText,
        suffixIcon  : suffixIcon,
        icon        : icon,
        counterText : counterText,

      ),

      keyboardType  : keyboardType,
      controller    : controlador,
      onChanged: onChange ,
      readOnly: readOnly,
      maxLength: maxLength,

    );
    
  }

}


//-----------------------------------------------------------------------


class CrearTxtObs extends StatelessWidget {

  final TextEditingController controlador;
  final Function(String?) onChange;
  final int? maxLines;
  final bool readOnly;

  const CrearTxtObs({Key? key, 
  
    required this.controlador, 
    required this.onChange,
    required this.maxLines,
    required this.readOnly
  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextField(

      decoration: InputDecoration(

          border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(20),

          ),

          counterText: 'Letras: ${controlador.text.length}'

      ),

      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.multiline,
      maxLines: maxLines,
      controller: controlador,
      onChanged: onChange,
      readOnly: readOnly,

    );

  }

}
