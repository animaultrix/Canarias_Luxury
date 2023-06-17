import 'package:flutter/material.dart';

class SelectorDeViviendas extends StatefulWidget {

  final Function(String?, String?) onOptionSelected;
  final List<Map<String, dynamic>> viviendas;
  SelectorDeViviendas({required this.onOptionSelected, required this.viviendas});

  @override
  _DropdownSelectorState createState() => _DropdownSelectorState();
}

class _DropdownSelectorState extends State<SelectorDeViviendas> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedOption,
      items: widget.viviendas.map((vivienda) {
        return DropdownMenuItem(
          child: Text(vivienda['nombre'] ?? 'Nombre no disponible'),
          value: vivienda['id'].toString(),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedOption = newValue;
        });
        Map<String, dynamic> viviendaSeleccionada = widget.viviendas.firstWhere(
         (vivienda) => vivienda['id'].toString() == newValue
        );
        widget.onOptionSelected(viviendaSeleccionada['nombre'], newValue);
      },
      isExpanded: true,
      hint: Text('Elegir vivienda'),
      validator: (value) {
        if (value == null) {
          return 'Por favor elige una vivienda';
        }
        return null;
      },
    );
  }
}
