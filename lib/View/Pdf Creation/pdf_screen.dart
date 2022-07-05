import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pak_pharma/Constants/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
class PDFScreen extends StatelessWidget {
   PDFScreen({Key? key}) : super(key: key);
   final pdf =  pw.Document();
   writeOnPdf(){
     pdf.addPage(
         pw.MultiPage(
           pageFormat: PdfPageFormat.a5,
           margin: pw.EdgeInsets.all(32),

           build: (pw.Context context){
             return <pw.Widget>  [
               pw.Header(
                   level: 0,
                   child: pw.Text("Easy Approach Document")
               ),

               pw.Paragraph(
                   text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
               ),

               pw.Paragraph(
                   text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
               ),

               pw.Header(
                   level: 1,
                   child: pw.Text("Second Heading")
               ),

               pw.Paragraph(
                   text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
               ),

               pw.Paragraph(
                   text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
               ),

               pw.Paragraph(
                   text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
               ),
             ];
           },


         )
     );
   }

   Future savePdf(BuildContext context) async {
     try {
       if (await _requestPermission(Permission.storage)) {
         Directory? documentDirectory = await getExternalStorageDirectory();
         String documentPath = "/storage/emulated/0/Documents/PakPharma";
         // List<String> paths = documentDirectory!.path.split("/");
         // for (int x = 1; x < paths.length; x++) {
         //   String folder = paths[x];
         //   if (folder != "Document") {
         //     documentPath += "/$folder";
         //   } else {
         //     break;
         //   }
         // }
         // documentPath = documentPath + "/PDF_Download";
         documentDirectory = Directory(documentPath);
         if (!await documentDirectory.exists()) {
           await documentDirectory.create(recursive: true);
         }

         print(documentPath);
         File file = File("$documentPath/example1.pdf");
         file.writeAsBytesSync(await pdf.save());
         displayToast("File saved at $documentPath", context);
         print(documentPath);
       }
       return true;
     } catch (e) {
       return false;
     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.picture_as_pdf),onPressed: ()async{
        writeOnPdf();
        await savePdf(context);
      },),
    );
  }


   Future<bool> _requestPermission(Permission permission) async {
     if (await permission.isGranted) {
       return true;
     } else {
       var result = await permission.request();
       if (result == PermissionStatus.granted) {
         return true;
       }
     }
     return false;
   }
}
