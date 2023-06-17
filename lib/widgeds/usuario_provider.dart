import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam/models/models.dart';
/*.................

Mantiene el code (de estancia) del usuario en memoria para poder acceder a él desde cualquier parte de la aplicación.

''''''''''''''''''*/
class UsuarioProvider extends StatelessWidget {
  final Widget child;

  UsuarioProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UsuarioModel(),
      child: child,
    );
  }
}
