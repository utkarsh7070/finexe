import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class PDFViewerFromUrl extends StatefulWidget {
  final String pdfUrl; // URL of the PDF

  const PDFViewerFromUrl({super.key, required this.pdfUrl});

  @override
  State<PDFViewerFromUrl> createState() => _PDFViewerFromUrlState();
}

class _PDFViewerFromUrlState extends State<PDFViewerFromUrl> {
  String? _localFilePath; // Local path to the downloaded PDF
  bool _isLoading = true; // Loading indicator

  @override
  void initState() {
    super.initState();
    _downloadPdf(widget.pdfUrl); // Start downloading the PDF
  }

  // Future<void> _downloadPdf(String url) async {
  //   try {
  //     // Get the directory to save the file
  //     final dir = await getApplicationDocumentsDirectory();
  //     final filePath = "${dir.path}/temp_file.pdf";
  //
  //     // Download the PDF file
  //     await Dio().download(url, filePath);
  //
  //     // Update the state with the local file path
  //     setState(() {
  //       _localFilePath = filePath;
  //       _isLoading = false;
  //     });
  //   } catch (e) {
  //     // Handle download error
  //     print("Error downloading PDF: $e");
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  Future<void> _downloadPdf(String url) async {
    try {
      if (!url.startsWith("http")) {
        throw Exception("Invalid URL: $url");
      }

      // Get the directory to save the file
      final dir = await getApplicationDocumentsDirectory();
      final filePath = "${dir.path}/temp_file.pdf";

      // Download the PDF file
      final response = await Dio().download(url, filePath);

      if (response.statusCode == 200) {
        // Update the state with the local file path
        setState(() {
          _localFilePath = filePath;
          _isLoading = false;
        });
      } else {
        throw Exception("Failed to download PDF. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error downloading PDF: $e");

      // Handle download error
      setState(() {
        _localFilePath = null;
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to download PDF: $e")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return NetworkListener(
      context: context,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PDF Viewer'),
        ),
        body: _isLoading
            ? const Center(
          child: CircularProgressIndicator(), // Show loading spinner
        )
            : _localFilePath == null
            ? const Center(
          child: Text('Failed to load PDF'),
        )
            : PDFView(
          filePath: _localFilePath!,
          enableSwipe: true,
          swipeHorizontal: false,
          autoSpacing: true,
          pageFling: true,
          onRender: (pages) {
            print('PDF Rendered with $pages pages');
          },
          onError: (error) {
            print('Error loading PDF: $error');
          },
          onPageError: (page, error) {
            print('Error on page $page: $error');
          },
        ),
      ),
    );
  }
}
