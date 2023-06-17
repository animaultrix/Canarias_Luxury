import 'package:flutter/material.dart';
import 'package:proyecto_dam/generated/l10n.dart';

class CustomInputField extends StatelessWidget {
  final String? texto;
  final TextInputType? keyboardType;
  final String formProperty;
  final Map<String,dynamic> formValues;
  final int? altura;
  final String? initialValue;
  
  const CustomInputField({
    Key? key, 
    this.texto, 
    this.keyboardType, 
    required this.formProperty, 
    required this.formValues,
    this.altura, 
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
            
      maxLines: altura,
      initialValue: initialValue,
      keyboardType: keyboardType,
      //Añado el valor del textfield al mapa
      onChanged: (value) => formValues[formProperty] = value,
      //llama cuando se guarda el formulario permite guardar los valores de los campos
      onSaved: (value) {
        formValues[formProperty] = value;
      },
      validator: (value){
        if (value == '') return S.current.campoRequerido;
        return null;
        //return value.length < 1 ? 'mayor a uno' : null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,                
      decoration: InputDecoration(
        hintText: texto,
        labelText: texto,           
      ),                
    );
  }
}