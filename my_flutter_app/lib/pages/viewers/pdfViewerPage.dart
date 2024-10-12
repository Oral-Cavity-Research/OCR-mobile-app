import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfViewerPage extends StatefulWidget {
  final String filename;

  PdfViewerPage({required this.filename});

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String? localFilePath;

  @override
  void initState() {
    super.initState();
    downloadAndOpenPdf(widget.filename);
  }

  Future<void> downloadAndOpenPdf(String filename) async {
    try {
      // For Android emulator, use 10.0.2.2 instead of localhost
      final url =
          Uri.parse("http://10.0.2.2:8080/Storage/ConsentForms/$filename");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Get the temporary directory to store the PDF file
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/$filename');

        // Write the PDF file to local storage
        await file.writeAsBytes(response.bodyBytes);

        // Set the local file path for PDF view
        setState(() {
          localFilePath = file.path;
        });
      } else {
        throw Exception("Failed to load PDF");
      }
    } catch (e) {
      print("Error downloading PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: localFilePath != null
          ? PDFView(
              filePath: localFilePath!,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
