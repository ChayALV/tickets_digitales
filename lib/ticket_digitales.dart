library ticket_digitales;

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

class PdfApi{
  static Future<File> generadorDePdfDigital() async{

    final profileImage = pw.MemoryImage(
      (await rootBundle.load('assets/logo.png')).buffer.asUint8List(),
    );
    final pdfTicket = pw.Document();

    final font = await rootBundle.load("assets/OpenSans-VariableFont_wdth,wght.ttf");
    final ttf = pw.Font.ttf(font);

    pdfTicket.addPage(
      pw.Page(
        build: (context) => pw.Center(
          child: pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Text('Quickly te apoya',style: pw.TextStyle(font: ttf,fontSize: 35)),
                  pw.Image(profileImage)
                ]
              ),
              pw.Divider(thickness: 4),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Text('Cantidad',style: pw.TextStyle(font: ttf,fontSize: 15)),
                  pw.Text('Fecha',style: pw.TextStyle(font: ttf,fontSize: 15)),
                  pw.Text('Precio',style: pw.TextStyle(font: ttf,fontSize: 15)),
                  pw.Text('Total',style: pw.TextStyle(font: ttf,fontSize: 15)),

                ]
              ),
              pw.Divider(thickness: 4),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Text('3',style: pw.TextStyle(font: ttf,fontSize: 15)),
                  pw.Text('Cobro 1',style: pw.TextStyle(font: ttf,fontSize: 15)),
                  pw.Text('\$2,000',style: pw.TextStyle(font: ttf,fontSize: 15)),
                  pw.Text('\$6,000',style: pw.TextStyle(font: ttf,fontSize: 15)),
                ]
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Text('3',style: pw.TextStyle(font: ttf,fontSize: 15)),
                  pw.Text('Cobro 2',style: pw.TextStyle(font: ttf,fontSize: 15)),
                  pw.Text('\$2,000',style: pw.TextStyle(font: ttf,fontSize: 15)),
                  pw.Text('\$6,000',style: pw.TextStyle(font: ttf,fontSize: 15)),
                ]
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Text('3',style: pw.TextStyle(font: ttf,fontSize: 15)),
                  pw.Text('Cobro 3',style: pw.TextStyle(font: ttf,fontSize: 15)),
                  pw.Text('\$2,000',style: pw.TextStyle(font: ttf,fontSize: 15)),
                  pw.Text('\$6,000',style: pw.TextStyle(font: ttf,fontSize: 15)),
                ]
              ),
              pw.Divider(thickness: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Text('TOTAL',style: pw.TextStyle(font: ttf,fontSize: 35)),
                  pw.Text('\$18,000',style: pw.TextStyle(font: ttf,fontSize: 35)),
                ]
              ),
              pw.Divider(thickness: 10),
              pw.SizedBox(height: 100),
              pw.BarcodeWidget(
                data: 'hola',
                width: 100,
                height: 100,
                barcode: pw.Barcode.qrCode(),
                drawText: false,
              ),
            ]
          )
        )
      )
    );
    return saveDocument(name: 'ticket.pdf', pdf:pdfTicket);
  }

  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf
  }) async{
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file)async{
    final url = file.path;

    await OpenFile.open(url);
  }
}