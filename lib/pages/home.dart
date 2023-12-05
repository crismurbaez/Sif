import 'package:flutter/material.dart';
import 'package:sif/pruebas/pruebas.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Card(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Prueba(),
              Text('     Ancho: ' +
                  mediaWidth.toString() +
                  ' Alto: ' +
                  mediaHeight.toString() +
                  '   '),
              Icon(Icons.star),
              Icon(Icons.backpack),
              Icon(Icons.shopify),
              Icon(Icons.delete),
              Icon(Icons.schedule),
              Icon(Icons.list),
              Icon(Icons.calendar_today),
              Icon(Icons.article),
              Icon(Icons.credit_card),
              Icon(Icons.fact_check),
              Icon(Icons.receipt),
              Icon(Icons.note),
              Icon(Icons.note_add),
              Icon(Icons.assignment),
              Icon(Icons.assignment_turned_in),
              Icon(Icons.rocket),
              Icon(Icons.rocket_launch),
              Icon(Icons.percent),
              Icon(Icons.color_lens),
              Icon(Icons.edit),
              Icon(Icons.edit_document),
              Icon(Icons.numbers),
              Icon(Icons.onetwothree),
              Icon(Icons.abc),
              Icon(Icons.inventory),
              Icon(Icons.save),
              Icon(Icons.send),
              Icon(Icons.push_pin),
              Icon(Icons.low_priority),
              Icon(Icons.auto_awesome_mosaic_rounded),
              Icon(Icons.tune),
              Icon(Icons.palette),
              Icon(Icons.style),
              Icon(Icons.description),
              Icon(Icons.production_quantity_limits),
              Icon(Icons.category),
              Icon(Icons.card_travel),
              Icon(Icons.inventory),
              Icon(Icons.insert_drive_file),
              Icon(Icons.library_books),
              Icon(Icons.backup_table),
            ],
          ),
        ),
      ),
    );
  }
}
