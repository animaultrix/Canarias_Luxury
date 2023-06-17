import 'package:flutter/material.dart';

import 'package:proyecto_dam/models/models.dart';
import 'package:proyecto_dam/screens/admin_estancia.dart';
import 'package:proyecto_dam/screens/editar_usuario.dart';
import 'package:proyecto_dam/screens/screens.dart';


class AppRoutes {

  static const initialRoute = '/login';

  static  Map<String, Widget Function(BuildContext)> routes = {
    '/admin_borrar_empleado'  : ( BuildContext context ) => const AdminBorrarEmpleado(),
    '/admin_borrar_ocio'      : ( BuildContext context ) => const AdminBorrarOcio(),
    '/admin_borrar_producto'  : ( BuildContext context ) =>  AdminBorrarProducto(),
    '/admin_borrar_vivienda'  : ( BuildContext context ) => const AdminBorrarVivienda(),
    '/admin_crear_empleado'   : ( BuildContext context ) => const AdminCrearEmpleado(),
    '/admin_crear_estancia'   : ( BuildContext context ) => const CrearEstancia(),        
    '/admin_crear_ocio'       : ( BuildContext context ) => const AdminCrearOcio(),
    '/admin_crear_producto'   : ( BuildContext context ) => const AdminCrearProducto(),
    '/admin_crear_vivienda'   : ( BuildContext context ) => const AdminCrearVivienda(),
    '/admin_empleado'         : ( BuildContext context ) => const AdminEmpleado(),
    '/admin_menu'             : ( BuildContext context ) => const AdminMenu(),
    '/admin_ocio'             : ( BuildContext context ) => const AdminOcio(),
    '/admin_tienda'           : ( BuildContext context ) => const AdminTienda(),
    '/admin_ver_empleados'    : ( BuildContext context ) => const AdminVerEmpleados(),
    '/admin_ver_ocios'        : ( BuildContext context ) => const AdminVerOcios(),
    '/admin_ver_productos'    : ( BuildContext context ) => const AdminVerProductos(),
    '/admin_ver_viviendas'    : ( BuildContext context ) => const AdminVerViviendas(),
    '/admin_viviendas'        : ( BuildContext context ) => const AdministrarViviendas(),
    '/alert_screen'           : ( BuildContext context ) => const AlertScreen(),    
    '/cuestionario'           : ( BuildContext context ) =>  Cuestionario(),
    '/editar_usuario'         : ( BuildContext context ) => EditarUsuario(nombre: '', pasaporteDNI: '', telefono: '',),
    '/empleado_menu'          : ( BuildContext context ) => const EmpleadoMenu(),
    '/empleado_pedidos'       : ( BuildContext context ) => const EmpleadoPedidos(),
    '/login'                  : ( BuildContext context ) => Login(),
    '/menu_usuario'           : ( BuildContext context ) => const MenuUsuario(),
    '/menu'                   : ( BuildContext context ) => const Menu(),
    '/mi_estancia'            : ( BuildContext context ) => const MiEstancia(),
    '/ocio'                   : ( BuildContext context ) => const Ocio(),
    '/poi'                    : ( BuildContext context ) => const Poi(),
    '/store'                  : ( BuildContext context ) => const Store(),
    '/tienda'                 : ( BuildContext context ) => const Tienda(),
    '/carro'                  : ( BuildContext context ) => const Carro(),
    '/carro_ocio'             : ( BuildContext context ) => const CarroOcio(),
    '/pre_entrada'            : ( BuildContext context ) => const PreEntrada(),
    '/admin_estancia'         : ( BuildContext context ) => const AdminEstancia(),
    '/admin_ver_estancia'     : ( BuildContext context ) => const AdminVerEstancia(),
    '/admin_borrar_estancia'  : ( BuildContext context ) => const AdminBorrarEstancia(),
    '/empleado_pre_estancia'  : ( BuildContext context ) => const EmpleadoPreEstancia(),
    '/admin_ver_poi'          : ( BuildContext context ) => const AdminVerPOI(),
    '/admin_crear_poi'        : ( BuildContext context ) => const AdminCrearPOI(),
    '/admin_borrar_poi'       : ( BuildContext context ) => const AdminBorrarPOI(),
    '/admin_poi'              : ( BuildContext context ) => const AdminPOI(),
  };
  static Route<dynamic> onGenerateRoute (settings){
    print(settings);
    return MaterialPageRoute(
    builder: (context) => const AlertScreen()
  );
  }
  static final menuOptionsAdmin = <MenuOption>[
    MenuOption(route: '/admin_estancia', name: 'Administrar estancia', screen: const AdminEstancia()),
    MenuOption(route: '/admin_tienda', name: 'Administrar tienda', screen: const AdminTienda()),
    MenuOption(route: '/admin_ocio', name: 'Administrar ocio', screen: const AdminOcio()),
    MenuOption(route: '/admin_poi', name: 'Administrar POI', screen: const AdminPOI()),
    //MenuOption(route: '/admin_empleado', name: 'Administrar empleado', screen: const AdminEmpleado()),
    MenuOption(route: '/admin_viviendas', name: 'Administrar viviendas', screen: const AdministrarViviendas()),
  ];
  static final menuOptionsEmpleado = <MenuOption>[
    MenuOption(route: '/empleado_pedidos', name: 'Tienda y ocio', screen: const EmpleadoPedidos()),
    MenuOption(route: '/empleado_pre_estancia', name: 'Servicios', screen: const EmpleadoPreEstancia()),    
  ];
}