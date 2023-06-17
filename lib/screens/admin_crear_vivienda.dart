import 'package:flutter/material.dart';
import 'package:proyecto_dam/firestore/firestore.dart';
import 'package:proyecto_dam/widgeds/widgeds.dart';

class AdminCrearVivienda extends StatelessWidget {
  const AdminCrearVivienda({super.key});


  @override
  Widget build(BuildContext context) {

    final myFormKey = GlobalKey<FormState>();
   

    final Map<String,dynamic> formValues ={
      'nombre': "",
      'latitud': "",
      'longitud': "",
      'info': "",
    };
    return Scaffold(
      appBar: AppBar(
          title: const Text('Crear vivienda')),
      body: GestureDetector(
        onTap: () {
          //FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Form(//para validar los campos y guardar los datos en el formValues de la clase padre
              key: myFormKey,
              child: Column(
                
                children: [
                  CustomInputField(texto: 'Nombre', formProperty: 'nombre', formValues: formValues,),
                  const SizedBox(height: 30,),
                  CustomInputField(texto: 'Latitud',keyboardType: TextInputType.number, formProperty: 'latitud', formValues: formValues),
                  const SizedBox(height: 30,),   
                  CustomInputField(texto: 'Longitud',keyboardType: TextInputType.number, formProperty: 'longitud', formValues: formValues ),
                  const SizedBox(height: 30,),
                  CustomInputField(texto: 'Información adicional', formProperty: 'info', formValues: formValues),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                    
                    child: const Text('Guardar'),
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      print("presiona boton guardar dato");                        
                        print ("datos--> $formValues");
                      if(!myFormKey.currentState!.validate()){//segunda!para asegurar que no llegara null
                        print("noguardar datos");
                        return;//dispara validaciones de los textfield
                      }                        
                      //myFormKey.currentState!.save();
                      //validar que los datos no esten vacios
                      if(formValues['nombre']!.isNotEmpty && formValues['latitud']!.isNotEmpty && formValues['longitud']!.isNotEmpty && formValues['info']!.isNotEmpty){
                        print("guardar datos");
                        crearVivienda(formValues);//enviar datos al servidor firestore                        
                        //enviar datos al servidor firestore
                        Navigator.pop(context);//cerrar la ventana
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Vivienda guardada'),
                                                duration: Duration(seconds: 2)
                            )
                        );
                      }
                      print(formValues); 
                    }, 
                  ),
                ],
              ),
            ),
        ),
           ),
      ),
   );
  }
}

