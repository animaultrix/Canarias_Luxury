import 'package:flutter/material.dart';

import 'package:proyecto_dam/router/app_routes.dart';

class AdminMenu extends StatelessWidget {
  const AdminMenu({super.key});
  
  @override
  Widget build(BuildContext context) {
    final menuOption = AppRoutes.menuOptionsAdmin;
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
          title: const Text('Administrador')),
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: menuOption.length,
                itemBuilder: (context, i) => ListTile(
                      title: Text(menuOption[i].name),
                      trailing: const Icon(Icons.arrow_forward_ios_outlined),                
                      onTap: () {              
                        Navigator.pushNamed(context, menuOption[i].route);
                      },
                    ),
                //_ para cuando no vaya usar argumento y __ para cuando tampoco vaya a usar el segundo argumento          
                separatorBuilder: (_, __) => const Divider(),
              ),
            ),
            const AboutListTile(
            icon: Icon(Icons.info_outline),
            applicationName: 'Canarias Luxury',
            applicationVersion: 'versión: 1.0.0',
            applicationIcon: Icon(Icons.info_outline),
            aboutBoxChildren: <Widget>[
              Text('Canarias Luxury'),
              Text('Desarrollador: Antonio Esteban Pestana Guerra'),
              Text('2023'),
            ],
          ),
          ],
        ),
      );   
  }
}