import 'package:flutter/material.dart';
//importaciones de provider
import 'package:provider/provider.dart';
import 'package:sif/Model/route.dart';
import 'package:sif/Navbar/nav_bar_drawer.dart';
import 'package:sif/Provider/provider_info.dart';
import 'package:sif/Provider/provider_navigation.dart';
import 'package:sif/firebase/firebase_get_add.dart';

//traigo página de listados de productos
import 'package:sif/pages/Products/get_products.dart';

class NavAppBar extends StatefulWidget {
  const NavAppBar({super.key});

  @override
  State<NavAppBar> createState() => NavAppBarState();
}

class NavAppBarState extends State<NavAppBar> {
  @override
  Widget build(BuildContext context) {
    //medidas de la pantalla
    // final media = MediaQuery.of(context).size;

    // se trae de provider información de los productos
    final providerInfo = Provider.of<ProviderInfo>(context, listen: false);
    // se trae del provider la ruta guardada
    final providerNav = Provider.of<ProviderNavigation>(context);
    final itemRoute = providerNav.itemRoute;

    List<DrawerItems> itemsDrawer = [
      DrawerItems('DrawerHeader', Icons.account_circle, ItemRoute.profile),
      DrawerItems('Perfil', Icons.account_circle, ItemRoute.profile),
      DrawerItems('Home', Icons.home, ItemRoute.home),
      DrawerItems(
          'Alta de productos', Icons.add_to_photos, ItemRoute.setProducts),
      DrawerItems(
          'Lista de productos', Icons.ballot_sharp, ItemRoute.getProducts),
    ];

    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Sif'),
        actions: [
          const Chip(
              label: Text('Alta de productos',
                  style: TextStyle(
                    color: Colors.amber,
                  ))),
          const Text('Alta de productos'),
          IconButton(
            tooltip: 'Alta de productos',
            icon: Icon(
              itemsDrawer[3].icon,
              color: Colors.blueGrey[900],
            ),
            onPressed: () {
              itemSelected(context, itemsDrawer[3].item);
            },
          ),
          const Text('Lista de productos'),
          IconButton(
            //en este funciona perfecta la selección,
            //sólo tengo que cambiar lo íconos y poneles nombre
            //hacer que cambien lo íconos de acuerdo a lo seleccionado en el drawer del costado
            //creo que en vez de cambiar el body, tendría que cambiar
            // toda la página, menos el drawer

            tooltip: 'Lista de productos',
            icon: Icon(
              itemsDrawer[4].icon,
              color: Colors.blueGrey[900],
            ),
            onPressed: () {
              itemSelected(context, itemsDrawer[4].item);
            },
          ),

          // PopupMenuButton<ItemRoute>(
          //   itemBuilder: (context) {
          //     return [
          //       const PopupMenuItem(
          //         // onTap:void itemSelected(context, itemsDrawer[4].item),
          //         child: Text('List Products'),
          //       ),
          //       const PopupMenuItem(
          //         child: Text('Item 2'),
          //       ),
          //       const PopupMenuItem(
          //         child: Text('Item 3'),
          //       ),
          //     ];
          //   },
          // ),
        ]);
  }
}

void itemSelected(BuildContext context, ItemRoute item) {
  //se guarda en provider lo que se elige en el menú
  final providerNav = Provider.of<ProviderNavigation>(context, listen: false);
  providerNav.setItemRoute(item);
}
//  DrawerItems(
//           'Alta de productos', Icons.add_to_photos, ItemRoute.setProducts),
//       DrawerItems(
//           'Lista de productos', Icons.ballot_sharp, ItemRoute.getProducts),
