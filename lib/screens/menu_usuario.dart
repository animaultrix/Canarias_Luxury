import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:proyecto_dam/firestore/firestore_obtener_fecha_estancia.dart';
import 'package:proyecto_dam/firestore/firestore_ver_cliente.dart';
import 'package:proyecto_dam/generated/l10n.dart';
import 'package:proyecto_dam/models/model_usuario.dart';
import 'package:proyecto_dam/screens/editar_usuario.dart';
import 'package:proyecto_dam/widgeds/texto.dart';


class MenuUsuario extends StatefulWidget {
  
  const MenuUsuario({super.key});

  @override
  State<MenuUsuario> createState() => _MenuUsuarioState();
}

class _MenuUsuarioState extends State<MenuUsuario> {

  String nombre="";
  String pasaporteDNI="";
  String telefono="";
  DateTime? _entrada;
  bool _fechaCargada = false;

  @override
  void initState() {
    super.initState();
    cargarDatos();    
  }

  Future<void> cargarDatos() async {
    final userModel = Provider.of<UsuarioModel>(context, listen: false);
    final String code = userModel.code;
    List<Map<String, dynamic>> cliente = await getCliente(code);
    if (cliente.isNotEmpty) {
      Map<String, dynamic> cuestionarioData = cliente[0]['cuestionarioData'] as Map<String, dynamic>;
      userModel.actualizarDatosUsuario(
        nombre: cuestionarioData['nombre'] ?? "",
        pasaporteDNI: cuestionarioData['pasaporte'] ?? "",
        telefono: cuestionarioData['telefono'] ?? ""
      );
    }
    DocumentSnapshot<Object?> estanciaSnapshot = await obtenerFechaEstancia(code);
    Map<String, dynamic> estanciaData = estanciaSnapshot.data() as Map<String, dynamic>;
    DateTime entrada = DateTime.fromMillisecondsSinceEpoch(estanciaData['entrada'].millisecondsSinceEpoch);
    setState(() {
      _entrada = entrada;
      _fechaCargada = true;
    });
  }


  @override
  Widget build(BuildContext context) { 
    final userModel = Provider.of<UsuarioModel>(context);  
    final String code = userModel.code; 
    String nombre = userModel.nombre;
    String pasaporteDNI = userModel.pasaporteDNI;
    String telefono = userModel.telefono;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(S.current.menuUsuario)),
        body: GestureDetector(
          onTap: () {
            //cerrar teclado al tocar fuera
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Consumer<UsuarioModel>(            
            builder: (context, userModel, child) {
              return SingleChildScrollView(
                child: Column(        
                  children: [               
                    //***** Nombre *****
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Texto(
                          texto: "${S.current.nombreUsuario}: ", 
                          tamano: 16, fontWeight: 
                          FontWeight.bold
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Texto(
                            texto: nombre, 
                            tamano: 16, 
                            margenes: const EdgeInsets.only(top:8,left: 50,right: 50),
                          )
                        )
                      ],
                    ),
                    //***** Numero de pasaporte o DNI *****
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Texto(
                          texto: S.current.numeropasaporte, 
                          tamano: 16, fontWeight: 
                          FontWeight.bold
                        )
                      ],
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Texto(
                            texto: pasaporteDNI, 
                            tamano: 16, 
                            margenes: const EdgeInsets.only(top:8,left: 50,right: 50),
                          )
                        )
                      ],
                    ),
                    //***** Numero de telefono *****
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Texto(
                          texto: S.current.numerotelefono, 
                          tamano: 16, fontWeight: 
                          FontWeight.bold
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Texto(
                            texto: telefono, 
                            tamano: 16, 
                            margenes: const EdgeInsets.only(top:8,left: 50,right: 50),
                          )
                        )
                      ],
                    ),
                    //***** Boton para editar datos *****
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditarUsuario(
                                nombre: nombre,
                                pasaporteDNI: pasaporteDNI,
                                telefono: telefono,
                              ),
                            ),
                          );
                        },
                        child: SizedBox( 
                          width: double.infinity, 
                          child: Center(child: Text(S.current.editarDatos))
                        ),
                      ),
                    ),
                    //Botón pre entrada
                    
                    if (_entrada != null && DateTime.now().isBefore(_entrada!.subtract(const Duration(days: 1))))
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/pre_entrada');
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Center(child: Text(S.current.preEntrada)),
                          ),
                        ),
                      ),         
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );    
  }
}