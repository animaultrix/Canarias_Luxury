import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam/firestore/firestore.dart';
import 'package:proyecto_dam/generated/l10n.dart';
import 'package:proyecto_dam/models/model_usuario.dart';
import 'package:proyecto_dam/widgeds/widgeds.dart';


class EditarUsuario extends StatelessWidget {
  final String nombre;
  final String pasaporteDNI;
  final String telefono;

  const EditarUsuario({
    Key? key,
    required this.nombre,
    required this.pasaporteDNI,
    required this.telefono,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    //obtiene el codigo de la estancia desde el provider dado en el login
    final String code = Provider.of<UsuarioModel>(context).code;
    final myFormKey = GlobalKey<FormState>();
    Map<String,dynamic> formValues = {};
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(S.current.editarDatos)),
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
                    //***** Nombre *****
                    CustomInputField(
                      texto: S.current.nombreUsuario, 
                      keyboardType: TextInputType.name,
                      formProperty: 'nombre', 
                      formValues: formValues,
                      initialValue: nombre
                    ),
                    const SizedBox(height: 30,),
                    //***** Pasaporte o DNI *****
                    CustomInputField(
                      texto: S.current.numeropasaporte, 
                      keyboardType: TextInputType.name,
                      formProperty: 'pasaporte', 
                      formValues: formValues,
                      initialValue: pasaporteDNI
                    ),
                    const SizedBox(height: 30,),
                    //***** Teléfono *****
                    CustomInputField(
                      texto: S.current.numerotelefono, 
                      keyboardType: TextInputType.number,
                      formProperty: 'telefono', 
                      formValues: formValues,
                      initialValue: telefono
                    ),
                    const SizedBox(height: 30,),
                    //***** Botón *****
                    BotonActualizar(
                      texto: S.current.guardar,
                      formKey: myFormKey, code:code, 
                      formValues: formValues,
                    )
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
class BotonActualizar extends StatelessWidget {

  final String texto;
  final GlobalKey<FormState> formKey;
  final String code;
  final Map<String, dynamic> formValues;

  const BotonActualizar({
    Key? key, 
    required this.texto,
    required this.formKey,
    required this.code,
    required this.formValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      width: double.infinity,               
      child: ElevatedButton (                        
        child:  Text(texto),
        onPressed: () async{
          final userModel = Provider.of<UsuarioModel>(context, listen: false);
          final scaffoldMessenger = ScaffoldMessenger.of(context);
          final navigator = Navigator.of(context);
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();

            await updateCliente(code, formValues);
            scaffoldMessenger.showSnackBar(
              SnackBar(content: Text(S.current.datosActualizados)),
            );
            
            userModel.actualizarDatosUsuario(
              nombre: formValues['nombre'],
              pasaporteDNI: formValues['pasaporte'],
              telefono: formValues['telefono'],
            );
            navigator.pop();
          }
        }
      )
    );
  }
}