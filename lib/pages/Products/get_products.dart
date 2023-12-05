import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sif/Provider/provider_info.dart';
import 'package:data_table_2/data_table_2.dart';

class GetProducts extends StatefulWidget {
  const GetProducts({super.key});

  @override
  State<GetProducts> createState() => _GetProductsState();
}

class _GetProductsState extends State<GetProducts> {
  @override
  Widget build(BuildContext context) {
    //conexión con provider
    final providerInfo = Provider.of<ProviderInfo>(context, listen: false);
    final itemsProducts = providerInfo.products;

    //configuracion inicial de la tabla
    int numberFixedLeftColumns = 1;
    int numberFixedTopRows = 1;
    double numberMinWidth = 1000;
    const Color colorTexto = Colors.amber;

    List<bool> selected =
        List<bool>.generate(itemsProducts.length, (int index) => false);
    late final ScrollController horizontalScroll = ScrollController();

    //nombresEncabezado y nombresCeldas deben tener la MISMA!!! cantidad de elementos!!!<----- OJO
    List<String> nombresEncabezado = [
      'Nombre del producto',
      'Descripción',
      'Código de barras',
      'Precio de costo',
      'Cantidad'
    ];

    List<String> nombresCeldas = [
      'name',
      'descriptions',
      'barcode',
      'costPrice',
      'quantity'
    ];
    //////////////////////////////////////////////////////////////////////////////////

    //se crean la lista de widget para los encabezados de la tabla
    List<DataColumn2> encabezados = nombresEncabezado
        .map(
          (name) => DataColumn2(
            label: Text(
              name,
              style: const TextStyle(
                  color: colorTexto,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
        )
        .toList();

    // se crean la lista de widget para las filas de la tabla
    dataFile(index) {
      List<DataCell> filas = nombresCeldas
          .map(
            (celda) => DataCell(ListView(
              children: [
                Text(
                  itemsProducts[index][celda],
                  style: const TextStyle(color: colorTexto),
                ),
              ],
            )),
          )
          .toList();
      return filas;
    }

    // se crea la tabla
    final productsItems = DataTable2(
      horizontalScrollController: horizontalScroll,
      isVerticalScrollBarVisible: true,
      isHorizontalScrollBarVisible: true,
      fixedLeftColumns: numberFixedLeftColumns,
      fixedTopRows: numberFixedTopRows,
      minWidth: numberMinWidth,
      headingRowColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.1)),
      columns: encabezados,
      rows: List<DataRow2>.generate(
        itemsProducts.length,
        (int index) => DataRow2(
          color: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            // All rows will have the same selected color.
            if (states.contains(MaterialState.selected)) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.08);
            }
            // Even rows will have a grey color.
            if (index.isEven) {
              return Colors.grey.withOpacity(0.3);
            }
            return null; // Use default value for other states and odd rows.
          }),
          cells: dataFile(index),
          selected: selected[index],
          onSelectChanged: (bool? value) {
            setState(() {
              selected[index] = value!;
              print(value.toString() + ' ' + index.toString());
            });
          },
        ),
      ),
    );

    return Column(
      children: [
        Container(
            child: const Text(
          'Productos',
          style: TextStyle(color: colorTexto),
        )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: productsItems,
          ),
        ),
      ],
    );
  }
}
