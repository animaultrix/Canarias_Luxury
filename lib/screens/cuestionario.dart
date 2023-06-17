import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam/firestore/firestore.dart';

import 'package:proyecto_dam/generated/l10n.dart';
import 'package:proyecto_dam/models/models.dart';
import 'package:proyecto_dam/widgeds/widgeds.dart';
import 'package:proyecto_dam/http/consulta_fecha.dart';

class Cuestionario extends StatelessWidget {

  //final String code;  
  //const Cuestionario({Key? key, required this.code}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    //obtiene el codigo de la estancia desde el provider dado en el login
    final String code = Provider.of<UsuarioModel>(context).code;
    final myFormKey = GlobalKey<FormState>();
    Map<String,dynamic> formValues = {};
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {//cerrar teclado al tocar fuera
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Form(
                key: myFormKey, 
                child: Column(              
                  children: [
                    Texto(texto: S.current.cuestionario,tamano: 18),
                    CustomInputField(texto: S.current.nombreUsuario, keyboardType: TextInputType.name,formProperty: 'nombre', formValues: formValues,),
                    const SizedBox(height: 30,),
                    CustomInputField(texto: S.current.numeropasaporte, keyboardType: TextInputType.name,formProperty: 'pasaporte', formValues: formValues,),
                    const SizedBox(height: 30,),
                    CustomInputField(texto: S.current.numerotelefono, keyboardType: TextInputType.number,formProperty: 'telefono', formValues: formValues,),
                    const SizedBox(height: 30,),
                    BotonGuardar(texto: S.current.guardar,formKey: myFormKey, code:code, formValues: formValues,)
                  ],
                ),
              ),
            ),
          ),
        ),
       ),
    );
  }
}
/*.................

Boton guardar

''''''''''''''''''*/
class BotonGuardar extends StatelessWidget {

  final String texto;
  final GlobalKey<FormState> formKey;
  final String code;
  final Map<String, dynamic> formValues;
  const BotonGuardar({
    Key? key, 
    required this.texto,
    required this.formKey,
    required this.code,
    required this.formValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Clave para validar el formulario
    
    return SizedBox(
      width: double.infinity,               
      child: ElevatedButton (                        
        child:  Text(texto),
        onPressed: () async{
          FocusManager.instance.primaryFocus?.unfocus();
          if(!formKey.currentState!.validate()){//segunda!para asegurar que no llegara null
            return;//dispara validaciones de los textfield
          }
          // Obtener el correo electrónico de la colección 'estancia' utilizando el código proporcionado (asumiendo que lo tienes disponible en una variable 'code')
          String? email;
          await FirebaseFirestore.instance
                  .collection('estancia')
                  .doc(code)
                  .get()
                  .then((snapshot) {
                if (snapshot.exists) {
                  email = snapshot.data()?['mail'];
                }
              });
          if (email != null) {
                // Llama a la función crearCliente
                await crearCliente(email: email!, cuestionarioData: formValues, code: code);
                // Navega a la siguiente página si es necesario
                Navigator.pushReplacementNamed(context, '/menu');
              } else {
                print("Error al obtener el correo electrónico del cliente");
              }
        }
      )
    );
  }
  Future<void> crearCliente({
  required String email,
  required Map<String, dynamic> cuestionarioData,
  required String code,
  }) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference clientes = firestore.collection('cliente');

    return clientes.add({
      'email': email,
      'cuestionarioData': cuestionarioData,
      'code': code,
    }).then((_) {
      // Puedes manejar el resultado de la operación aquí si es necesario.
    });
  }



}