import 'package:flutter/material.dart';


class AdministrarViviendas extends StatelessWidget {
  const AdministrarViviendas({super.key});
  static List<Map<String, String>> menu = [
  {'name': 'Ver viviendas', 'route': '/admin_ver_viviendas'},
  {'name': 'Crear vivienda', 'route': '/admin_crear_vivienda'},
  {'name': 'Borrar vivienda', 'route': '/admin_borrar_vivienda'}
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(            
          title: const Text('Administrar viviendas')),
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