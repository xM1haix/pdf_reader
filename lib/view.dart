import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';

class ViewPage extends StatefulWidget {
  final String path;
  const ViewPage(this.path, {super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  int? pages = 0;
  int? currentPage = 0;
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  bool isReady = false;
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        centerTitle: true,
        title: Text(basename(widget.path)),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            swipeHorizontal: true,
            autoSpacing: false,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation: false,
            onRender: (pages) => setState(() {
              pages = pages;
              isReady = true;
            }),
            onError: (error) => setState(() => errorMessage = error.toString()),
            onPageError: (page, error) =>
                setState(() => errorMessage = '$page: ${error.toString()}'),
            onViewCreated: (PDFViewController x) => _controller.complete(x),
            onPageChanged: (int? p, int? t) => setState(() => currentPage = p),
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? const Center(child: CircularProgressIndicator())
                  : Container()
              : Center(child: Text(errorMessage))
        ],
      ),
    );
  }
}
