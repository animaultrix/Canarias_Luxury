import 'package:flutter/material.dart';

import 'package:proyecto_dam/firestore/firestore.dart';
import 'package:proyecto_dam/widgeds/widgeds.dart';

class CrearEstancia extends StatefulWidget {
  const CrearEstancia({super.key});

  @override
  State<CrearEstancia> createState() => _CrearEstanciaState();
}

class _CrearEstanciaState extends State<CrearEstancia> {
  @override
  Widget build(BuildContext context) {

    //Clave para validar el formulario
    final myFormKey = GlobalKey<FormState>();

    //Funcion para generar el codigo de la estancia
    String generateCode(String email, int id) {
      String leftPart = email.split('@')[0];
      return '$leftPart@$id';
    }
    //Mapa para guardar los valores de los campos
    final Map<String,dynamic> formValues ={
      'id': '',
      'mail': "",
      'entrada': "",
      'salida': "",
      'vivienda': "",
      'code': "",
      'id_vivienda': "",
    };
    var _selectedOption;
    return Scaffold(
      appBar: AppBar(title: const Text('Crear estancia')),
      body:GestureDetector(
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
                  /*.................
                  
                  Campo de texto de email
                  
                  ''''''''''''''''''*/
                  CustomInputField(texto: 'Correo', keyboardType: TextInputType.emailAddress,formProperty: 'mail', formValues: formValues,),
                  const SizedBox(height: 30,),
                  /*.................
                  
                  Selectores de fechas
                  
                  ''''''''''''''''''*/
                  SelectorDeFecha(
                    labelText: 'Entrada',
                    onDateSelected: (date) {
                      formValues['entrada'] = date.toString();
                    },
                  ),  

                  const SizedBox(height: 30,),   

                  SelectorDeFecha(
                    labelText: 'Salida',
                    onDateSelected: (date) {
                      formValues['salida'] = date.toString();
                    },
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      Expanded(
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                        future: getViviendas(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error al cargar las viviendas');
                          } else {
                            return SelectorDeViviendas(
                              onOptionSelected: (option, id) {
                                formValues['vivienda'] = option;
                                formValues['id_vivienda'] = id;
                              },
                              viviendas: snapshot.data!,
                            );
                          }
                        },
                      ),
                    ),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  /*.................
                  
                  Boton crear estancia
                  
                  ''''''''''''''''''*/
                  SizedBox(

                    width: double.infinity,
                    child: ElevatedButton(                      
                      child: const Text('Crear estancia'),
                      
                      onPressed: () async{
                        FocusManager.instance.primaryFocus?.unfocus();
                        if(!myFormKey.currentState!.validate()){//segunda!para asegurar que no llegara null
                          return;//dispara validaciones de los textfield
                        }

                        // Realiza las validaciones antes de llamar a crearEstancia
                        if(formValues['mail']!.isNotEmpty && formValues['entrada']!.isNotEmpty && formValues['salida']!.isNotEmpty){
                          
                          // Generar el código antes de llamar a crearEstancia
                          String email = formValues['mail'];
                          int id = await getNextId('estancia'); // Obtener el próximo ID autoincremental
                          String code = generateCode(email, id);
                          formValues['code'] = code;
                          // Pasar el código a la función crearEstancia
                          crearEstancia(formValues, code);
                          Navigator.pop(context);//cerrar la ventana
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Estancia creada correctamente'),
                                                  duration: Duration(seconds: 2)
                              )
                          );
                        }
                        print(formValues); 
                      }, 
                    ),
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