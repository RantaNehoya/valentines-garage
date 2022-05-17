import 'package:flutter/material.dart';
import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

import 'package:valentines_garage/test_screen.dart';

class GenerateReport extends StatelessWidget {
  const GenerateReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Create PDF'),
          onPressed: (){
            createPDF(ctx: context, tasks: Tiles.tasks);
          },
        ),
      ),
    );
  }
}

//generate pdf file
Future<void> createPDF ({required BuildContext ctx, required List tasks}) async {

  final pdf = pw.Document();

  PdfColor color = const PdfColor.fromInt(0xFFD56B63);

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.zero,
      build: (pw.Context context){
        return pw.Stack(
          children: <pw.Widget>[
            pw.Column(
              children: <pw.Widget>[
                pw.Container(
                  color: color,
                  height: 150.0,
                  width: double.infinity,

                  child: pw.Stack(
                    alignment: pw.Alignment.center,
                    children: <pw.Widget>[

                      //logo
                      // pw.Image(
                      //   Image.asset('assets/images/mechanic.png')
                      // ),

                      pw.Text(
                        'Valentine\'s Garage',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: pw.Font.helveticaBold(),
                          fontSize: 40.0,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                pw.Center(
                  child: pw.Text('Tasks'),
                ),

                ...(List.generate(
                    Tiles.tasks.length, (index){
                      return Tiles.tasks[index];
                })),
              ],
            ),

            pw.Positioned(
              bottom: 0.0,
              child: pw.Container(
                color: color,
                height: 45.0,
                width: 800.0,
              ),
            ),
          ],
        );
      },
    ),
  );

  final String? path = (await getExternalStorageDirectory())?.path;
  final String p = '$path/report.pdf';
  final File loc = File(p);

  await loc.writeAsBytes(await pdf.save());

  launch(path: p);
}

//launch pdf
Future<void> launch ({required String path}) async {

  debugPrint('''
  *********************************************************
  $path
  *********************************************************
  ''');
  OpenFile.open(path);
}
