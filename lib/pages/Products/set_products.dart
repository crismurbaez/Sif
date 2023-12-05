import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sif/Provider/provider_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:sif/firebase/firebase_get_add.dart';

class SetProducts extends StatefulWidget {
  const SetProducts({super.key});

  @override
  State<SetProducts> createState() => _SetProductsState();
}

class _SetProductsState extends State<SetProducts> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: FormSetProducts(),
      ),
    );
  }
}

class FormSetProducts extends StatefulWidget {
  const FormSetProducts({super.key});

  @override
  State<FormSetProducts> createState() => _FormSetProductsState();
}

class _FormSetProductsState extends State<FormSetProducts> {
  final _formKey = GlobalKey<FormState>();
  //el id primero lo tengo que traer de la base de datos guardada y sumarle,
  //o dejar que lo haga automático la base

  List camposForm = [
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

  //MODELO DE DATOS DE PRODUCTS
  Map<String, dynamic> newProduct = {
    'id': '',
    'code': '',
    'name': '',
    'category': '',
    'brand': '',
    'color': '',
    'waist': '',
    'percentage': '',
    'stockMin': '',
    'descriptions': '',
    'barcode': '',
    'costPrice': '',
    'sellPrice': '', //sin usar
    'quantity': '',
    'unitMensurement': '',
    'percentageDiscount': '',
  };

//campos de la tabla products, además de id que es autogenerada en firestore
  TextEditingController codeControl = TextEditingController();
  TextEditingController nameControl = TextEditingController();
  TextEditingController categoryControl = TextEditingController();
  TextEditingController brandControl = TextEditingController();
  TextEditingController colorControl = TextEditingController();
  TextEditingController waistControl = TextEditingController();
  TextEditingController percentageControl = TextEditingController();
  TextEditingController stockMinControl = TextEditingController();
  TextEditingController descriptionsControl = TextEditingController();
  TextEditingController barcodeControl = TextEditingController();
  TextEditingController costPriceControl = TextEditingController();
  TextEditingController sellPriceControl = TextEditingController(); //sin usar
  TextEditingController quantityControl = TextEditingController();
  TextEditingController unitMensurementControl = TextEditingController();
  TextEditingController percentageDiscountControl = TextEditingController();

  _saveStateValue() {
    setState(() {
      newProduct = {
        'id': '',
        'code': codeControl.text,
        'name': nameControl.text,
        'category': categoryControl.text,
        'brand': brandControl.text,
        'color': colorControl.text,
        'waist': waistControl.text,
        'percentage': percentageControl.text,
        'stockMin': stockMinControl.text,
        'descriptions': descriptionsControl.text,
        'barcode': barcodeControl.text,
        'costPrice': costPriceControl.text,
        'sellPrice': sellPriceControl.text, //sin usar
        'quantity': quantityControl.text,
        'unitMensurement': unitMensurementControl.text,
        'percentageDiscount': percentageDiscountControl.text,
      };
    });
  }

  @override
  void initState() {
    super.initState();
    codeControl.addListener(_saveStateValue);
    nameControl.addListener(_saveStateValue);
    categoryControl.addListener(_saveStateValue);
    brandControl.addListener(_saveStateValue);
    colorControl.addListener(_saveStateValue);
    waistControl.addListener(_saveStateValue);
    percentageControl.addListener(_saveStateValue);
    stockMinControl.addListener(_saveStateValue);
    descriptionsControl.addListener(_saveStateValue);
    barcodeControl.addListener(_saveStateValue);
    costPriceControl.addListener(_saveStateValue);
    sellPriceControl.addListener(_saveStateValue); //sin usar
    quantityControl.addListener(_saveStateValue);
    unitMensurementControl.addListener(_saveStateValue);
    percentageDiscountControl.addListener(_saveStateValue);
  }

  @override
  void dispose() {
    codeControl.dispose();
    nameControl.dispose();
    categoryControl.dispose();
    brandControl.dispose();
    colorControl.dispose();
    waistControl.dispose();
    percentageControl.dispose();
    stockMinControl.dispose();
    descriptionsControl.dispose();
    barcodeControl.dispose();
    costPriceControl.dispose();
    sellPriceControl.dispose(); //sin usar
    quantityControl.dispose();
    unitMensurementControl.dispose();
    percentageDiscountControl.dispose();
    super.dispose();
  }

  _submitFormAltaProducts() {
    //guardar en la memoria
    //del teléfono o de la pc, de forma permanente
    //ver de guardar en el disco para que funcione cuando no hay conección

    if (_formKey.currentState!.validate()) {
      final providerInfo = Provider.of<ProviderInfo>(context, listen: false);
      //agrego al provider los datos de newProduct
      providerInfo.setProducts(newProduct);
      //agrego los datos en firebase
      addProduct(newProduct);

      //se muestra mensaje en la parte inferior de la pantalla
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Producto ${newProduct['name']} guardado!')));

      //se borran todos los campos del formulario y también el estado newProduct asociado
      codeControl.clear();
      nameControl.clear();
      categoryControl.clear();
      brandControl.clear();
      colorControl.clear();
      waistControl.clear();
      percentageControl.clear();
      stockMinControl.clear();
      descriptionsControl.clear();
      barcodeControl.clear();
      costPriceControl.clear();
      sellPriceControl.clear(); //sin usar
      quantityControl.clear();
      unitMensurementControl.clear();
      percentageDiscountControl.clear();
    }
  }

  Future<void> scanBar() async {
    //si está en móvil o tableta con Android, pide permisos a la cámara y escanea.
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Para escanear códigos de barras debes hacerlo desde un dispositivo móvil')));
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Escaneamos desde un dispositivo móvil')));
        await Permission.camera.request();
        String? scanResult = await scanner.scan();
        barcodeControl.text = scanResult!;
      default:
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Para escanear códigos de barras debes hacerlo desde un dispositivo móvil')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          color: Colors.blueGrey[800],
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  //colocar todos con los expanded y hacerlo responsive
                  children: <Widget>[
                    Text(newProduct['code'],
                        style: Theme.of(context).textTheme.bodyLarge),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: formItemsDesign(
                            context,
                            Icons.numbers,
                            validateName,
                            codeControl,
                            'Código',
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: formItemsDesign(
                            context,
                            Icons.abc,
                            validateName,
                            nameControl,
                            'Nombre',
                          ),
                        )
                      ],
                    ),
                    formItemsDesign(
                      context,
                      Icons.description,
                      validateName,
                      descriptionsControl,
                      'Descripción del producto',
                    ),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Container()),
                        Expanded(flex: 1, child: Container()),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: formItemsDesign(
                            context,
                            Icons.category,
                            validateName,
                            categoryControl,
                            'Categoría',
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: formItemsDesign(
                            context,
                            Icons.star,
                            validateName,
                            brandControl,
                            'Marca',
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: formItemsDesign(
                            context,
                            Icons.palette,
                            validateName,
                            colorControl,
                            'Color',
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: formItemsDesign(
                            context,
                            Icons.style,
                            validateName,
                            waistControl,
                            'Talle',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: formItemsDesign(
                            context,
                            Icons.paid_sharp,
                            validateNumberDecimal,
                            costPriceControl,
                            'Precio de costo',
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: formItemsDesign(
                            context,
                            Icons.percent,
                            validateName,
                            percentageControl,
                            'Porcentaje de marcación',
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: formItemsDesign(
                            context,
                            Icons.percent,
                            validateName,
                            percentageDiscountControl,
                            'porcentaje de descuento',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: formItemsDesign(
                            context,
                            Icons.quora,
                            validateNumber,
                            quantityControl,
                            'Cantidad',
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: formItemsDesign(
                            context,
                            Icons.straighten,
                            validateName,
                            unitMensurementControl,
                            'Unidad de medida',
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: formItemsDesign(
                            context,
                            Icons.production_quantity_limits,
                            validateName,
                            stockMinControl,
                            'Stock Mínimo',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: FloatingActionButton(
                            onPressed: () => scanBar(),
                            shape: const CircleBorder(),
                            tooltip: 'Scanea el código',
                            // .barcode_reader
                            // .camera_alt
                            child: const Icon(Icons.barcode_reader),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: formItemsDesign(
                            context,
                            Icons.qr_code_scanner_outlined,
                            validateNumber,
                            barcodeControl,
                            'Código de barras',
                          ),
                        ),
                      ],
                    ),

                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.end,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.all(2.0),
                    //       child:
                    //     ),
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: FloatingActionButton(
                        onPressed: _submitFormAltaProducts,
                        shape: const CircleBorder(),
                        tooltip: 'Guardar producto',
                        child: const Icon(Icons.near_me),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

formItemsDesign(context, icon, validate, control, label) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Card(
        child: ListTile(
      leading: Icon(icon),
      title: TextFormField(
        style: Theme.of(context).textTheme.bodyMedium,
        validator: validate,
        controller: control,
        decoration: InputDecoration(
            labelText: label, contentPadding: EdgeInsets.all(0.00)),
      ),
      // title: item,
    )),
  );
}

String? validateName(String? value) {
  // String pattern = r'(^[a-zA-Z0-9 ]*$)';
  // RegExp regExp = RegExp(pattern);
  if (value!.isEmpty) {
    return "Debe completar este campo.";
  }
  // else if (!regExp.hasMatch(value)) {
  //   return "El nombre debe de ser a-z y A-Z";
  // }
  return null;
}

String? validateNumber(String? value) {
  String pattern = r'(^[0-9]*$)';
  RegExp regExp = RegExp(pattern);
  if (value!.isEmpty) {
    return "Debe completar este campo.";
  } else if (!regExp.hasMatch(value)) {
    return "El campo sólo debe contener dígitos del 0-9";
  }
  return null;
}

String? validateNumberDecimal(String? value) {
  String pattern = r'(^[0-9]+([,][0-9]+)?$)';
  RegExp regExp = RegExp(pattern);
  if (value!.isEmpty) {
    return "Debe completar este campo.";
  } else if (!regExp.hasMatch(value)) {
    return "El campo acepta valores con dígitos del 0-9 y decimales separados por una coma.";
  }
  return null;
}
