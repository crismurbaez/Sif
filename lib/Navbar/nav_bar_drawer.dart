import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sif/Model/route.dart';
import 'package:sif/Provider/provider_navigation.dart';

class NavBarDrawer extends StatefulWidget {
  const NavBarDrawer({super.key});

  @override
  State<NavBarDrawer> createState() => _NavBarDrawerState();
}

class _NavBarDrawerState extends State<NavBarDrawer> {
  @override
  Widget build(BuildContext context) {
    //medidas de la pantalla
    final media = MediaQuery.of(context).size;
    //drawerHeader lo debo hacer dinámico con los datos del usuario que se loguea.
    //cuando lo haga dinámico poner final!!
    const drawerHeader = UserAccountsDrawerHeader(
      accountName: Text(
        'Casa Claudia',
      ),
      accountEmail: Text(
        'casaclaudia@gmail.com',
      ),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage('assets/images/logo_casa_claudia.jpg'),
        radius: 70,
      ),
    );

    List<DrawerItems> itemsDrawer = [
      DrawerItems('DrawerHeader', Icons.account_circle, ItemRoute.profile),
      DrawerItems('Perfil', Icons.account_circle, ItemRoute.profile),
      DrawerItems('Home', Icons.home, ItemRoute.home),
      DrawerItems(
          'Alta de productos', Icons.add_to_photos, ItemRoute.setProducts),
      DrawerItems(
          'Lista de productos', Icons.ballot_sharp, ItemRoute.getProducts),
    ];

    // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    final drawerItems = ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: itemsDrawer.length,
      itemBuilder: (context, index) {
        //el primer elemento de drawerItems no se muestra, en su lugar se muestra drawerHeader
        //los demás elementos se muestran con normalidad
        return (index == 0)
            ? drawerHeader
            : ListTile(
                title: Text(
                  itemsDrawer[index].title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                leading: Icon(
                  itemsDrawer[index].icon,
                  color: Colors.amber,
                ),
                onTap: () {
                  itemSelected(context, itemsDrawer[index].item);
                  //si se utiliza un drawer de pantalla pequeña
                  //se activa esta opción que cierra el drawer al elegir un item
                  media.width < 950 ? Navigator.pop(context) : null;
                },
              );
      },
    );

    return Drawer(
      backgroundColor: Colors.blueGrey[900],
      child: drawerItems,
    );
  }
}

class DrawerItems {
  ItemRoute item;
  String title;
  IconData icon;

  DrawerItems(this.title, this.icon, this.item);
}

void itemSelected(BuildContext context, ItemRoute item) {
  //se guarda en provider lo que se elige en el menú
  final providerNav = Provider.of<ProviderNavigation>(context, listen: false);
  providerNav.setItemRoute(item);
}
