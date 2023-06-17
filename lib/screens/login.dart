import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proyecto_dam/firestore/firestore.dart';
import 'package:proyecto_dam/funcion/funcion.dart';
import 'package:proyecto_dam/generated/l10n.dart';
import 'package:proyecto_dam/http/consulta_fecha.dart';
import 'package:proyecto_dam/models/models.dart';
import 'package:proyecto_dam/screens/screens.dart';
import 'package:proyecto_dam/widgeds/widgeds.dart';

class Login extends StatelessWidget {
  final showErrorNotifier = ValueNotifier<bool>(false);
  final loadingNotifier = ValueNotifier<bool>(false);
  final userNotFoundErrorNotifier = ValueNotifier<bool>(false);

  // Controlador de texto para el campo de texto del código de usuario
  final code = TextEditingController();
  final ClienteExistente clienteExistente = ClienteExistente();
  //ValueNotifier comparte entre múltiples widgets o sirve cuando se necesita
  //actualizar una respuesta a eventos del usuario
  // ValueNotifier aqui maneja el cambio de la fecha del cliente
  //final fechaClienteNotifier = ValueNotifier<DateTime?>(null);

  String userInput = '';
  Login({super.key});

  // Función para manejar la lógica y redireccionar al cuestionario si corresponde
  Future<String> handleLogicAndRedirect(DateTime fechaCliente) async {
    // Obtener la fecha actual en Canarias
    DateTime fechaCanarias = await getCurrentTimeInCanarias();

    // Comprobar si la fecha actual en Canarias es anterior a la fecha del cliente
    if (fechaCanarias.isBefore(fechaCliente)) {
      return 'cuestionario';
    } else {
      print(
          "La fecha actual en Canarias no es anterior a la fecha del cliente");
      return 'none';
    }
  }

  // Función para manejar la lógica y redireccionar al menú de administrador o empleado si corresponde
  Future<String> handleLogicAndRedirectWithoutDate(String userInput) async {
    String admin = await getAdminCredencial();
    String empleado = await getEmpleadoCredencial();

    if (admin == userInput) {
      return 'admin';
    } else if (empleado == userInput) {
      return 'empleado';
    } else {
      print("No se cumplió ninguna condición");
      return 'none';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Cabecera(),
                //Expanded(child: Container(color: Colors.red)),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                /*.................
        
                  CodigoCodigoUsuarioioio
        
                  ''''''''''''''''''*/
                Column(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 50, left: 50, right: 50),
                      child: TextField(
                        controller: code,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: S.current.codigoUsuario,
                        ),
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: userNotFoundErrorNotifier,
                      builder: (context, showUserNotFoundError, child) {
                        if (showUserNotFoundError) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text(
                              'Usuario no existe',
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        } else {
                          return const SizedBox
                              .shrink(); // No muestra nada si showUserNotFoundError es falso
                        }
                      },
                    )
                  ],
                ),
                /*.................
        
                  Botonn
        
                  ''''''''''''''''''*/
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 50, left: 50, right: 50),
                  child: ValueListenableBuilder<bool>(
                      valueListenable: loadingNotifier,
                      builder: (context, isLoading, child) {
                        return ElevatedButton(
                          child: Text(S.current.entrar),
                          onPressed: () async {
                            userNotFoundErrorNotifier.value = false;
                            loadingNotifier.value = true;
                            userInput = code.text;
                            DateTime fechaCanarias =
                                await getCurrentTimeInCanarias();

                            if (fechaCanarias == DateTime.utc(2970, 1, 1)) {
                              // Muestra el mensaje de error
                              showErrorNotifier.value = true;
                            } else {
                              // Oculta el mensaje de error
                              showErrorNotifier.value = false;
                              userInput = code.text;
                              Set<String> documentIds = await GetIdDocumentos
                                  .getDocumentIdsFromCollection('estancia');
                              String admin = await getAdminCredencial();
                              String empleado = await getEmpleadoCredencial();

                              if (documentIds.contains(userInput)) {
                                bool existeCliente = await clienteExistente
                                    .clienteExiste(userInput);
                                getFecha(userInput).then((fechaCliente) {
                                  if (existeCliente) {
                                    // Actualiza el código del usuario en usuario_provider.dart
                                    print("si existe antes de provider");
                                    Provider.of<UsuarioModel>(context,
                                            listen: false)
                                        .updateCode(userInput);
                                    print("si existe despues de provider");
                                    Navigator.pushNamed(context, '/menu');
                                    return; // de esta forma no se ejecuta el resto de la función
                                  } else if (!existeCliente) {
                                    handleLogicAndRedirect(fechaCliente)
                                        .then((result) {
                                      if (result == 'cuestionario') {
                                        //posible redundancia//
                                        // Actualiza el código del usuario en usuario_provider.dart
                                        print("si no existe antes de provider");
                                        Provider.of<UsuarioModel>(context,
                                                listen: false)
                                            .updateCode(userInput);
                                        print("si no existe antes de provider");
                                        Navigator.pushNamed(
                                            context, '/cuestionario');
                                      } else {
                                        print(
                                            "La fecha actual en Canarias no es anterior a la fecha del cliente");
                                      }
                                    });
                                  }
                                }).catchError((error) {
                                  print('Error: $error');
                                });
                              } else if (admin == userInput ||
                                  empleado == userInput) {
                                handleLogicAndRedirectWithoutDate(userInput)
                                    .then((result) {
                                  if (result == 'admin') {
                                    Navigator.pushNamed(context, '/admin_menu');
                                  } else if (result == 'empleado') {
                                    Navigator.pushNamed(
                                        context, '/empleado_menu');
                                  }
                                });
                              } else {
                                print('El documento no existe');
                                userNotFoundErrorNotifier.value = true;
                              }
                            }
                            loadingNotifier.value = false;
                          },
                        );
                      }),
                ),
                /*.................
                  
                  Mensaje si falla consulta http
                  
                  ''''''''''''''''''*/
                ValueListenableBuilder<bool>(
                  valueListenable: showErrorNotifier,
                  builder: (context, showError, child) {
                    if (showError) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          S.current.errorhttp,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else {
                      return SizedBox
                          .shrink(); // No muestra nada si showError es falso
                    }
                  },
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: loadingNotifier,
                  builder: (context, isLoading, child) {
                    if (isLoading) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Image.asset(
                          'assets/loading.gif',
                          width: 100,
                          height: 100,
                        ),
                      );
                    } else {
                      return const SizedBox
                          .shrink(); // No muestra nada si isLoading es falso
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*.................

Cabecera

''''''''''''''''''*/
class Cabecera extends StatelessWidget {
  const Cabecera({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: const Image(image: AssetImage('assets/CanariasLuxury.png')),
    );
  }
}
