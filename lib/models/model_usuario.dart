import 'package:flutter/foundation.dart';
/*.................

debemos utilizar un ChangeNotifier junto con un ChangeNotifierProvider
para manejar el estado en usuario_provider.dart.(no sea null)

''''''''''''''''''*/
class UsuarioModel extends ChangeNotifier {
  String _code = '';
  
  String _nombre = '';
  
  String _pasaporteDNI = '';
  
  String _telefono = '';

  String get code => _code;

  String get nombre => _nombre;

  String get pasaporteDNI => _pasaporteDNI;

  String get telefono => _telefono;


  void updateCode(String newCode) {
    _code = newCode;
    notifyListeners();
  }
  void actualizarDatosUsuario({required String nombre, required String pasaporteDNI, required String telefono}) {
    _nombre = nombre;
    _pasaporteDNI = pasaporteDNI;
    _telefono = telefono;
    print('Datos actualizados en UsuarioModel: nombre=$nombre, pasaporteDNI=$pasaporteDNI, telefono=$telefono');
    notifyListeners();
  }
}
