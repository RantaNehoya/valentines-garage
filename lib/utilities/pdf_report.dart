import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';


class GenerateReport extends StatelessWidget {
  GenerateReport({Key? key}) : super(key: key);

  final List t = [
    1,2,3,4,5,6,7,8,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Create PDF'),
          onPressed: (){
            createPDF(ctx: context, tasks: t);
          },
        ),
      ),
    );
  }
}

//generate pdf file
//todo
Future<void> createPDF ({required BuildContext ctx, List? tasks}) async {

  final List? lOfTasks = tasks;

  final pdf = pw.Document();

  PdfColor color = const PdfColor.fromInt(0xFFA13333);

  final image = (await rootBundle.load('assets/images/mechanic.png')).buffer.asUint8List();

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
                      pw.Positioned(
                        top: 10.0,
                        child: pw.Image(
                          pw.MemoryImage(image),
                          height: 100.0,
                          width: 100.0,
                        ),
                      ),

                      pw.Positioned(
                        bottom: 5.0,
                        child: pw.Text(
                          'Valentine\'s Garage',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            color: PdfColor.fromHex('#FFFFFF'), //white
                            font: pw.Font.courierBold(),
                            fontSize: 30.0,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                pw.Padding( //header
                  padding: const pw.EdgeInsets.all(15.0),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      //todo: bold
                      pw.Text('1'),
                      pw.Text('2'),
                      pw.Text('3'),
                      pw.Text('4'),
                      pw.Text('5'),
                    ],
                  ),
                ),

                //todo
                pw.ListView(
                  children: List.generate(
                    lOfTasks!.length, (index){
                    return pw.Container(
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(15.0),
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,

                          children: [
                            pw.Text('11'),
                            pw.Text('22'),
                            pw.Text('33'),
                            pw.Text('44'),
                            pw.Text('55'),
                          ],
                        ),
                      ),
                    );
                  },),
                ),
              ],
            ),

            pw.Positioned(
              left: 0.0,
              bottom: 0.0,
              child: pw.Container(
                color: color,
                height: 100.0,
                width: 10.0,
              ),
            ),

            pw.Positioned(
              right: 0.0,
              bottom: 0.0,
              child: pw.Container(
                color: color,
                height: 100.0,
                width: 10.0,
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
  OpenFile.open(path);
}
