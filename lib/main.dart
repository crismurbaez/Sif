// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//navbar
import 'Navbar/nav_bar_drawer.dart';
import 'Provider/provider_navigation.dart';
import 'NavBar/nav_app_bar.dart';
import 'package:sif/Provider/provider_info.dart';
//pages
import 'pages/profile.dart';
import 'pages/home.dart';
import 'pages/Products/get_products.dart';
import 'package:sif/pages/Products/set_products.dart';
//Routes models
import 'Model/route.dart';
//firebase firestore
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sif/firebase/firebase_get_add.dart';

// creo que lo que no funciona con la versión windows es firebase
// pero parece que hay soluciones para eso
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sif',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.amber) //centralizar los colores
            .copyWith(background: Colors.blueGrey[900]),
        textTheme: TextTheme(
          bodyLarge: const TextStyle(color: Colors.amber),
          bodyMedium: TextStyle(color: Colors.blueGrey[900]),
        ),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProviderNavigation()),
          ChangeNotifierProvider(create: (_) => ProviderInfo()),
        ],
        child: const MyHomePage(title: 'Sif'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //provider
    final providerInfo = Provider.of<ProviderInfo>(context, listen: false);

    //medidas de la pantalla
    final media = MediaQuery.of(context).size;

    //se piden los datos a la base de firebase,
    //si ya hay datos cargados no se piden nuevamente
    print('--------------------------------');
    print(providerInfo.products);
    print('--------------------------------');

    void setProductsFirebase() async {
      List products = await getProducts();
      products.forEach((p) {
        providerInfo.setProducts(p);
      });
    }

    if (providerInfo.products.isEmpty) {
      setProductsFirebase();
    } else {
      print(
          'ya hay información cargada, no se pedirán datos de inicio a firebase');
    }
    // se trae del provider la ruta guardada
    final providerNav = Provider.of<ProviderNavigation>(context);
    final itemRoute = providerNav.itemRoute;

    //según lo que se elija en el menú es el body que se muestra
    bodyItem() {
      switch (itemRoute) {
        case ItemRoute.home:
          return const Home();
        case ItemRoute.profile:
          return const Profile();
        case ItemRoute.getProducts:
          return const GetProducts();
        case ItemRoute.setProducts:
          return const SetProducts();
      }
    }

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50.0), child: NavAppBar()),
      drawer: media.width < 950
          ? const Drawer(
              child: NavBarDrawer(),
            )
          : null,
      body: Row(
        children: <Widget>[
          media.width > 950
              ? const Flexible(flex: 1, child: NavBarDrawer())
              : Container(
                  color: Colors.amber,
                  // child: Text('conteiner',
                  //     style: Theme.of(context).textTheme.bodyLarge),
                ),
          Flexible(
            flex: 3,
            child: bodyItem(),
          ),
        ],
      ),
    );
  }
}
