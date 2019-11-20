import 'package:flutter/material.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:printing/printing.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Printing Demo'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.print),
          tooltip: 'Print Document',
          onPressed: () {
            Printing.layoutPdf(
              onLayout: buildPdf,
            );
          },
        ),
        body: Center(
          child: const Text('Click on the print button below'),
        ),
      ),
    );
  }

  Future<List<String>> _getData() async{
    var data = await http.get('http://192.168.137.1:8080/resume/getResume/1001');
    print(data.body);
    var jsonData = json.decode(data.body);


  }


  Future<List<int>> buildPdf(PdfPageFormat format) async{

    var data = await http.get('http://resume-builder1.herokuapp.com/resume/getResume/78f45f92-b8b6-478a-b732-8fec2afaadf5',headers: {"Content-Type": "application/json"});
    print(data.body+"vidisha");
    var jsonData1 = json.decode(data.body);
    print(jsonData1["data"][0]["id"]);

    final pdf.Document doc = pdf.Document();
    String jsonData = '{"userId": 1,"id": 1,"title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit","body": "quia et suscipitsuscipit recusandae consequuntur expedita et cumreprehenderit molestiae ut ut quas totamnostrum rerum est autem sunt rem eveniet architecto"}';
    var jsonParse = json.decode(jsonData);
     Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => await Printing.convertHtml(
          format: format,
          html: '<html>'
              +'<head>'
              +'<style>''.flex-container {display: flex;background-color: DodgerBlue;}'
              +'.flex-container > div {background-color: #f1f1f1;margin: 10px;padding: 20px;font-size: 10px;}'
              +'</style>'+'</head>'
              +'<body>'
              +'<p><p style="text-transform: uppercase;font-size: 1.5em;"><b>Name : '+jsonData1["data"][0]["name"]+'</b></p>'
              +'<div class="flex-container">'
              +'<div>Email : '+jsonData1["data"][0]["id"]+'</div>'
              +'<div>DOB'+jsonData1["data"][0]["name"]+'</div>'
              +'</div>'
              +'</p>'

              +'<hr>'
                  '</body></html>',
        ));

//    doc.addPage(
//      pdf.Page(
//        pageFormat: format,
//        build: (pdf.Context context) {
//          return pdf.ConstrainedBox(
//            constraints: const pdf.BoxConstraints.expand(),
//            child: pdf.FittedBox(
//              child: pdf.Text(
//                'Hello World',
//              ),
//            ),
//          );
//        },
//      ),
//    );

    return doc.save();
  }
}