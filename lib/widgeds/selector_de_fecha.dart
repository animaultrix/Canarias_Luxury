import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_dam/generated/l10n.dart';

class SelectorDeFecha extends StatefulWidget {
  final String labelText;
  final Function(DateTime) onDateSelected;

  SelectorDeFecha({required this.labelText, required this.onDateSelected});

  @override
  SelectorDeFechaState createState() => SelectorDeFechaState();
}

class SelectorDeFechaState extends State<SelectorDeFecha> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(labelText: widget.labelText),
      controller: _controller,
      onTap: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          minTime: DateTime.now().toLocal(), // Cambiado aquí,
          maxTime: DateTime(2100),
          onChanged: (date) {},
          onConfirm: (date) {
            setState(() {
              _controller.text = DateFormat('yyyy-MM-dd HH:mm').format(date);
              widget.onDateSelected(date);
            });
          },
          
          currentTime: DateTime.now(),
          locale: LocaleType.es, // Para mostrar el selector en español
        );
      },
      //
      validator: (value){
        if (value == '') return "Fecha requerida";
        //return value.length < 1 ? 'mayor a uno' : null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,  
    );
  }
}

