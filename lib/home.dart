import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf_reader/view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("PDF Viewer"),
      ),
      body: Center(
        child: TextButton.icon(
          label: const Text("Search for file"),
          icon: const Icon(Icons.file_open_outlined),
          onPressed: () async {
            FilePickerResult? x = await FilePicker.platform
                .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
            if (!mounted) return;
            if (x != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ViewPage(File(x.files.single.path!).path),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
