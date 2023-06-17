import 'package:flutter/material.dart';


class AdminTienda extends StatelessWidget {
  const AdminTienda({super.key});
  static List<Map<String, String>> menu = [
    {'name': 'Ver productos', 'route': '/admin_ver_productos'},
    {'name': 'Crear producto', 'route': '/admin_crear_producto'},
    {'name': 'Borrar producto', 'route': '/admin_borrar_producto'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Administrar tienda')),
      body: ListView.separated(
          itemCount: menu.length,
          itemBuilder: (context, i) => ListTile(
                title: Text(menu[i]['name']!),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),                
                onTap: () {              
                  Navigator.pushNamed(context, menu[i]['route']!);
                },
              ),
          //_ para cuando no vaya usar argumento y __ para cuando tampoco vaya a usar el segundo argumento          
          separatorBuilder: (_, __) => const Divider(), 
        ),
   );
  }
}