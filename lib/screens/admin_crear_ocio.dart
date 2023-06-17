import 'package:flutter/material.dart';
import 'package:proyecto_dam/firestore/firestore.dart';
//import 'package:proyecto_dam/firestore/firestore_crear_ocio.dart';
//import 'package:proyecto_dam/service/select_image.dart';
import 'package:proyecto_dam/widgeds/widgeds.dart';
import 'dart:io';
import 'package:proyecto_dam/funcion/funcion.dart';
import 'package:image_picker/image_picker.dart';

class AdminCrearOcio extends StatefulWidget {
  const AdminCrearOcio({super.key});  

  @override
  State<AdminCrearOcio> createState() => _AdminCrearOcioState();
}

class _AdminCrearOcioState extends State<AdminCrearOcio> {

  File? image_to_upload;
  //revisar campos
  final picker = ImagePicker();
  bool isImageSelected = false;
  String imageError = ''; 
  final Map<String,dynamic> formValues ={
  'nombre': '',
  'descripcion': '',
  'precio': '',
  };
final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    //final myFormKey = GlobalKey<FormState>(); 
    final Map<String,dynamic> formValues ={};
    return Scaffold(
      appBar: AppBar(title: const Text('Crear ocio')),
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
                  CustomInputField(texto: 'Descripción',keyboardType: TextInputType.multiline, formProperty: 'descripcion', formValues: formValues, altura: 5),
                  const SizedBox(height: 30,),   
                  CustomInputField(texto: 'Precio',keyboardType: TextInputType.number, formProperty: 'precio', formValues: formValues ),
                  const SizedBox(height: 30,),
                  //mostrar imagen
                  image_to_upload != null ? Image.file(image_to_upload!)
                      : Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.image,
                            color: Colors.grey,
                            size: 100,
                          ),                          
                      ),
                      //mensaje de error de la imagen
                      imageError.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            imageError,
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 30,),
                  //seleccionar imagen
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(                    
                      onPressed: () async{
                        final image = await getImage();
                        setState(() {
                          image_to_upload = File(image!.path);
                        });
                      },
                      child: const Text('Seleccionar imagen'),
                    ),
                  ),                  
                  const SizedBox(height: 30,),
                  //boton crear
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(   
                                      
                      child: const Text('Crear'),
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();

                        // Validar la imagen
                        bool isImageValid = true;
                        if (image_to_upload == null) {
                          setState(() {
                            imageError = 'Por favor, seleccione una imagen';
                          });
                          isImageValid = false;
                        } else {
                          setState(() {
                            // Limpiar el mensaje de error de la imagen si se selecciona una imagen válida
                            imageError = ''; 
                          });
                        }
                        // Guarda los valores del formulario antes de realizar la validación
                        myFormKey.currentState!.save();

                        bool isFormValid = myFormKey.currentState!.validate();

                        if (!isFormValid || !isImageValid) {
                          print("noguardar datos");
                          return;
                        }
                        if (formValues['nombre']!.isNotEmpty &&
                            formValues['descripcion']!.isNotEmpty &&
                            formValues['precio']!.isNotEmpty) {
                          crearOcio(formValues, image_to_upload); //enviar datos al servidor firestore
                          //enviar datos al servidor firestore
                          Navigator.pop(context); //cerrar la ventana
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Ocio creado correctamente'),
                              duration: Duration(seconds: 2)));
                        }
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