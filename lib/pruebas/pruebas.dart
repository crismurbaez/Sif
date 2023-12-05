//para ver los resultados ver en DartPad

// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';

class Prueba extends StatefulWidget {
  const Prueba({super.key});

  @override
  State<Prueba> createState() => _PruebaState();
}

class _PruebaState extends State<Prueba> {
  @override
  Widget build(BuildContext context) {
    List matriz = [
      'id',
      'code',
      'name',
      'category',
      'color',
      'percentage',
      'stockMin',
      'descriptions',
      'barcode',
      'costPrice',
      'sellPrice',
      'quantity',
      'unitMensurement',
      'percentageDiscount',
    ];

    Map<String, dynamic> newProduct = {
//     'id': '1',
//     'code': 'vds',
//     'name': 'vdsbfdb',
//     'category': 'bfdbfd',
//     'brand': 'bfdsbdsfbfdsbdfs',
//     'color': 'bfdsbfds',
//     'waist': 'bfsdbfds',
//     'percentage': 'bfdsbfds',
//     'stockMin': '68768',
//     'descriptions': '68768',
//     'barcode': '687687',
//     'costPrice': '687687',
//     'sellPrice': '876',
//     'quantity': '687',
//     'unitMensurement': '687',
//     'percentageDiscount': ' bv bv',
    };

    matriz.forEach((m) {
      newProduct[m] = '';
    });

    Map<String, TextEditingController> controllers = {};
    for (var m in matriz) {
      controllers[m + 'Control'] = TextEditingController();
    }
    final variable = 'codeControl';
    print('controllers antes: ' + controllers.toString());

    _saveStateValue() {
      setState(() {
        matriz.forEach((m) {
          newProduct[m] = controllers[m + 'Control']?.text;
        });
        print(newProduct.toString());
      });
    }

    @override
    void initState() {
      super.initState();
      newProduct.forEach((key, value) {
        value.addListener(_saveStateValue);
      });
    }

    @override
    void dispose() {
      newProduct.forEach((key, value) {
        value.dispose();
      });
      super.dispose();
    }

//FUNCIONA A MEDIAS, NO ME LO CARGA EN NEWPRODUCTS////////////////////
    return Center(
      child: Column(
        children: [
          Card(
            child: TextFormField(
              controller: controllers['codeControl'],
            ),
          ),
          Text('controllers ' + controllers['codeControl']!.text),
          Text(
              'newProduct FUNCIONA A MEDIAS, NO ME LO CARGA EN NEWPRODUCT' +
                  newProduct['code'] +
                  newProduct.toString(),
              style: Theme.of(context).textTheme.bodyMedium),
          // Text(controllers.toString()),
          FloatingActionButton(onPressed: () {
            print(controllers['codeControl']!.text);
            print(newProduct['code']);
            print(
              newProduct.toString(),
            );
            // print(
            //   controllers.toString(),
            // );
          }),
        ],
      ),
    );

    // print(newProduct);
    // final tipo = 'texto';

    // matriz.forEach((m) {
    //   newProduct[m + 'control'] = tipo + 'algo';
    // });

    // print(newProduct);

    // //iterando un map
    // newProduct.forEach((i, p) {
    //   print(i + ' ' + p);
    // });

    // List nuevamatriz = [];

    // //iterando una matriz
    // matriz.forEach((m) {
    //   nuevamatriz.add(m + 'control');
    // });

    // print('nuevamatriz ' + nuevamatriz.toString());

    // final variable = nuevamatriz[0];

    // print(variable);

    // nuevamatriz.forEach((m) {
    //   print(' ' + m + ' :' + newProduct[m]);
    // });

    // newProduct[variable] = 'un nuevo valor';

    // print(' ' + variable + ' :' + newProduct[variable]);
  }
}
